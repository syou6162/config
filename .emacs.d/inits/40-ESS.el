(setq auto-mode-alist
     (cons (cons "\\.R$" 'R-mode) auto-mode-alist))
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
(setq-default inferior-R-program-name 
	      "/Library/Frameworks/R.framework/Resources/bin/R")

(autoload 'R "ess-site" nil 'interactive)
(setq ess-ask-for-ess-directory nil)

(defun ess:format-window-1 ()
  (split-window-horizontally)
  (other-window 1)
  (split-window)
  (other-window 1))
(add-hook 'ess-pre-run-hook 'ess:format-window-1)

(add-hook 'ess-mode-hook
          '(lambda()
	     (define-key ess-mode-map "{" 'insert-braces)
	     (define-key ess-mode-map "(" 'insert-parens)
	     (define-key ess-mode-map "\"" 'insert-double-quotation)
	     (define-key ess-mode-map "[" 'insert-brackets)
	     (define-key ess-mode-map "}" 'insert-braces-region)
	     (define-key ess-mode-map ")" 'insert-parens-region)
	     (define-key ess-mode-map "]" 'insert-brackets-region)
	     (define-key ess-mode-map "\"" 'insert-double-quotation-region)))

; color
(global-font-lock-mode t)                                        ; S/R   TeX
(set-face-foreground 'font-lock-comment-face       "Firebrick")  ; #com  %com
(set-face-foreground 'font-lock-string-face         "SeaGreen")  ; "str" "str"
(set-face-foreground 'font-lock-keyword-face      "MediumBlue")  ; if    ¥end
(set-face-foreground 'font-lock-constant-face      "VioletRed")  ; fun<- {ctr}
(set-face-foreground 'font-lock-type-face      "DarkGoldenrod")  ; T,F    ?
(set-face-foreground 'font-lock-variable-name-face      "Blue")  ; xv
(set-face-foreground 'font-lock-function-name-face "VioletRed")  ; <-    {eq1}

