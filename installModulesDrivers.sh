#!/bin/sh
# Copy wireless drivers for LT4 21.1 on the NVIDIA Jetson TK1
if [ $(id -u) != 0 ]; then
   echo "This script requires root permissions"
   echo "$ sudo "$0""
   exit
fi

# copy the driver files to ~/builtDrivers
mkdir ~/builtModulesAndDrivers
mkdir ~/builtModulesAndDrivers/builtDrivers
cd /usr/src/kernel/drivers/net/wireless/
find . -name '*.ko' | cpio -pdm ~/builtModulesAndDrivers/builtDrivers
mkdir ~/builtModulesAndDrivers/builtModules
cd /usr/src/kernel/net/wireless
find . -name '*.ko' | cpio -pdm ~/builtModulesAndDrivers/builtModules
cd /usr/src/kernel/net/mac80211
find . -name '*.ko' | cpio -pdm ~/builtModulesAndDrivers/builtModules

# copy modules and drivers to the correct places
# Install wireless drivers card
cp -rv ~/builtModulesAndDrivers/builtDrivers /lib/modules/3.10.40-g8c4516e/kernel/drivers/net/wireless
# Supplied mac80211.ko does not export __ieee80211_get_radio_led_name symbol; Newly built one does
sudo cp -v ~/builtModulesAndDrivers/builtModules/mac80211.ko /lib/modules/3.10.40-g8c4516e/kernel/net/mac80211
# Update wireless module - cfg80211.ko
sudo cp -v ~/builtModulesAndDrivers/builtModules/cfg80211.ko /lib/modules/3.10.40-g8c4516e/kernel/net/wireless

depmod -a
apt-get install linux-firmware -y
# output completion message in green
echo "$(tput setaf 2)Drivers and Modules copied. "
echo "Please Modify /etc/rc.local as appropriate$(tput setaf 7)"


