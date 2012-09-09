;; http://d.hatena.ne.jp/hakutoitoi/20090208/1234069614
;; anythinはgpopup-elとauto-completeに依存している

(require 'auto-complete)
(global-auto-complete-mode t)

(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)

(setq anything-sources (list anything-c-source-buffers
                             anything-c-source-bookmarks
			     anything-c-source-info-pages
                             anything-c-source-file-name-history
			     anything-c-source-emacs-commands
			     anything-c-source-emacs-functions
			     anything-c-source-mac-spotlight
			     anything-c-source-emacs-functions-with-abbrevs
                             anything-c-source-locate))

(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)

(define-key global-map (kbd "C-t") 'anything)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
