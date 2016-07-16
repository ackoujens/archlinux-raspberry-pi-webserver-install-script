#!/bin/bash

# ******************************************************* #
#   archlinux-raspberry-pi-webserver-install-script.sh    #
#                 written by Jens Ackou                   #
#                                                         #
#      easy install and setup of webserver packages       #
#             tested on a 8Gb micro sd card               #
# ******************************************************* #

# Remove any garbage files
sudo rm ArchLinuxARM-rpi-2-latest.tar.gz
sudo rmdir archlinux-raspberry-pi-webserver-install-script-master

# Create a home directory for your user

# Install OpenSSH
read -r -p "Do you wish to install OpenSSH?(y/N): " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
	sudo pacman -S openssh

  # Set custom SSH port?
  read -r -p "Do you wish to set a custom SSH port?(y/N): " response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
  then
  	sudo nano /etc/ssh/sshd_config
  fi

  # Take note of MAC addr (after "link/ether")
  read -r -p "Do you want to take a note of your IP(inet) & MAC address?(link/ether)(y/n): " response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
  then
  	ip addr
    read -p "Hit ENTER if you're ready to continue ..."
  fi

  echo "Running SSH service"
  sudo systemctl start sshd

  echo "Enabling SSH on startup"
  sudo systemctl enable sshd
fi

# Cleanup
sudo rmd archlinux-raspberry-pi-webserver-install-script-master.sh

# Disable seeing all commands
set +x
