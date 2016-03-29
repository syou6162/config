;; http://d.hatena.ne.jp/hakutoitoi/20090208/1234069614
(defalias 'perl-mode 'cperl-mode)

(setq auto-mode-alist 
      (append '(("\\.\\(pl\\|pm\\|cgi\\|t\\)$" . cperl-mode)) 
	      auto-mode-alist))
(setq cperl-indent-level 4)
(add-hook 'cperl-mode-hook
	  (lambda ()
	    (define-key cperl-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)
	    (define-key cperl-mode-map "\C-c\C-v" 'cperl-perldoc)
	    (define-key cperl-mode-map "{" 'insert-braces)
	    (define-key cperl-mode-map "(" 'insert-parens)
	    (define-key cperl-mode-map "\"" 'insert-double-quotation)
	    (define-key cperl-mode-map "[" 'insert-brackets)
	    (define-key cperl-mode-map "}" 'insert-braces-region)
	    (define-key cperl-mode-map ")" 'insert-parens-region)
	    (define-key cperl-mode-map "]" 'insert-brackets-region)
	    (define-key cperl-mode-map "\"" 'insert-double-quotation-region)
	    (define-key cperl-mode-map "\'" 'insert-single-quotation-region)))

;; モジュールソースバッファの場合はその場で、
;; その他のバッファの場合は別ウィンドウに開く。
(put 'perl-module-thing 'end-op
     (lambda ()
       (re-search-forward "\\=[a-zA-Z][a-zA-Z0-9_:]*" nil t)))
(put 'perl-module-thing 'beginning-op
     (lambda ()
       (if (re-search-backward "[^a-zA-Z0-9_:]" nil t)
           (forward-char)
         (goto-char (point-min)))))

(defun perldoc-m ()
  (interactive)
  (let ((module (thing-at-point 'perl-module-thing))
        (pop-up-windows t)
        (cperl-mode-hook nil))
    (when (string= module "")
      (setq module (read-string "Module Name: ")))
    (let ((result (substring (shell-command-to-string (concat "perldoc -m " module)) 0 -1))
          (buffer (get-buffer-create (concat "*Perl " module "*")))
          (pop-or-set-flag (string-match "*Perl " (buffer-name))))
      (if (string-match "No module found for" result)
          (message "%s" result)
        (progn
          (with-current-buffer buffer
            (toggle-read-only -1)
            (erase-buffer)
            (insert result)
            (goto-char (point-min))
            (cperl-mode)
            (toggle-read-only 1)
            )
          (if pop-or-set-flag
              (switch-to-buffer buffer)
            (display-buffer buffer)))))))

(defun perl-eval (beg end)
  "Run selected region as Perl code"
  (interactive "r")
  (save-excursion
    (shell-command-on-region beg end "perl")))

(require 'perltidy)
