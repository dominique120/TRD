#!/bin/bash

# Script by Dominique Verellen
# Made for easy manegment of nginx,mysql,php, and a few other things
greenText=$(tput setab 0; tput setaf 2)
none=$(tput sgr0)

restartStuff() {
	pkill apache2
	service nxingx restart
	service mysql restart
	service php5-fpm restart
}

startStuff() {
	pkill apache2
	service nxingx start
	service mysql start
	service php5-fpm start
}

rebootServer() {
	echo -n $greenText"Restarting NOW"$none
	reboot
}

startTfs() {
	./tfs
}

updateSoftware() {
	echo -n "This may take a bit, continue? y/n "
	read ans1
		case $ans1 in
			y)apt-get update && apt-get upgrade;;
			n);;
			*) echo "Answer 'y' or 'n'";;
		esac
}

#script starts here
echo -n "What would you like to do?"
echo -n "	1) Restart services"
echo -n "	2) Start services"
echo -n "	3) Start TFS"
echo -n "	4) Update software"
echo -n "	5) Reboot server(when done execute option 2)"
echo -n "	6) Exit"
read ans2
	case $ans2 in
		1)restartStuff;;
		2)startStuff;;
		3)startTfs;;
		4)updateSoftware;;
		5)rebootServer;;
		6);;
	esac

