#!/bin/bash

dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
nvim_dir=$HOME/.config/nvim/
lvim_dir=$HOME/.config/lvim/

[[ -a $HOME/bashrc_ext ]] || ln -s $dir/bashrc_ext $HOME/bashrc_ext && echo 'source $HOME/bashrc_ext' >> $HOME/.bashrc
# [[ -f $nvim_dir/init.vim ]] && mv $nvim_dir/init.vim $nvim_dir/_init.vim
# [[ -a $nvim_dir/init.vim ]] || ln -s $dir/init.vim $nvim_dir/init.vim
[[ -f $lvim_dir/config.lua ]] && mv $lvim_dir/config.lua $lvim_dir/_config.lua
[[ -a $lvim_dir/config.lua ]] || ln -s $dir/config.lua $lvim_dir/config.lua
