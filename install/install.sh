#!/bin/bash

cat /etc/modules |sed s'/lirc_dev//'|sed s'/lirc_rpi gpio_in_pin=23 gpio_out_pin=22//' >/tmp/modules
cp -f /tmp/modules /etc/modules
echo "lirc_dev" >> /etc/modules
echo "lirc_rpi gpio_in_pin=23 gpio_out_pin=22" >> /etc/modules
apt-get -f install lirc
cat <<EOF > /etc/lirc/hardware.conf
########################################################
# /etc/lirc/hardware.conf
#
# Arguments which will be used when launching lircd
LIRCD_ARGS="--uinput --listen=127.0.0.1"

# Don't start lircmd even if there seems to be a good config file
# START_LIRCMD=false

# Don't start irexec, even if a good config file seems to exist.
# START_IREXEC=false

# Try to load appropriate kernel modules
LOAD_MODULES=true

# Run "lircd --driver=help" for a list of supported drivers.
DRIVER="default"
# usually /dev/lirc0 is the correct setting for systems using udev
DEVICE="/dev/lirc0"
MODULES="lirc_rpi"

# Default configuration files for your hardware if any
LIRCD_CONF=""
LIRCMD_CONF=""
########################################################
EOF
echo "IR Receiver : GPIO 4"
echo "IR LED : GPIO 3"
echo "YOU NEED TO REBOOT to make IR works!"

