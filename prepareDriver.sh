#!/bin/sh
# Prepare to build some drivers on the NVIDIA Jetson TK1
if [ $(id -u) != 0 ]; then
   echo "This script requires root permissions"
   echo "$ sudo "$0""
   exit
fi


# Load prerequisites
apt-add-repository universe
apt-get update
apt-get install libncurses5-dev -y
# Get the kernel source for LT4 21.1
cd /usr/src/
wget http://developer.download.nvidia.com/embedded/L4T/r21_Release_v5.0/source/kernel_src.tbz2
# Decompress
tar -xvf kernel_src.tbz2
cd kernel
# Get the kernel configuration file
zcat /proc/config.gz > .config
# And begin editing
make menuconfig


