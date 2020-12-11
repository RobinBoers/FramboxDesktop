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

sudo apt install -y openbox-gnome-session obconf openbox-menu obmenu libxml2-dev
sudo apt install -y lxterminal
sudo apt install -y leafpad 
sudo apt install -y xfce4-screenshooter
sudo apt install -y xfce4-notifyd
sudo apt install -y xfce4-settings
sudo apt install -y tint2
sudo apt install -y xcompmgr
sudo apt install -y plank
sudo apt install -y pcmanfm
sudo apt install -y thunar
sudo apt install -y parole
sudo apt install -y lxappearance
sudo apt install -y nitrogen
sudo apt install -y xcompmgr
sudo apt install -y pavucontrol
sudo apt install -y volti
sudo apt install -y rofi
sudo apt install -y lxtask
sudo apt install -y elementary-xfce-icon-theme
sudo apt install -y lxqt-system-theme papirus-icon-theme
sudo apt install -y xarchiver
sudo apt install -y lxrandr

echo "Copying config files..."
sudo cp -R -f /home/pi/Frambox/applications /usr/share/
sudo cp -f /home/pi/Frambox/.bashrc /home/pi/.bashrc
sudo cp -f -R -v /home/pi/Frambox/.gtkrc-2.0-mine /home/pi
sudo cp -f -R -v /home/pi/Frambox/.gtkrc-2.0 /home/pi
sudo cp -R -f /home/pi/Frambox/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
sudo cp -R -f /home/pi/Frambox/.config/ /home/pi/
sudo cp -f /home/pi/Frambox/autostart_openbox.sh /home/pi/.config/openbox/autostart.sh

echo "Settings permissions..."
sudo chmod 777 /home/pi/Frambox
sudo chmod 777 /home/pi/.config
sudo chmod 777 /home/pi/.bashrc
sudo chmod 777 /home/pi/.config/lxterminal/lxterminal.conf
sudo chmod 777 /home/pi/.gtkrc-2.0-mine
sudo chmod 777 /etc/lightdm/lightdm-gtk-greeter.conf
sudo chmod 777 /home/pi/.config/openbox/autostart.sh
sudo chmod 777 /home/pi/.config/openbox/menu.xml
sudo chmod 777 /home/pi/.config/openbox/rc.xml
sudo chmod 777 /home/pi/.config/tint2/tint2rc

echo "Installing other packages"
sudo apt install -y python3 idle3
sudo apt install -y python3-pip
sudo apt install -y dialog
sudo apt install -y synaptic
sudo apt install -y minecraft-pi
sudo apt install -y sonic-pi
sudo apt install -y hping3
sudo apt install -y nmap
sudo apt install -y firefox-esr
sudo apt install -y python-wxgtk3.0
sudo apt install -y matchbox-keyboard
sudo apt install -y yad
sudo apt install -y cmatrix
sudo apt install -y neofetch
sudo apt install -y brightnessctl
sudo apt install -y libgtk-3-dev

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
git clone https://github.com/Botspot/pi-apps /home/pi/pi-apps

function error {
  echo -e "\e[91m$1\e[39m"
  exit 1
}

DIRECTORY="$(readlink -f "$(dirname "$0")")"

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

echo "Pi-Apps installation complete."

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
