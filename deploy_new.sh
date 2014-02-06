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
centDeps() { #Dependencies for CentOS/Scientific linux
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
	cd
	git clone https://github.com/otland/forgottenserver.git	
}

clean() { #Remves the build directory
	rm -R build
}

tfsReplace() { #
	echo -n "Where is the TFS executable? Provide a proper directory like '/root/tfs/'"
	echo -n "make sure that you select yes when overwriting"
	read tfsDir
		cd
			cd forgottenserver/build/
			mv tfs $tfsdir
			cd
		echo -n "Done"
}






buildPre() {
	echo -e "Preparing the build environment..."
	mkdir build && cd build
		cmake ..
}

multiCoreBuild() {
	echo -e $greenText"Building on $cpuCores threads with $coreBuild processes."$none
	make -j $coreBuild
}

singleCorebuild() {
	echo -e $blueText"Building on a single thread."$none
	make
}

