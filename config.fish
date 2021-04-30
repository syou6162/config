set -x LC_ALL ja_JP.UTF-8
set -x LANG ja_JP.UTF-8

set -x GOPATH $HOME/go
set -x PATH /usr/local/bin $PATH
set -x PATH $GOPATH/bin $PATH
set -x PATH /usr/local/share/git-core/contrib/diff-highlight $PATH

set -x EDITOR vim
set -x TERM xterm-256color

status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (rbenv init -|psub)
status --is-interactive; and . (nodenv init -|psub)

function history-merge --on-event fish_preexec
  history --save
  history --merge
end

function peco_sync_select_history
  history-merge
  peco_select_history $argv
end

function fish_user_key_bindings
  bind \c] peco_z
  bind \cr peco_sync_select_history
end

set -g theme_display_ruby no
set -g theme_display_date no

eval (direnv hook fish)

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
