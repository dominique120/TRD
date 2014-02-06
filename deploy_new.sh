#!/usr/bin/env bash

## Colors
greenText=$(tput setab 0; tput setaf 2)
redText=$(tput setab 0; tput setaf 1)
blueText=$(tput setab 0; tput setaf 6)
yellowText=$(tput setab 0; tput setaf 3)
none=$(tput sgr0)

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
	echo -n "Where is the TFS executable? Provide a proper directory like '/root/tfs/' if not it will fail"
	echo -n "If you already have an executable it will be renamed to tfs.old, and if tfs.old exists, it will be deleted."
	echo -n "Make sure that you select yes when overwriting."
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

singleCorebuild() { #builds singlecore
	echo -e $blueText"Building on a single thread."$none
	make
}

tfsKill() { #Until signals are added to TFS, the process must be killed.
	pkill -x tfs
}

###
### Script stars here
###


echo -n $blueText"This script will do everything necessary to put a new TFS executable in place of the current one.\n"$none \
$redText"This script is for advanced users only, use it only if you know what you are doing. \n"$none







