(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

(set-face-background 'ac-completion-face "white")
(set-face-foreground 'ac-candidate-face "black")
(set-face-background 'ac-selection-face "black")
(set-face-foreground 'ac-selection-face "red")
(set-face-foreground 'popup-summary-face "black") ;; 候補のサマリー部分
(set-face-background 'popup-tip-face "cyan") ;; ドキュメント部分
(set-face-foreground 'popup-tip-face "white")
