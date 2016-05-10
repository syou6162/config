(defun my-make-scratch (&optional arg)
 (interactive)
 (progn
   ;; "*scratch*" を作成して buffer-list に放り込む
   (set-buffer (get-buffer-create "*scratch*"))
   (funcall initial-major-mode)
   (erase-buffer)
   (when (and initial-scratch-message (not inhibit-startup-message))
     (insert initial-scratch-message))
   (or arg (progn (setq arg 0)
                  (switch-to-buffer "*scratch*")))
   (cond ((= arg 0) (message "*scratch* is cleared up."))
         ((= arg 1) (message "another *scratch* is created")))))

(defun my-buffer-name-list ()
 (mapcar (function buffer-name) (buffer-list)))

(add-hook 'kill-buffer-query-functions
   ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
         (function (lambda ()
                     (if (string= "*scratch*" (buffer-name))
                         (progn (my-make-scratch 0) nil)
                       t))))

(add-hook 'after-save-hook
;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
         (function (lambda ()
                     (unless (member "*scratch*" (my-buffer-name-list))
                       (my-make-scratch 1)))))

(defun insert-braces (arg)
  "A pair of brace is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "{}")
      (backward-char 1))))

(defun insert-brackets (arg)
  "A pair of square bracket is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "[]")
      (backward-char 1))))

(defun insert-parens (arg)
  "A pair of round bracket is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "()")
      (backward-char 1))))

(defun insert-double-quotation (arg)
  "A pair of double quatation is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "\\\"\\\"")
      (backward-char 1))))

(defun insert-single-quotation (arg)
  "A pair of single quatation is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "\\\'\\\'")
      (backward-char 1))))

(defun insert-angle (arg)
  "A pair of angle bracket is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "<>")
      (backward-char 1))))

(defun insert-dollars (arg)
  "A pair of dollars is insert automatically."
  (interactive "p")
  (let()
    (progn
      (insert "\\\$\\\$")
      (backward-char 1))))

(defun insert-braces-region (&optional open close)
  (interactive)
  (if mark-active
      (let ((beg (region-beginning))
	    (end (region-end)))
	(save-excursion
	  (goto-char end)
	  (insert (or close "}"))
	  (goto-char (if (> (point) beg)
			 ;;逆からmarkされた時がおかしくなる時の対策
			 beg
		       (point)))
	  (insert (or open "{"))))
    (insert "}")))

(defun insert-brackets-region ()
  (interactive)
  (if mark-active
      (insert-braces-region "[" "]")
    (insert "]")))

(defun insert-parens-region ()
  (interactive)
  (if mark-active
      (insert-braces-region "(" ")")
    (insert ")")))

(defun insert-double-quotation-region ()
  (interactive)
  (if mark-active
      (insert-braces-region "\"" "\"")
    (insert "\"")))

(defun insert-single-quotation-region ()
  (interactive)
  (if mark-active
      (insert-braces-region "\'" "\'")
    (insert "\'")))

(defun insert-dollars-region ()
  (interactive)
  (if mark-active
      (insert-braces-region "\$" "\$")
    (insert "\$")))

(defun join (sep list)
  (mapconcat 'identity list sep))

(defun insert-timestamp ()
  (interactive)
  (insert (format-time-string "@%H:%M")))
