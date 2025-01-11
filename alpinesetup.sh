#!/bin/sh

set -x
set -e

top_dir=$(pwd)

doas setup-xorg-base

# dwm
doas apk add make gcc musl-dev libx11-dev libxft-dev libxinerama-dev

# st
doas apk add ncurses font-dejavu

echo "What is the username"

read username

doas adduser $username wheel
doas adduser $username video
doas adduser $username input

touch /home/$username/.xinitrc

echo "exec dwm" > /home/$username/.xinitrc

mkdir /home/$username/suckless

cd /home/$username/suckless

wget https://dl.suckless.org/dwm/dwm-6.5.tar.gz
tar -xvzf dwm-6.5.tar.gz
cd dwm-6.5
doas make clean install

cd ..

wget https://dl.suckless.org/tools/dmenu-5.3.tar.gz
tar -xvzf dmenu-5.3.tar.gz
cd dmenu-5.3
doas make clean install

cd ..

wget https://dl.suckless.org/st/st-0.9.2.tar.gz
tar -xvzf st-0.9.2.tar.gz
cd st-0.9.2
doas make clean install

cd ..
