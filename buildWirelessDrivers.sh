#!/bin/sh
# Build wireless drivers for LT4 21.1 on the NVIDIA Jetson TK1
if [ $(id -u) != 0 ]; then
   echo "This script requires root permissions"
   echo "$ sudo "$0""
   exit
fi

# Before running this script, you should have used
# $ menu menuconfig
# to select the wireless drivers that you wanted to compile
# For wifi, you'll need to build cfg80211, mac80211 and the
# driver for the particular device(s) you are building
cd /usr/src/kernel
make prepare
make modules_prepare
make modules SUBDIRS=net/wireless
make modules SUBDIRS=net/mac80211
make modules SUBDIRS=drivers/net/wireless


