(require 'helm-config)
(helm-mode 1)
(require 'helm-ag)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-t") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-do-ag-this-file)
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

(helm-autoresize-mode 1)

(setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
(setq helm-ag-thing-at-point 'symbol)

;; list-faces-displayで色を確認できる
(set-face-background 'helm-selection "magenta")
(set-face-foreground 'helm-buffer-file "white")
(set-face-foreground 'helm-ff-file "white")
