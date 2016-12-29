(require 'go-mode)
(require 'go-autocomplete)
(require 'go-eldoc)

(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

(add-hook 'go-mode-hook 'auto-complete)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook
	  (lambda()
	    (local-set-key (kbd "M-.") 'godef-jump)
	    (local-set-key (kbd "M-,") 'pop-tag-mark)
	    (setq indent-tabs-mode nil)    ; タブを利用
	    (setq c-basic-offset 4)        ; tabサイズを4にする
	    (setq tab-width 4)))

(set-face-attribute 'eldoc-highlight-function-argument nil
		    :underline t :foreground "green"
		    :weight 'bold)
