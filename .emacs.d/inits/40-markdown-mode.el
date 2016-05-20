(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

(defun markdown-insert-timestamp ()
  (interactive)
  (insert (format-time-string "@%H:%M")))

(define-key markdown-mode-map "\C-c\C-m" 'markdown-insert-timestamp)

(defun markdown-open-with-marked2 (&optional arg)
  (interactive)
  (progn
    (shell-command-to-string (concat "open -a Marked\\ 2 " buffer-file-name))
    nil))

(defun markdown-blogsync-push (&optional arg)
  (interactive)
  (progn
    (shell-command-to-string (concat "blogsync push " buffer-file-name))
    (let ((content (buffer-substring-no-properties (point-min) (point-max))))
      (string-match "^URL: \\(.*\\)$" content)
      (shell-command-to-string (concat "open -g " (match-string 1 content))))
    (find-alternate-file buffer-file-name)
    nil))
