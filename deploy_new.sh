#!/usr/bin/env bash

## Colors
greenText=$(tput setab 0; tput setaf 2)
redText=$(tput setab 0; tput setaf 1)
blueText=$(tput setab 0; tput setaf 6)
yellowText=$(tput setab 0; tput setaf 3)
none=$(tput sgr0)

specBlueText=$(tput setab 7; tput setaf 4)

## Fetch number of CPUs
cpuCores=$(nproc)
## make processes to be spawned.
coreBuild=$((cpuCores + 1))

###
### Functions to simplify stuff :)
###
debianDeps() { #Dependencies for debian/ubuntu
	apt-get -y install cmake build-essential liblua5.2-dev \
		libgmp3-dev libmysqlclient-dev libboost-system-dev git
	libInstall
}
fedoraDeps() { #Dependencies for fedora
	yum -y install cmake gcc-c++ boost-devel \
		gmp-devel mysql-devel lua-devel git
	libInstall
}
centDeps() { #Dependencies for CentOS/Scientific linux / half broken because of outdated packages in sl and centos
	yum -y install cmake gcc-c++ boost-devel \
		gmp-devel mysql-devel lua-devel git
	libInstall
}
archDeps() { #Dependencies for arch linux
	pacman -Syu
	pacman -S --noconfirm base-devel git cmake lua gmp boost \
		boost-libs libmariadbclient
	libInstall
}

libInstall() { #Status indicator
	echo $greenText"Libraries and Build Tools have been installed."$none
}

fetchTfs() { #Fetch the newest TFS rev and delete the previous one if present.
	cd $HOME
	git clone https://github.com/otland/forgottenserver.git
}

cleanBuild() { #Removes the build directory
	cd $HOME/forgottenserver/
	rm -rf build
}

cleanOldRev() { #removes previous download completely
	cd $HOME
	rm -rf forgottenserver
}

#Needs lots of testing
tfsReplace() { #moves, replaces and renames
echo -n $yellowtext"FYI: "$none
echo -n $specBlueText
ls $HOME
echo -n $none
	echo -n "Where is the TFS executable?" $redText"Provide a proper directory like '/root/tfs/' if not it will fail. "$none
	echo -n "If you already have an executable it will be renamed to tfs.old, and if tfs.old exists, it will be deleted. "
	echo -n "Make sure that you select yes when overwriting. "
	echo -n "Type [break] to skip this step."
	read tfsDir
	if [[ $tfsDir = "break" ]]; then
		:
	else	
		cd
			cd $tfsDir
			mv tfs tfs.old
			cd $HOME
				cd /forgottenserver/build/
				mv tfs $tfsDir
				cd 
			echo -n "Done"
	fi
}

buildPre() { #Prepares to build
	echo -e "Preparing the build environment..."
	mkdir build && cd build
		cmake ..
}

multiCoreBuild() { #builds multicore
	echo -e $greenText"Building on $cpuCores threads with $coreBuild processes."$none
	make -j $coreBuild
}

singleCoreBuild() { #builds singlecore
	echo -e $blueText"Building on a single thread."$none
	make
}

tfsKill() { #Until signals are added to TFS, the process must be killed.
	pkill -x tfs
}

###
### Script stars here
###
#check if root
if [[ $EUID -ne 0 ]]; then
	echo "You must be root to use this script, press enter to exit."
	read end
	exit 1
fi

#Notice to the user
echo -n $blueText"This script will do everything necessary to put a new TFS executable in place of the current one."\n$none \
$redText"This script is for advanced users only, use it only if you know what you are doing."\n$none "This script does all its operations in the home folder of the current user, beware!"\n\n

#Clean old revs
echo -n "Should the script clean the home folder for any previous revs? [y] or [n]"
read ans1_1
	if [[ $ans1_1 = "y" ]]; then 
		cleanOldRev
	elif [[ $ans1_1 = "n" ]]; then
		:
	else
		echo -n "Answer [y] or [n]"
	fi
	
#Clone new rev
#Might add a check to see if forgottenserver dir exists.
echo -n "Should the script clone the newest TFS rev?"
read ans2_1
	if [[ $ans2_1 = "y" ]]; then
		fetchTfs
	elif [[ $ans2_1 = "n" ]]; then
		:
	else
		echo -n "Answer [y] or [n]"
	fi

#Install and update deps
echo -n "Should the script update and fetch the dependencies? [y] or [n]"
read ans3_1
	if [[ $ans3_1 = "y" ]]; then
		echo -n "What OS is this? [CentOS, Scientific Linux, Ubuntu, Debian, Arch Linux]"
		read ans3_2
			if [[ $ans3_2 = "CentOS" ]] || [[ $ans3_2 = "Scientific Linux" ]]; then
				centDeps
			elif [[ $ans3_2 = "Debian" ]] || [[ $ans3_2 = "Ubuntu" ]]; then
				debianDeps
			elif [[ $ans3_2 = "Fedora" ]]; then
				fedoraDeps
			elif [[ $ans3_2 = "Arch Linux" ]]; then
				archDeps
			else
				echo -n "Pick a valid OS"
				:
			fi
	elif [[ $ans3_1 = "n" ]]; then
		:
	fi
	
	
#Clean the dir for previous builds
echo -n "Should the script clean for previous builds? [y] or [n]"
read ans4_1
	if [[ $ans4_1 = "y" ]]; then
		cleanBuild
	elif [[ $ans4_1 = "n" ]]; then
		:
	else
		echo -n "Enter a valid answer"
	fi
	
#build the executable
echo -n "Should the script build the new rev? [y] or [n]"
read ans5_1
	if [[ $ans5_1 = "y" ]]; then
	buildPre
		echo -n "Should it build with multicore support?"
		read ans5_2
			if [[ $ans5_2 = "y" ]]; then
				multiCoreBuild
			elif [[ $ans5_2 = "n" ]]; then
				singleCoreBuild
			else 
				echo -n "Provide a valid answer [y] or [n]"
				:
			fi
	elif [[ $ans5_1 = "n" ]]; then
		echo -n "Continuing..."
	else
		echo -n "Provide a valid answer [y] or [n]"
	fi

#Replacing the existing executable
echo -n "This step will kill the existing TFS(if its open). Type [enter] to proceed, type [skip] to skip"
read ans6_1
	if [[ $ans6_1 = "enter" ]]; then
		tfsKill
		tfsReplace
	elif [[ $ans6_1 = "skip" ]]; then
		:
	else
		echo -n "type something correctly"
		:
	fi
