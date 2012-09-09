(setq load-path
      (append
       (mapcar 
	(lambda (filename) (expand-file-name filename) )
	(list "~/config/.emacs.d/elisp/init-loader"
	      "~/config/.emacs.d/elisp"
	      "~/config/.emacs.d/elisp/paredit"
	      "~/config/.emacs.d/elisp/clojure-mode"
	      "~/config/.emacs.d/elisp/popup-el"
	      "~/config/.emacs.d/elisp/auto-complete"
	      "~/config/.emacs.d/elisp/ddskk"
	      "~/config/.emacs.d/elisp/ESS/lisp"
	      "~/config/.emacs.d/elisp/ruby-mode"
	      "~/config/.emacs.d/elisp/cperl-mode"
	      "~/config/.emacs.d/elisp/dabbrev-expand-multiple"
	      "~/config/.emacs.d/elisp/markdown-mode"
	      "~/config/.emacs.d/elisp/emacs-flymake"
	      "~/config/.emacs.d/elisp/emacswiki.org"))
       load-path))

(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
