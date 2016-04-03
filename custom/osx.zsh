case "${OSTYPE}" in
darwin*)
	alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
	export EDITOR=emacsclient
	;;
esac
