case "${OSTYPE}" in
darwin*)
	alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
	alias emacsclient='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
	export EDITOR='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
	;;
esac
