# FramboxDesktop

This is a script that installs my personal desktop. Its a lightweight desktop for the Raspberry Pi, built with openbox, lightdm & tint2.
This was first a part of the FramboxOS script, but I decided I wanted it to be its own, standalone script.

The custom desktop uses:

- lightdm
- openbox (gnome session)
- leafpad
- lxterminal
- xfce4-notifyd (notifications)
- tint2 (menu bar)
- plank (dock)
- pcmanfm (file manager + desktop)
- lxappearance
- pavucontrol 
- volti
- brightnessctl
- rofi (CTRL+Space)

It also installs:

- Minecraft Pi
- nmap
- hping3
- Python pip + IDLE
- Sonic Pi
- Matchbox Keyboard
- Firefox ESR
- Synaptic
- cmatrix
- neofetch
- Pi-Apps
- bfetch (<https://gitlab.com/nautilor/bfetch/-/tree/master>)

The original custom openbox theme is made by Brodan, and is called Adwaita Revisited.
I editted it a bit to make it look better.
<https://www.gnome-look.org/p/1179478>

It uses a static IP: 192.168.1.36

## Installation

- Start with a fresh Raspbian Lite image

```bash
wget https://raw.githubusercontent.com/RobinBoers/FramboxDesktop/master/install.sh
sudo chmod 777 install.sh && sudo chmod a+x install.sh
sudo ./install.sh
```

- Reboot
