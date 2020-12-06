#!/bin/bash

echo "Cloning repos..."
git clone  https://github.com/RobinBoers/FramboxDesktop /home/pi/FramboxDesktop

echo "Installing desktop..."

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y lightdm

sudo apt-get install -y openbox obconf openbox-menu obmenu
sudo apt-get install -y lxterminal
sudo apt-get install -y leafpad  
sudo apt-get install -y xfce4-notifyd
sudo apt-get install -y tint2
# sudo apt-get install -y dolphin
# sudo apt-get install -y xcompmgr cairo-dock
sudo apt-get install -y pcmanfm
sudo apt-get install -y lxappearance
sudo apt-get install -y nitrogen
sudo apt-get install -y xcompmgr
sudo apt-get install -y pavucontrol
sudo apt-get install -y volti
sudo apt-get install -y rofi
sudo apt-get install -y lxtask
sudo apt-get install -y elementary-xfce-icon-theme
sudo apt-get install -y xarchiver
sudo apt-get install -y lxrandr

echo "Copying config files..."
sudo cp -f /home/pi/Frambox/.bashrc /home/pi/.bashrc
sudo cp -R -f /home/pi/Frambox/lxterminal.conf /home/pi/.config/lxterminal/lxterminal.conf
sudo cp -R -f /home/pi/Frambox/.gtkrc-2.0-mine /home/pi/.gtkrc-2.0-mine
sudo cp -R -f /home/pi/Frambox/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
sudo cp -R -f /home/pi/Frambox/.config/ /home/pi/
sudo cp -f /home/pi/Frambox/autostart_openbox.sh /home/pi/.config/openbox/autostart.sh

echo "Settings permissions..."
sudo chmod 777 /home/pi/.bashrc
sudo chmod 777 /home/pi/.config/lxterminal/lxterminal.conf
sudo chmod 777 /home/pi/.gtkrc-2.0-mine
sudo chmod 777 /etc/lightdm/lightdm-gtk-greeter.conf
sudo chmod 777 /home/pi/.config/openbox/autostart.sh
sudo chmod 777 /home/pi/.config/openbox/menu.xml
sudo chmod 777 /home/pi/.config/openbox/rc.xml
sudo chmod 777 /home/pi/.config/tint2/tint2rc

echo "Installing other packages"
sudo apt-get install -y python3 idle3
sudo apt-get install -y python3-pip
sudo apt-get install -y dialog
sudo apt-get install -y synaptic
sudo apt-get install -y minecraft-pi
sudo apt-get install -y sonic-pi
sudo apt-get install -y hping3
sudo apt-get install -y nmap
sudo apt-get install -y firefox-esr
sudo apt-get install -y python-wxgtk3.0
sudo apt-get install -y matchbox-keyboard

echo "Enabling SSH..."
sudo systemctl enable ssh
# sudo cp -f /home/pi/Frambox/ssh /boot/ssh

echo "Setting up static IP and hostname..."
sudo cp -f /home/pi/Frambox/dhcpcd.conf /etc/dhcpcd.conf
sudo cp -f /home/pi/Frambox/hostname /etc/hostname

echo "Please choose a new password: (for pi user)"
passwd pi

sudo cp -f /home/pi/Frambox/hosts /etc/hosts
echo "Done. Please reboot now"
