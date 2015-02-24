(require 'clojure-mode)
(autoload 'inf-clojure "inf-clojure" "Run an inferior Clojure process" t)
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

(add-hook 'clojure-mode-hook 'inf-clojure-minor-mode)

;; http://paste.lisp.org/display/120878
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (paredit-mode 1)
	    (show-paren-mode 1)
	    (setq minor-mode-overriding-map-alist
		  `((paredit-mode
		     ,@(remove (cons ?\C-j 'paredit-newline)
			       paredit-mode-map))))))
