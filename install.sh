# Vim config
cp .vimrc ~/

# fontconfig, i3 & termite
mkdir ~/.config
cp -r .config/* ~/.config/

# Synaptics for apple magic trackpad
sudo cp 70-synaptics.conf /etc/X11/xorg.conf.d/
