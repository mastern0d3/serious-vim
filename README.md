# Serious Vim

## Installation

Clone and link the repo.
  cd ~/.config/
  git clone git@github.com:mastern0d3/serious-vim.git
  mkdir nvim
  ln -s serious-vim/init.vim ./nvim/init.vim
 
Install Vim-Plug
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    
nvim
:PlugInstall
