#!/bin/bash

echo "Cloning repos..."
cd /home/pi
sudo rm -f -R Frambox
git clone --recursive --depth 1 --branch master https://github.com/RobinBoers/FramboxDesktop /home/pi/Frambox

echo "Installing desktop..."

sudo apt update
sudo apt -y upgrade

sudo apt install -y lightdm
sudo apt install -y xorg xinit

# Window Manager
sudo apt install -y openbox openbox-gnome-session obconf openbox-menu obmenu libxml2-dev parcellite xdotool

# System
sudo apt install -y lxterminal leafpad pcmanfm synaptic
sudo apt install -y xfce4-notifyd scrot gpicview

# UI
sudo apt install -y tint2 plank rofi
sudo apt install -y xcompmgr

# Control stuff (dont know what to call it)
sudo apt install -y pavucontrol volti brightnessctl

# Utilities
sudo apt install -y lxappearance lxappearance-obconf lxtask lxrandr xarchiver

# Themes
sudo apt install -y elementary-xfce-icon-theme lxqt-system-theme papirus-icon-theme

echo "Copying config files..."
sudo cp -R -f /home/pi/Frambox/applications /usr/share/
sudo cp -f /home/pi/Frambox/home.desktop /home/pi/Desktop/home.desktop
sudo cp -f /home/pi/Frambox/.bashrc /home/pi/.bashrc
sudo cp -f -R -v /home/pi/Frambox/.gtkrc-2.0.mine /home/pi
sudo cp -f -R -v /home/pi/Frambox/.gtkrc-2.0 /home/pi
sudo cp -R -f /home/pi/Frambox/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
sudo cp -R -f /home/pi/Frambox/.config/ /home/pi/
sudo cp -R -f /home/pi/Frambox/.themes/ /home/pi/

echo "Installing nord color scheme"
cd /home/pi
sudo rm -f -R Nord
git clone --recursive --depth 1 --branch master https://github.com/arcticicestudio/nord-xresources /home/pi/Nord
xrdb -merge /home/pi/Nord/src/nord

echo "Settings permissions..."
sudo chmod 777 /home/pi/Frambox
sudo chmod 777 /home/pi/.config
sudo chmod 777 /home/pi/.bashrc
sudo chmod 777 /home/pi/.config/lxterminal/lxterminal.conf
sudo chmod 777 /home/pi/.gtkrc-2.0-mine
sudo chmod 777 /etc/lightdm/lightdm-gtk-greeter.conf
sudo chmod -R 777 /home/pi/.config

echo "Installing other packages"
# Python
sudo apt install -y python3 idle3 python3-pip python python-pip

# Programs
sudo apt install -y minecraft-pi sonic-pi firefox-esr parole

# Commandline tools
sudo apt install -y hping3 nmap cmatrix neofetch

# Keyboard for touchscreens
sudo apt install -y matchbox-keyboard

# Dependecies for other programs / tools
sudo apt install -y yad python-wxgtk3.0 libgtk-3-dev dialog python-tk

# Used in the menu and logoff script
sudo pip3 install guizero
sudo pip3 install gobject

echo "Installing bfetch"
cd Frambox
sudo mv bfetch /usr/bin
cd /usr/bin
sudo chmod 755 bfetch
cd /home/pi
echo "Installed bfetch"

echo "Installing frambox-info"
cd Frambox
sudo mv frambox-info /usr/bin
cd /usr/bin
sudo chmod 755 frambox-info
cd /home/pi
echo "Installed frambox-info"

echo "Installing Pi-Apps"
cd /home/pi
sudo rm -f -R pi-apps
git clone https://github.com/Botspot/pi-apps /home/pi/pi-apps

function error {
  echo -e "\e[91m$1\e[39m"
  exit 1
}

DIRECTORY="/home/pi/pi-apps"

#remove annoying YAD icon browser launcher
sudo rm -f /usr/share/applications/yad-icon-browser.desktop

echo "Creating menu button..."
mkdir -p /home/pi/.local/share/applications
echo "[Desktop Entry]
Name=Pi Apps
Comment=Raspberry Pi App Store for open source projects
Exec=${DIRECTORY}/gui
Icon=${DIRECTORY}/icons/logo.png
Terminal=false
Type=Application
Categories=Utility;" > /home/pi/.local/share/applications/pi-apps.desktop

echo "Adding Desktop shortcut..."
cp -f /home/pi/.local/share/applications/pi-apps.desktop /home/pi/Desktop/pi-apps.desktop

echo "Creating Settings menu button..."
echo "[Desktop Entry]
Name=Pi Apps Settings
Comment=Configure Pi-Apps or create an App
Exec=${DIRECTORY}/settings
Icon=${DIRECTORY}/icons/logo.png
Terminal=false
Type=Application
Categories=Settings;" > /home/pi/.local/share/applications/pi-apps-settings.desktop

echo "Creating autostarted updater..."
mkdir -p /home/pi/.config/autostart
echo "[Desktop Entry]
Name=Pi Apps Updater
Exec=${DIRECTORY}/updater onboot
Icon=${DIRECTORY}/icons/logo.png
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true
Hidden=false
NoDisplay=false" > /home/pi/.config/autostart/pi-apps-updater.desktop

mkdir -p "${DIRECTORY}/data"
cd "${DIRECTORY}/data"
mkdir -p installed-packages preload settings status update-status
cd $HOME

#hide template file by default
echo "template" > "${DIRECTORY}/data/hidelist"

#hide duplicates if running in twisteros
if [ -f /usr/local/bin/twistver ];then
  echo "BalenaEtcher
Chromium Media Edition
CommanderPi
Box86
Discord
piKiss
Retropie
Scrcpy
Windows 10 Theme
Chromium Widevine
Back to Chromium v78" >> "${DIRECTORY}/data/hidelist"
fi

echo "Creating settings if they don"\'"t exist..."
"${DIRECTORY}/settings" refresh

echo "Preloading app list..."
"${DIRECTORY}/preload" &>/dev/null

cd /home/pi
sudo chmod -R ugo+rwx pi-apps
echo "Pi-Apps installation complete."

echo "Enabling SSH..."
sudo systemctl enable ssh
# sudo cp -f /home/pi/Frambox/ssh /boot/ssh

echo "Setting up static IP and hostname..."
sudo cp -f /home/pi/Frambox/dhcpcd.conf /etc/dhcpcd.conf
sudo cp -f /home/pi/Frambox/hostname /etc/hostname

echo "Please choose a new password: (for pi user)"
passwd pi

sudo apt autoremove
sudo chmod -R 777 /home/pi

sudo cp -f /home/pi/Frambox/hosts /etc/hosts
echo "Done. Please reboot now"
