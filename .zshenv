export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

export PATH="$HOME/.ndenv/bin:$PATH"
if which ndenv > /dev/null; then eval "$(ndenv init - zsh)"; fi

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
