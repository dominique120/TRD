#!/bin/bash

# Script by Dominique Verellen

# This script pulls the tfs repo, compiles and pulls the dapatapck repo

tfsKill() {
	pkill -USR1 tfs
}

tfsRename() {
	cd /home/FORGOTTENSERVER-ORTS
	mv tfs tfs.old
}

tfsCompile() {
	cmake ..
	make
}

tfsRestart() {
	cd /home
	sh start
}

main() {
		tfsKill
		tfsRename
	cd /home
	rm -Rf forgottenserver
	git pull git@github.com:otland/forgottenserver.git
	cd forgottenserver
	mkdir build 
	cd build
		tfsCompile
	mv tfs /home/FORGOTTENSERVER-ORTS/tfs
	cd home
	git pull git@github.com:PrinterLUA/FORGOTTENSERVER-ORTS.git
}

main
tfsRestart