#!/bin/bash

dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
nvim_dir=$HOME/.config/nvim/
lvim_dir=$HOME/.config/lvim/

# Install dependencies
bash  $dir/install_deps.bash

# Get the tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Link config directories
[[ -e $HOME/bashrc_ext ]] || ln -s $dir/bashrc_ext $HOME/bashrc_ext && echo 'source $HOME/bashrc_ext' >> $HOME/.bashrc
[[ -e $HOME/.tmux.conf ]] || ln -s $dir/tmux.conf $HOME/.tmux.conf
[[ -f $nvim_dir/init.vim ]] && mv $nvim_dir/init.vim $nvim_dir/_init.vim
[[ -e $nvim_dir/init.vim ]] || ln -s $dir/init.vim $nvim_dir/init.vim
[[ -f $lvim_dir/config.lua ]] && mv $lvim_dir/config.lua $lvim_dir/_config.lua
[[ -e $lvim_dir/config.lua ]] || ln -s $dir/lvim/config.lua $lvim_dir/config.lua
[[ -e $lvim_dir/lua ]] || ln -s $dir/lvim/lua $lvim_dir/lua

