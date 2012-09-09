(require 'dabbrev-expand-multiple)
(global-set-key "\C-o" 'dabbrev-expand-multiple)

;; 補完候補を一度に5つにする.
(setq dabbrev-expand-multiple-select-keys '("a" "s" "d" "f" "g"))
;; 複数候補表示に移るキーに m を足す.
(add-to-list 'dabbrev-expand-multiple-multi-selection-keys "m")
;; 複数候補表示時に次の候補表示に使用するキーに n を足す.
(add-to-list 'dabbrev-expand-multiple-next-keys "n")
;; 複数候補表示時に前の候補表示に使用するキーに p を足す.
(add-to-list 'dabbrev-expand-multiple-previous-keys "p")
;; ツールチップを表示する秒数.
(setq dabbrev-expand-multiple-tooltip-timeout 2000)
;; 10秒で消えるように設定する.
(setq dabbrev-expand-multiple-tooltip-timeout 10)
;; ツールチップの見た目の設定 M-x list-colors-display を参考に設定する.
(setq dabbrev-expand-multiple-tooltip-params
      '((foreground-color . "grey75")
        (background-color . "navy blue")
        (border-color . "black")))
;; 最初に展開した文字列に highlight をかける.
(setq dabbrev-expand-multiple-highlight-face 'highlight)
;; インライン表示のときに使用するフェイス.
(setq dabbrev-expand-multiple-inline-show-face 'underline)
;; インライン表示の見た目の変更 (アンダーラインをなしにする)
(setq dabbrev-expand-multiple-inline-show-face nil)
;; ツールチップを使用しない(インライン表示をする)
(setq dabbrev-expand-multiple-use-tooltip nil)

;; 動的補完で大文字小文字の区別をさせる
(setq dabbrev-case-fold-search nil)
