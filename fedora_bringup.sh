#!/bin/bash -x
# (C) 2017 Ezhil Language Foundation
# 
# This script brings up a basic Fedora24/later, machine 
# to a usable configuration involving a basic Tamil fonts,
# remove VNC server with Xwindows. It has Python, Git, Gcc
# other tools for development.
# 
if [ $# -lt 2 ] 
then
   echo "Usage: fedora_bringup.sh <username> <password>"
   exit -1
fi
if [ $# -gt 2 ]
then
    EXTRA=1
else
    EXTRA=0
fi

USERNAME=$1
PASSWORD=$2
dnf install git
if [ $EXTRA -gt 0 ]
then
    dnf install llvm
fi
dnf install gcc
dnf install gtk+
dnf install python2
dnf install python3
dnf install vnc
dnf install pygobject
dnf install pygtk
dnf install pygobject3 python3-gobject
dnf install tigervnc-server -y
adduser  $USERNAME
echo $PASSWORD | passwd $USERNAME
dnf install metacity
dnf install gnome3
dnf install gnome2
dnf install Xorg
dnf install fonttools
dnf install fontmatrix
dnf install python3-gobject
dnf install pygobject3
dnf install gtk3
dnf install gtk3-engines
dnf install glade3
dnf install glade

######## goto devel directory #########
cd ~$USERNAME/devel
export TEST_EZHIL_DEVELOPMENT=1
git clone https://github.com/Ezhil-Language-Foundation/Ezhil-Lang.git
git clone https://github.com/Ezhil-Language-Foundation/Ezhil-Linux.git
git clone https://github.com/pyinstaller/pyinstaller.git

sudo pip install ezhil
sudo pip3 install ezhil

cd Ezhil-Lang && python setup.py sdist build && python setup.py sdist install

cd ~$USERNAME/devel
git clone https://github.com/pyinstaller/pyinstaller.git
cd pyinstaller && python setup.py sdist build && python setup.py sdist install

####### install Tamil fonts #######
git clone https://github.com/thamizha/tamil-fonts.git
cd tamil-fonts
chmod +x ./ubuntu_install.sh
mkdir /usr/share/fonts/truetype
./ubuntu_install.sh

shutdown -r now
