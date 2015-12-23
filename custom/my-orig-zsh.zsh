fpath=(~/.zsh/functions/Completion/ $fpath)
autoload -U compinit
compinit
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

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

export PATH=/opt/local/bin:$PATH:/opt/local/sbin:/usr/local/bin:$HOME/bin
export MANPATH=/opt/local/share/man:$MANPATH
#export C_INCLUDE_PATH=/usr/local/include
#export CPLUS_INCLUDE_PATH=/usr/local/include
#export CPLUS_INCLUDE_PATH=/opt/local/include
#export CPLUS_INCLUDE_PATH=/usr/local/include/boost-1_38

# for gxpc
export PATH=$HOME/bin/gxp3:$PATH
export PATH=$HOME/bin/kansit:$PATH

export LIBRARY_PATH=/opt/local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/local/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/opt/local/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/opt/local/include:$CPLUS_INCLUDE_PATH
export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib
export BOOST_ROOT=/opt/local/include/boost:$BOOST_ROOT

zstyle ':completion:*:default' menu select=1
alias ls='ls -G'

# export PATH=/opt/local/share/texmf:$PATH

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

source ~/perl5/perlbrew/etc/bashrc
