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

# Update database
sudo pacman -Syy

# Full system upgrade
sudo pacman -Su

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

# Install APACHE
read -r -p "Do you wish to install APACHE?(y/N): " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
	sudo pacman -S apache

  # Set custom APACHE port?
  read -r -p "Do you wish to set a custom APACHE port?(y/N): " response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
  then
  	sudo nano /etc/httpd/conf/httpd.conf
  fi

  echo "Running APACHE service"
  sudo systemctl start httpd

  echo "Enabling APACHE on startup"
  sudo systemctl enable httpd
fi

# Cleanup
sudo rmd archlinux-raspberry-pi-webserver-install-script-master.sh

# Disable seeing all commands
set +x
