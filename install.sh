# Vim config
cp .vimrc ~/

# Install vim plugins
git clone https://github.com/wavded/vim-stylus.git ~/.vim/pack/plugins/start/vim-stylus
git clone https://github.com/digitaltoad/vim-pug.git ~/.vim/pack/plugins/start/vim-pug
git clone https://github.com/posva/vim-vue.git ~/.vim/pack/plugins/start/vim-vue
git clone https://github.com/jiangmiao/auto-pairs.git ~/.vim/pack/plugins/start/auto-pairs
git clone https://github.com/vim-syntastic/syntastic.git ~/.vim/pack/plugins/start/synaptics

# fontconfig, i3 & termite
mkdir ~/.config
cp -r .config/* ~/.config/

# Synaptics for apple magic trackpad
sudo cp 70-synaptics.conf /etc/X11/xorg.conf.d/

# Eslint config
cp .eslintrc.* ~/
