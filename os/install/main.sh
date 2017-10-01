#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Installs\n\n"

"./$(get_os)/main.sh"
./nvm.sh
./npm.sh

print_in_purple "\n   Vim Plugins\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"
