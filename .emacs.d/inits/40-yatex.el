(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))

(add-hook 'yatex-mode-hook 'turn-on-reftex)

(setq tex-command "~/bin/platex2pdf"
      dvi2-command "open -a Skim.app")

(setq YaTeX-dvi2-command-ext-alist
  '(("xdvi\\|dvipdfmx" . ".dvi")
    ("ghostview\\|gv" . ".ps")
    ("Skim\\|acroread\\|pdf\\|Preview\\|TeXShop" . ".pdf")))

(setq YaTeX-use-hilit19 nil
        YaTeX-use-font-lock t)
 
(setq imaxima-pt-size 12)
(setq imaxima-fnt-size "Large")

(add-hook 'yatex-mode-hook
          '(lambda()
	     (define-key YaTeX-mode-map "{" 'insert-braces)
	     (define-key YaTeX-mode-map "(" 'insert-parens)
	     (define-key YaTeX-mode-map "[" 'insert-brackets)
	     (define-key YaTeX-mode-map "}" 'insert-braces-region)
	     (define-key YaTeX-mode-map ")" 'insert-parens-region)
	     (define-key YaTeX-mode-map "]" 'insert-brackets-region)
	     (define-key YaTeX-mode-map "$" 'insert-dollars-region)))

(setq YaTeX-use-AMS-LaTeX t)

;; yatex-modeに入る時、自動でflyspell-modeに入るようにする
(add-hook 'yatex-mode-hook 'flyspell-mode)
(custom-set-variables 
 '(flyspell-auto-correct-binding [(control ?\:)]))

;; texの記法は無視
(setq ispell-parser 'tex)
;; アルファベット順にしない
(setq flyspell-sort-corrections nil)
