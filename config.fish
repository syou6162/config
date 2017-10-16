set -x LC_ALL ja_JP.UTF-8
set -x LANG ja_JP.UTF-8

set -x PATH /usr/local/bin $PATH
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

set -x EDITOR vim
set -x TERM xterm-256color

function history-merge --on-event fish_preexec
  history --save
  history --merge
end

function peco_sync_select_history
  history-merge
  peco_select_history $argv
end

function fish_user_key_bindings
  bind \c] peco_select_ghq_repository
  bind \cr peco_sync_select_history
  bind \x1b peco_z # Ctrl-[にバインドする
end

set -g theme_display_ruby no
set -g theme_display_date no
