curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
rm ./installer.sh
curl https://raw.githubusercontent.com/changcui/vim-config/master/init.vim > ~/.vimrc

mkdir ~/.config/nvim
echo -e "set runtimepath^=~/.vim runtimepath+=~/.vim/after \nlet &packpath = &runtimepath \nsource ~/.vimrc" > ~/.config/nvim/init.vim
echo -e "alias vi=\'nvim\' \n alias vim=\'nvim\'" >> ~/.bashrc

pip install pylint neovim

# TODO install nvim auto 
