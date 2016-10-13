(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tt?$"     . web-mode))

;; インデント関係
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-html-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-offset 2)
  (setq web-mode-script-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2))

(add-hook 'web-mode-hook 'web-mode-hook)
