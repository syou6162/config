set -x LC_ALL ja_JP.UTF-8
set -x LANG ja_JP.UTF-8

set -x GOPATH $HOME/go
set -x PATH /usr/local/bin $PATH
set -x PATH $GOPATH/bin $PATH
set -x PATH /usr/local/share/git-core/contrib/diff-highlight $PATH

set -x EDITOR vim
set -x TERM xterm-256color

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
status is-login; and pyenv init --path | source

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
set -U theme_display_cmd_duration no

eval (direnv hook fish)

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

function kubeswitch
  kubectl config get-contexts | peco --initial-index=1 --prompt='kubectl config use-context > ' |  sed -e 's/^\*//' | awk '{print $1}' | read line
  if test $line
    kubectl config use-context $line
  else
    # キャンセルされた場合はスキップ
  end
end

if status --is-interactive
    set -g fish_user_abbreviations
    # kubectl関係
    abbr --add k "kubectl"
    abbr --add kg "kubectl get"
    abbr --add kd "kubectl describe"
    abbr --add ks "kubeswitch"

    # others
    abbr --add p "env https_proxy=localhost:3128"
    abbr --add pk "env https_proxy=localhost:3128 kubectl"
end
