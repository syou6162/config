fpath=(~/.zsh/functions/Completion/ $fpath)
autoload -U compinit
compinit

PROMPT="%/%% "
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt append_history
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history datals
#cd -[tab]で補完
setopt auto_pushd
setopt correct
setopt list_packed
#コマンドのスペルチェック
setopt correct

bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

autoload colors
colors
case ${UID} in
  0)
  PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
  *)
  PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac

unset LSCOLORS
case "${TERM}" in
  xterm)
  export TERM=xterm-color
  ;;
  kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
  cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
  'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

case "${TERM}" in
  kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
  'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac

zstyle ':completion:*:default' menu select=1
alias ls='ls -G'

# git branch data
_set_env_git_current_branch() {
    GIT_CURRENT_BRANCH=$( git name-rev HEAD --name-only ) &> /dev/null
}

_update_rprompt () {
    if test -z $GIT_CURRENT_BRANCH
    then
        RPROMPT=" [%~]"
    else
        RPROMPT=" [%~ ("$GIT_CURRENT_BRANCH")]"
    fi
}

# alias for stats functions
for f in mean sd max min
do
    alias $f="R --vanilla --slave -e \"x <- scan('stdin', quiet=TRUE); cat($f(x), fill=TRUE)\""
done

eval "$(direnv hook zsh)"

setopt no_global_rcs

autoload -U add-zsh-hook 2>/dev/null || return

function peco-branch () {
  local branch=$(git branch -a | peco | tr -d ' ' | tr -d '*')
  if [ -n "$branch" ]; then
    if [ -n "$LBUFFER" ]; then
      local new_left="${LBUFFER%\ } $branch"
    else
      local new_left="$branch"
    fi
    BUFFER=${new_left}${RBUFFER}
    CURSOR=${#new_left}
  fi
}
zle -N peco-branch
bindkey '^x^b' peco-branch

function peco-select-from-git-status(){
  git status --porcelain | \
    peco | \
    awk -F ' ' '{print $NF}' | \
    tr '\n' ' '
}

function peco-insert-selected-git-files(){
  LBUFFER+=$(peco-select-from-git-status)
  CURSOR=$#LBUFFER
  zle reset-prompt
}

zle -N peco-insert-selected-git-files
bindkey "^x^s" peco-insert-selected-git-files

function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | \
	      eval $tac | \
	      awk '!a[$0]++' | \
	      peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-kill() {
  kill `ps aux | peco | awk '{print $2}'`
}

function peco-kill-kill() {
  kill -KILL `ps aux | peco | awk '{print $2}'`
}

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function open-idea-from-git-grep () {
  IDEA_PATH="/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea"
  DST_PATH=$(git grep -n $1 | grep -v "[0-9]:\s*//" | peco | awk -v pwd="$(pwd)" -F ":" '{print "--line " $2 " " pwd "/" $1}')
  if [ ${#DST_PATH} -ne 0 ]; then
    zsh -c "$IDEA_PATH $DST_PATH"
  fi
}
