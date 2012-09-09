(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

(require 'clojure-mode)

;; http://paste.lisp.org/display/120878
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (paredit-mode +1)
	    (show-paren-mode 1)
	    (setq minor-mode-overriding-map-alist
		  `((paredit-mode
		     ,@(remove (cons ?\C-j 'paredit-newline)
			       paredit-mode-map))))))

(setenv "PATH"
	(concat '"~/bin:" (getenv "PATH")))

(setq load-path
      (cons "~/config/.emacs.d/elisp/nrepl.el" load-path))

(require 'nrepl)

