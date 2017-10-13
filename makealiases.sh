#!/bin/sh

# $HOME以下に設定ファイル群へのシンボリックリンクを貼る
for filename in emacs.d zshrc zshenv Rprofile gitconfig gitignore tmux.conf vimrc tigrc
do
  if [ ! -e $HOME/.$filename ]; then
    ln -s `pwd`/.$filename $HOME/.$filename
  fi
done
