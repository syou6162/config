(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\e[3~" 'delete-char)
(define-key global-map "\C-o" 'dabbrev-expand)

(global-set-key "{" 'insert-braces)
(global-set-key "(" 'insert-parens)
(global-set-key "[" 'insert-brackets)
(global-set-key "}" 'insert-braces-region)
(global-set-key ")" 'insert-parens-region)
(global-set-key "]" 'insert-brackets-region)