#!/bin/bash

dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
nvim_dir=$HOME/.config/nvim/

[[ -a $HOME/bashrc_ext ]] || ln -s $dir/bashrc_ext $HOME/bashrc_ext
[[ -f $nvim_dir/init.vim ]] && mv $nvim_dir/init.vim $nvim_dir/_init.vim
[[ -a $nvim_dir/init.vim ]] || ln -s $dir/init.vim $nvim_dir/init.vim

