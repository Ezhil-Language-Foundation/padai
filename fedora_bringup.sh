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
dnf -y install git
if [ $EXTRA -gt 0 ]
then
    dnf -y install llvm
fi
dnf -y install gcc
dnf -y install gtk+
dnf -y install python2
dnf -y install python3
dnf -y install vnc
dnf -y install pygobject
dnf -y install pygtk
dnf -y install pygobject3 python3-gobject
dnf -y install tigervnc-server -y
adduser  $USERNAME
echo $PASSWORD | passwd $USERNAME
dnf -y install metacity
dnf -y install gnome3
dnf -y install gnome2
dnf -y install Xorg
dnf -y install fonttools
dnf -y install fontmatrix
dnf -y install python3-gobject
dnf -y install pygobject3
dnf -y install gtk3
dnf -y install gtk3-engines
dnf -y install glade3
dnf -y install glade

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
