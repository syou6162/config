set -x LC_ALL ja_JP.UTF-8
set -x LANG ja_JP.UTF-8

set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
set -x XDG_CONFIG_HOME $HOME/.config

set -x PATH $HOME/.local/bin $PATH

set -x EDITOR vim
set -x TERM xterm-256color

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

switch (uname -m)
case arm64
  status --is-interactive; and eval (/opt/homebrew/bin/brew shellenv)
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
  set -x PATH /usr/local/bin $PATH
case x86_64
  status --is-interactive; and eval (/usr/local/bin/brew shellenv)
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
end

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

abbr --add update_pr 'claude --model opus --debug --print "/cccsc:syou6162:claude-code-commands:update_pr_title_and_description" --resume'

# __fish_enable_bracketed_paste は有効にしてもよいが、Claude Code立ち上げた後はシェルとして使い回すことがない & コマンドの編集に邪魔なので意図的に入れていない
abbr --add cc '__fish_disable_bracketed_paste; claude --model opus'

# Claude Code サンドボックス実行用エイリアス
abbr --add scc '__fish_disable_bracketed_paste; sandbox-exec -f ~/.files/sandbox/safe_claude_code.sb -D TARGET_DIR="$PWD" -D HOME_DIR="$HOME" claude --dangerously-skip-permissions --disallowedTools "Bash(gcloud:*),Bash(gh:*),Bash(gsutil:*),Bash(bq:*)"'
abbr --add semantic_commit 'sandbox-exec -f ~/.files/sandbox/safe_claude_code.sb -D TARGET_DIR="$PWD" -D HOME_DIR="$HOME" claude --dangerously-skip-permissions --disallowedTools "Bash(gcloud:*),Bash(gh:*),Bash(gsutil:*),Bash(bq:*)" --debug --print "/cccsc:syou6162:claude-code-commands:semantic_commit" --resume'

# fisherが入っていない場合、インストールする
# また、fisherのプラグインも同様にインストールする
if not functions -q fisher
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
  fisher update
end

# https://iterm2.com/documentation-shell-integration.html
source ~/.iterm2_shell_integration.fish

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

abbr -a gl "glow -p -w0"

set -gx FZF_DEFAULT_OPTS '--exact --bind "enter:become(vim {})" --preview "bat --color=always --style=header,grid --line-range :300 {}" --preview-window "up:80%:border"'

# based on https://github.com/k1LoW/git-wt
# pecoで移動できるようにしたいから、自分で書いている
function git --wraps git
    if test "$argv[1]" = "wt"
        if test (count $argv) -eq 1
            # git wt のみ → peco で選択して移動
            set -l dir (command git worktree list | peco | awk '{print $1}')
            test -n "$dir" && cd "$dir"
        else
            # それ以外は git-wt にそのまま渡す
            set -l result (command git wt $argv[2..] | string collect)
            set -l exit_code $status
            if test $exit_code -eq 0 -a -d "$result"
                cd "$result"
            else
                printf "%s\n" "$result"
                return $exit_code
            end
        end
    else
        command git $argv
    end
end

# git wt <branch> completion for fish
function __fish_git_wt_branches
    command git-wt __complete "" 2>/dev/null | string match -rv '^:'
end

function __fish_git_wt_needs_branch
    set -l cmd (commandline -opc)
    test (count $cmd) -eq 2 -a "$cmd[2]" = "wt"
end

complete -c git -n '__fish_git_wt_needs_branch' -f -a '(__fish_git_wt_branches)'
