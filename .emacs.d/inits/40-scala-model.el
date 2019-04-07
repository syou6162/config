(require 'scala-mode)
(require 'ensime)

;(;; require 'company)
;

;; (set-face-attribute 'company-tooltip nil
;; 		    :foreground "black" :background "lightgrey")
;; (set-face-attribute 'company-tooltip-common nil
;; 		    :foreground "black" :background "lightgrey")
;; (set-face-attribute 'company-tooltip-common-selection nil
;; 		    :foreground "white" :background "steelblue")
;; (set-face-attribute 'company-tooltip-selection nil
;; 		    :foreground "black" :background "steelblue")
;; (set-face-attribute 'company-preview-common nil
;; 		    :background nil :foreground "lightgrey" :underline t)
;; (set-face-attribute 'company-scrollbar-fg nil
;; 		    :background "orange")
;; (set-face-attribute 'company-scrollbar-bg nil
;; 		    :background "gray40")

;; ;; C-n, C-pで補完候補を次/前の候補を選択
;; (define-key company-active-map (kbd "C-n") 'company-select-next)
;; (define-key company-active-map (kbd "C-p") 'company-select-previous)
;; (define-key company-search-map (kbd "C-n") 'company-select-next)
;; (define-key company-search-map (kbd "C-p") 'company-select-previous)

;; ;; C-sで絞り込む
;; (define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; ;; TABで候補を設定
;; (define-key company-active-map (kbd "C-i") 'company-complete-selection)

;(add-hook 'ensime-mode-hook 'company-mode)

;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-mode-map (kbd "C-;") 'helm-company)
;;      (define-key company-active-map (kbd "C-;") 'helm-company)))


;(setq ensime-use-helm t)

;;;Use auto-complete for ensime
;(setq ensime-completion-style 'company)
;(setq ensime-completion-style 'auto-complete)

(defun scala/enable-eldoc ()
  "Show error message or type name at point by Eldoc."
  (setq-local eldoc-documentation-function
	      #'(lambda ()
		  (when (ensime-connected-p)
		    (let ((err (ensime-print-errors-at-point)))
		      (or (and err (not (string= err "")) err)
			  (ensime-print-type-at-point))))))
  (eldoc-mode +1))

;; (defun scala/ac-trigger-key-command (orig-fun &rest args)
;;   (if ensime-mode
;;       (let ((ac-sources '(ac-source-ensime-completions))
;; 	    (ac-use-comphist nil)
;; 	    (ac-auto-show-menu 0.5)
;; 	    (ac-candidates-cache nil)
;; 	    (ac-auto-start nil)
;; 	    (ac-expand-on-auto-complete t)
;; 	    (ac-use-fuzzy nil)
;; 	    (ac-dwim nil)
;; 	    (ac-use-quick-help t)
;; 	    (ac-delete-dups nil)
;; 	    (ac-ignore-case t))
;; 	(apply orig-fun args))
;;     (apply orig-fun args)))
;; (advice-add 'ac-trigger-key-command :around #'scala/ac-trigger-key-command)

(defun scala/completing-dot-company ()
  (cond (company-backend
	 (company-complete-selection)
	 (scala/completing-dot))
	(t
	 (insert ".")
	 (company-complete))))

(defun scala/completing-dot-ac ()
  (insert ".")
  (ac-trigger-key-command t))

;; (define-key scala-mode-map (kbd ".") 'scala/completing-dot)

;; ;; Interactive commands

;; (defun scala/completing-dot ()
;;   "Insert a period and show company completions."
;;   (interactive "*")
;;   (eval-and-compile (require 'ensime))
;;   (eval-and-compile (require 's))
;;   (when (s-matches? (rx (+ (not space)))
;; 		    (buffer-substring (line-beginning-position) (point)))
;;     (delete-horizontal-space t))
;;   (cond ((not (and (ensime-connected-p) ensime-completion-style))
;; 	 (insert "."))
;; 	((eq ensime-completion-style 'company)
;; 	 (scala/completing-dot-company))
;; 	((eq ensime-completion-style 'auto-complete)
;; 	 (scala/completing-dot-ac))))

;; ;; Initialization
;; (defun hatena-scala:enable-eldoc ()
;;   (set (make-local-variable 'eldoc-idle-delay) 1.0)
;;   (scala/enable-eldoc))

;; (add-hook 'ensime-mode-hook #'hatena-scala:enable-eldoc)
;; ; (add-hook 'ensime-mode-hook #'scala/enable-eldoc)

(setq ensime-sem-high-faces
      '((implicitConversion nil)
	(implicitParams nil)))

;; (setq ensime--yasnippet-complete-action nil)
;; (setq ensime-ac-enable-argument-placeholders nil)
;; (set-face-attribute 'ensime-implicit-highlight nil :underline nil)
;; (setq ensime-sem-high-enabled-p nil)

;; (setq ac-delete-dups nil)
;; (setq ac-auto-show-menu 0.5)
;; (setq ac-auto-start nil)
;; (setq ac-use-quick-help nil)
;; (setq ac-quick-help-delay 9999)

;; ;; 20行分表示
;; (setq ac-menu-height 20)

;; (setq ensime-sbt-perform-on-save "compile")
(setq ensime-completion-style nil)
