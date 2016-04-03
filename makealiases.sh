#!/bin/sh

# $HOME以下に設定ファイル群へのシンボリックリンクを貼る
for filename in emacs.d zshrc Rprofile gitconfig gitignore tmux.conf
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

if [ ! -e $HOME/config/.emacs.d/elisp/set-perl5lib.el ]; then
    wget http://svn.coderepos.org/share/lang/elisp/set-perl5lib/set-perl5lib.el -O $HOME/config/.emacs.d/elisp/set-perl5lib.el
fi
