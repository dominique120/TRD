#!/usr/bin/env bash

## Colors
greenText=$(tput setab 0; tput setaf 2)
redText=$(tput setab 0; tput setaf 1)
blueText=$(tput setab 0; tput setaf 6)
yellowText=$(tput setab 0; tput setaf 3)
none=$(tput sgr0)


###
### Functions to simplify stuff :)
###

debianDeps() {
	apt-get -y install cmake build-essential liblua5.2-dev \
		libgmp3-dev libmysqlclient-dev libboost-system-dev
	libInstall
}

fedoraDeps() {
	yum -y install cmake gcc-c++ boost-devel \
		gmp-devel mysql-devel lua-devel
	libInstall
}

centDeps() {
	yum -y install cmake gcc-c++ boost-devel \
		gmp-devel mysql-devel lua-devel
	libInstall
}

archDeps() {
	pacman -Syu
	pacman -S --noconfirm base-devel git cmake lua gmp boost boost-libs libmariadbclient
}

libInstall() {
	echo $greenText"Libraries and Build Tools... Installed"$none
}

genBuild() {
## Fetch number of CPUs
cpuCores=$(nproc)
## make processes to be spawned.
coreBuild=$((cpuCores + 1))

	echo "Building..."
	mkdir build && cd build
	cmake ..
		echo "Build on $cpuCores threads with $coreBuild processes? (experimental but builds faster) [y or n]:"
		read ans1_4
			if [[ $ans1_4 = "y" ]]; then
				echo -e $greenText"Building on $cpuCores threads with $coreBuild processes."$none
				make -j $coreBuild
			elif [[ $ans1_4 = "n" ]]; then
				echo -e $blueText"Building on a single thread."$none
				make
			else
				echo -e $redText"Answer y or n"$none
			fi				
}
# Clean used before compile to remove the build directory in case there has been a previous build

clean() {
	rm -R build
}

tfsReplace() {
echo -n "Where is the TFS executable? Provide a proper directory like '/root/tfs/'"
echo -n "make sure that you select yes when overwrinting"
read tfsDir
	cd
	cd forgottenserver/build/
	mv tfs $tfsdir
	cd
	echo -n "Done"
}

###
### Script starts here
###

#check if root
if [[ $EUID -ne 0 ]]; then
	echo "You must be root to use this script, press enter to exit."
	read end
	exit 1
fi

#OS dependencies and other stuff
echo "Chose your Operating System. {Supported: Debian, Ubuntu, Fedora, ArchLinux, CentOS or Scientific Linux"
read ans1 
			
if [[ $ans1 = "Fedora" ]]; then
	echo -n "Should the script install dependencies? [y or n]:"
	read ans1_1
	if [[ $ans1_1 = "y" ]]; then
		fedoraDeps
	elif [[ $ans1_1 = "n" ]]; then
		echo "Continuing..."
		:
	else
		echo "Answer 'y' or 'n' "
	fi
elif [[ $ans1 = "CentOS" ]] || [[ $ans1 = "Scientific Linux" ]]; then
	echo -n "Should the script install dependencies? [y or n]:"
	read ans1_1
	if [[ $ans1_1 = "y" ]]; then
		centDeps
	elif [[ $ans1_1 = "n" ]]; then
		echo "Continuing..."
		:
	else
		echo "Answer 'y' or 'n' "
	fi	
elif [[ $ans1 = "Debian" ]] || [[ $ans1 = "Ubuntu" ]]; then
	echo -n "Should the script install dependencies? [y or n]:"
	read ans1_1
	if [[ $ans1_1 = "y" ]]; then
		debianDeps
	elif [[ $ans1_1 = "n" ]]; then
		echo "Continuing..."
		:
	else
		echo "Answer 'y' or 'n' "
	fi
		fi	
elif [[ $ans1 = "ArchLinux" ]]; then
	echo -n "Should the script install dependencies? [y or n]:"
	read ans1_1
		if [[ $ans1_1 = "y" ]]; then
			archDeps
		elif [[ $ans1_1 = "n" ]]; then
			:
		else
			echo "Answer 'y' or 'n' "
		fi	
		fi		
else
	echo "Pick a valid OS, options are case sensitive."	
	:			


#Clean
echo -n "Should the script clean the directory for any previous builds? [y or n]"
read ans1_6
	if [[ $ans1_6 = "y" ]]; then
		clean		
	elif [[ $ans1_6 = "n" ]]; then
		echo "Continuing..."
		:		
	else
		echo "Answer 'y' or 'n'"		
	fi

#Compiling here
echo -n "Ready to build? y or n: "
read ans1_2
	if [[ $ans1_2 = "y" ]]; then
		genBuild
	elif [[ $ans1_2 = "n" ]]; then
		:
	else
		echo "Answer y or n"
	fi
	
#This part specifies where TFS is located.
echo -n "Should the script replace the existing TFS? NOTE that the server must be off, if its on, should the script kill it?(SIGNAL | Save & Exit)"
read tfsKill
	if [[ $tfsKill = "y" ]]; then
		#Find TFS proces PID and send Signal
		
	elif [[ $tfsKill = "n" ]]; then
		:
	else
		echo "Answer y or n"
	fi

echo -n "Should the script move the new compiled TFS to the existing directory and replace it?"
read ans2_1
	if [[ $ans2_1 = "y" ]]
		tfsReplace
	elif [[ $ans2_1 = "n" ]]
		echo -n "Continuing"
		:
	else
		echo "Answer y or n"
	fi

	

	

