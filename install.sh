#!/bin/bash
#不能使用pwd，它返回的是执行命令（的窗口）时所在的路径
#dirname $0，返回当前执行脚本的父目录

if [ -f ~/.vimrc ]; then
	if [ -L ~/.vimrc ]; then
		echo ".vimrc is a symbolic link to a file"
	else
		echo ".vimrc is a file"
	fi
	mv ~/.vimrc ~/.vimrc.bak
	echo ".vimrc was renamed to .vimrc.bak"
fi

if [ -d ~/.vim ]; then
	if [ -L ~/.vim ]; then
		echo ".vim is a symbolic link to a folder"
	else
		echo ".vim is a folder"
	fi
	mv ~/.vim ~/.vim.bak
	echo ".vim was renamed to .vim.bak"
fi

bashPath=$(cd `dirname $0`; pwd)
ln -s $bashPath ~/.vim
ln -s $bashPath/.vimrc ~/.vimrc
