case "${OSTYPE}" in
  darwin*)
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
    export EDITOR=emacsclient
    alias jn='cd ~/Dropbox/jupyter_notebooks;jupyter notebook'
    ;;
esac
