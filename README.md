buildJetsonModules
==================

This is an example on how to build modules and drivers for NVIDIA Jetson TK1.
This example will build the Intel 'iwlwifi' driver and wireless modules.
The example is specifically for the Linux for Tegra LT4 21.1 Nov, 2014 release, but should work in other situations.

This example is not an exhaustive missive on how to build modules and drivers, but more as a "I only need a module or driver for a particular application. I don't want to recompile the whole kernel, I just want the module/driver needed. Give me an example".

This example also assumes that you are comfortable with Ubuntu file layouts and paths. 
Please read through the shell files and adjust for your own purpose.

====== INSTRUCTIONS ==============

IMPORTANT: All shell files must be run as root

NOTE: You may want to open configureIwlWifi.txt for guidance of navigating the menuconfig menus before the first step.

### Install prerequisites and specify kernel modules and drivers to be built
$ sudo ./prepareDriver.sh
# Build the modules and drivers
# Close configureIwlWifi.txt if open
# Close any open applications; this next bit seems to be persnickety at times
$ sudo ./buildWirelessDrivers.sh
# Install new Modules and Drivers
$ sudo installModuelsDrivers.sh
# At this point new modules and drivers should be installed appropriately
# In order to access the mini PCIe wireless card, GPIO pin 191 must be set
# The stock kernel sets this to off on boot, so you must set it up yourself in /etc/rc.local
# An example rc.local file is in this repository
$ sudo gedit /etc/rc.local

# Add this next bit at the end before the exit 0 instruction

<ADD THIS>
# Enable GPIO 191 so that wireless works with mini PCIe cards
echo 191 > /sys/class/gpio/export;
echo out > /sys/class/gpio/gpio191/direction;
echo 1 > /sys/class/gpio/gpio191/value;
# Reload the wifi driver for the Intel mini PCIe card
modprobe -r iwlwifi;
modprobe iwlwifi;
</ADD THIS>

# Make sure to save the file
# At this point everything should be installed. Reboot the Jetson


