set -x LC_ALL ja_JP.UTF-8
set -x LANG ja_JP.UTF-8

set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

set -x EDITOR vim
set -x TERM xterm-256color

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

switch (uname -m)
case arm64
  status --is-interactive; and eval (/opt/homebrew/bin/brew shellenv)
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
case x86_64
  status --is-interactive; and eval (/usr/local/bin/brew shellenv)
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
end

set -x TMUX_SHELL (which fish)

status --is-interactive; and pyenv init --path | source

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
set -g theme_powerline_fonts no

eval (direnv hook fish)

# fisherが入っていない場合、インストールする
# また、fisherのプラグインも同様にインストールする
if not functions -q fisher
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
  fisher update
end

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
end
