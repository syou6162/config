(setq auto-mode-alist (append '(("\\.sh$" . sh-mode)) auto-mode-alist))

(add-hook 'sh-mode-hook
          '(lambda ()
	     (setq sh-basic-offset 2)
	     (setq sh-indentation 2)))
