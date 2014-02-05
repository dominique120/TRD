#!/bin/bash

mkdir boostfiles && cd boostfiles

wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-date-time-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-debuginfo-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-filesystem-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-graph-1.44.0-1.el6.x86_64.rpm
#wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-graph-mpich2-1.44.0-1.el6.x86_64.rpm
#wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-graph-openmpi-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-iostreams-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-math-1.44.0-1.el6.x86_64.rpm
#wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-mpich2-1.44.0-1.el6.x86_64.rpm
#wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-mpich2-devel-1.44.0-1.el6.x86_64.rpm
#wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-mpich2-python-1.44.0-1.el6.x86_64.rpm
#wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-openmpi-1.44.0-1.el6.x86_64.rpm
#wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-openmpi-devel-1.44.0-1.el6.x86_64.rpm
#wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-openmpi-python-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-program-options-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-python-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-regex-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-serialization-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-signals-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-static-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-system-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-test-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-thread-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-wave-1.44.0-1.el6.x86_64.rpm


rpm -Uvh boost*rpm

wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-1.44.0-1.el6.x86_64.rpm
wget http://downloads.naulinux.ru/pub/NauLinux/6x/x86_64/Extras/RPMS/Projects/OpenFlow/boost-devel-1.44.0-1.el6.x86_64.rpm

rpm -Uvh boost-1.*rpm
rpm -Uvh boost-devel*rpm