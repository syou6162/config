(require 'magit)

;; diffの表示方法を変更
(defun diff-mode-setup-faces ()
  ;; 追加された行は緑で表示
  (set-face-attribute 'diff-added nil
		      :foreground "white" :background "dark green")
  ;; 削除された行は赤で表示
  (set-face-attribute 'diff-removed nil
		      :foreground "white" :background "dark red")
  ;; 文字単位での変更箇所は色を反転して強調
  (set-face-attribute 'diff-refine-change nil
		      :foreground nil :background nil
		      :weight 'bold :inverse-video t))
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)

;; diffを表示したらすぐに文字単位での強調表示も行う
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

;; diff関連の設定
(defun magit-setup-diff ()
  ;; diffを表示しているときに文字単位での変更箇所も強調表示する
  ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
  (setq magit-diff-refine-hunk 'all)
  ;; diff用のfaceを設定する
  (diff-mode-setup-faces)
  ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
  (set-face-foreground 'magit-diff-added "#00FF00")
  (set-face-background 'magit-diff-added "#000000")
  (set-face-foreground 'magit-diff-added-highlight "#00FF00")
  (set-face-background 'magit-diff-added-highlight "gray20")
  (set-face-foreground 'magit-diff-removed "#FF0000")
  (set-face-background 'magit-diff-removed "#000000")
  (set-face-foreground 'magit-diff-removed-highlight "#FF0000")
  (set-face-background 'magit-diff-removed-highlight "gray20")
  (set-face-background 'magit-diff-lines-boundary "blue"))
(add-hook 'magit-mode-hook 'magit-setup-diff)
		     
(global-set-key (kbd "C-x g") 'magit-status)
