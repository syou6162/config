#!/bin/sh

# $HOME以下に設定ファイル群へのシンボリックリンクを貼る
for filename in emacs.d zshrc zshenv Rprofile gitconfig gitexclude tmux.conf vimrc tigrc ctags tern-project ideavimrc
do
  if [ ! -e $HOME/.$filename ]; then
    ln -s `pwd`/.$filename $HOME/.$filename
  fi
done

if [ ! -e $HOME/.config/fish/config.fish ]; then
  ln -s `pwd`/config.fish $HOME/.config/fish/config.fish
fi
