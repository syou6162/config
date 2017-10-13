#!/bin/sh

# $HOME以下に設定ファイル群へのシンボリックリンクを貼る
for filename in emacs.d zshrc zshenv Rprofile gitconfig gitignore tmux.conf vimrc tigrc
do
    if [ ! -e $HOME/.$filename ]; then
	ln -s `pwd`/.$filename $HOME/.$filename
    fi
done

# oh-my-zsh用にシンボリックリンクを貼る
for file in custom/*
do
    if [ ! -e $HOME/.oh-my-zsh/$file ]; then
	ln -s `pwd`/$file $HOME/.oh-my-zsh/$file
    fi
done
