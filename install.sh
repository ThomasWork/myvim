#!/bin/bash
#不能使用pwd，它返回的是执行命令（的窗口）时所在的路径
#dirname $0，返回当前执行脚本的父目录
bashPath=$(cd `dirname $0`; pwd)
ln -s $bashPath ~/.vim
ln -s $bashPath/.vimrc ~/.vimrc
