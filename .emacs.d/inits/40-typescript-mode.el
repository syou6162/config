(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(setq typescript-indent-level 4
      typescript-expr-indent-offset 4)

(require 'tide)
(require 'company)
(add-hook 'typescript-mode-hook
	  (lambda ()
	    (tide-setup)
	    (flycheck-mode t)
	    (setq flycheck-check-syntax-automatically '(save mode-enabled))
	    (eldoc-mode t)
	    (company-mode-on)))

(require 'company)
;;; C-n, C-pで補完候補を選べるように
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
;;; C-hがデフォルトでドキュメント表示にmapされているので、文字を消せるようにmapを外す
(define-key company-active-map (kbd "C-h") nil)
;;; 1つしか候補がなかったらtabで補完、複数候補があればtabで次の候補へ行くように
(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
;;; ドキュメント表示
(define-key company-active-map (kbd "M-d") 'company-show-doc-buffer)

(setq company-minimum-prefix-length 1) ;; 1文字入力で補完されるように
 ;;; 候補の一番上でselect-previousしたら一番下に、一番下でselect-nextしたら一番上に行くように
(setq company-selection-wrap-around t)

;;; 色の設定。出来るだけ奇抜にならないように
(set-face-attribute 'company-tooltip nil
		    :foreground "black"
		    :background "lightgray")
(set-face-attribute 'company-preview-common nil
		    :foreground "dark gray"
		    :background "black"
		    :underline t)
(set-face-attribute 'company-tooltip-selection nil
		    :background "steelblue"
		    :foreground "white")
(set-face-attribute 'company-tooltip-common nil
		    :foreground "black"
		    :underline t)
(set-face-attribute 'company-tooltip-common-selection nil
		    :foreground "white"
		    :background "steelblue"
		    :underline t)
(set-face-attribute 'company-tooltip-annotation nil
		    :foreground "red")


;(custom-set-variables
					; '(flycheck-typescript-tslint-executable "~/.ndenv/shims/tslint"))

;;; typescriptでのコンパイルルール

;; (require 'compile)
;; (setq compilation-error-regexp-alist
;;       (append
;;        '(;; d:/h...ript/sample.ts (13,175):
;; 	 ("^\\(.*\\)(\\([0-9]+\\),[0-9]+):" 1 2))
;;        compilation-error-regexp-alist))
;; (add-hook
;;  'typescript-mode-hook
;;  (lambda ()
;;    (set (make-local-variable 'compile-command)
;; 	(format "$(npm bin)/tsc -p %s"
;; 		(git-root-directory)))))


;; ;;; tslintのエラールール
;; (setq compilation-error-regexp-alist
;;       (append
;;        '(;; src/ts/app.ts[5, 12]: Missing semicolon
;; 	 ("^\\(.*\\)\\[\\([0-9]+\\), [0-9]+]:" 1 2))
;;        compilation-error-regexp-alist))

;; (require 'tss)
;; (setq tss-popup-help-key "C-c h")
;; (tss-config-default)

