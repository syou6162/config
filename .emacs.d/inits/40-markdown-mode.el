(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

(defun markdown-insert-timestamp ()
  (interactive)
  (insert (format-time-string "@%H:%M")))

(define-key markdown-mode-map "\C-c\C-m" 'markdown-insert-timestamp)
