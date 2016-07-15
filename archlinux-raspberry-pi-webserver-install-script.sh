#!/bin/bash
# Login as root
# username: root
# password: root

# Change the root password
# passwd root
# <enter a new password>

# Enable DHCP for an easy wired internet connection
# dhcpcd eth0

# Install GIT to start using GitHub shell scripts
# pacman -S git-core

# Install sudo for more permissive actions
# pacman -S sudo

# Create a new user
# adduser
# passwd <username>

# Put new user in sudoers file
# nano /etc/sudoers
# scroll down to "User privilege specification" and add the line
# <username> ALL=(ALL) ALL
# ctrl+x to exit nano
# Enter 'Y' to overwrite the sudoers file

# Login into new user
# logout
# username: <newuser>
# password: <newuserpassword>



# Create a home directory for your user

# See all commands
set -x

# Remove any garbage files
sudo rm ArchLinuxARM-rpi-2-latest.tar.gz

# Install OpenSSH
read CHOICE "Do you want to install OpenSSH?(y/n): "
if [ "$CHOICE" == "y" ]; then
	sudo pacman -S openssh

  # Set custom SSH port?
  read CHOICE "Do you want to set a custom port?(y/n): "
  if [ "$CHOICE" == "y" ]; then
  	sudo nano /etc/ssh/sshd_config
  fi

  # Take note of MAC addr (after "link/ether")
  read CHOICE "Do you want to take a note of the MAC address?(y/n): "
  if [ "$CHOICE" == "y" ]; then
  	ipaddr
  fi
  read -p "Hit ENTER if you're ready to continue ..."

  echo "Running SSH service"
  sudo systemctl start sshd

  echo "Enabling SSH on startup"
  sudo systemctl enable sshd
fi


# Disable seeing all commands
set +x
