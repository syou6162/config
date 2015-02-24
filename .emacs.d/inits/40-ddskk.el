; (setq skk-isearch-mode-enable nil)
;(setq isearch-mode-hook nil)

(remove-hook 'isearch-mode-hook 'skk-isearch-setup-maybe t)
(remove-hook 'isearch-mode-end-hook 'skk-isearch-cleanup-maybe t)

;; 以下を記述するだけで必要な物は全部ロードする
(require 'skk-autoloads)

;; Emacs の起動時に必要な物をロードすることで、SKK の初回起動を速くする
; (setq skk-preload t)

;(add-hook 'isearch-mode-hook #'skk-isearch-setup-maybe)
;(add-hook 'isearch-mode-end-hook #'skk-isearch-cleanup-maybe)

;; Configure for SKK
; (require 'skk-autoloads nil t)
(global-set-key "\C-x\C-j" 'skk-mode)

(setq load-path
      (cons "~/config/.emacs.d/elisp/ddskk" load-path))

(setq skk-large-jisyo "~/config/.emacs.d/elisp/skkdic/SKK-JISYO.L")

(setq mac-pass-control-to-system nil)

(define-key key-translation-map [?\x8a5] [?\\])
(define-key key-translation-map [?\xd5c] [?\\])
(define-key key-translation-map [?\x40008a5] [?\C-\\])
(define-key key-translation-map [?\x80008a5] [?\M-\\])
(define-key key-translation-map [?\xc0008a5] [?\C-\M-\\])

;; (load "skk-bayesian" t)

;; ;; 半角で入力したい文字
;; (setq skk-rom-kana-rule-list
;;   (nconc skk-rom-kana-rule-list
;;     '((";" nil nil)
;;       (":" nil nil)
;;       ("?" nil nil)
;;       ("!" nil nil))))

;; ;; かなモード時に ASCII 文字の直後では'-' 全角文字後には'ー'
;; (setq skk-rom-kana-rule-list
;;       (cons '("-" nil skk-hyphen)
;; 	    skk-rom-kana-rule-list))
;; (defun skk-hyphen (arg)
;;   (let ((c (char-before (point))))
;;     (cond ((null c) "ー")
;;           ((and (<= ?0 c) (>= ?9 c)) "-")
;;           ((and (<= ?０ c) (>= ?９ c)) "−")
;;           (t "ー"))))
