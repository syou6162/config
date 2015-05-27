(set-language-environment "Japanese")
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-locale-environment "utf-8")
(setenv "LANG" "ja_JP.UTF-8")
(setenv "CPLUS_INCLUDE_PATH" "/opt/local/include")

;; Don't show the startup splash screen
(setq inhibit-startup-message t)

;; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

;; In Zenitani's Carbon Emacs Package,
;; file-name-coding-system is set to utf-8m by default
(when (and (>= emacs-major-version 22)
           (eq file-name-coding-system nil))
  (set-file-name-coding-system 'utf-8))

;; workaround for IM issue in Carbon Emacs Package 20071106~
;; see http://homepage.mac.com/zenitani/emacs-e.html for more details
(when (featurep 'carbon-emacs-package)
  (setq default-input-method "MacOSX"))

(setq exec-path (cons "/opt/local/bin" exec-path))
(setenv "PATH"
  (concat "/opt/local/bin:" (getenv "PATH")))

(tool-bar-mode -1)

;;;emacsのkillingの履歴
(autoload 'kill-summary "kill-summary" nil t)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)

;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

(show-paren-mode t)

(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

;;リージョン色づけ
(setq transient-mark-mode t)

(setq truncate-partial-width-windows nil)

;; 保存時に勝手に改行を挿入するのを止める
(setq require-final-newline nil)

;; http://d.hatena.ne.jp/hitode909/20090531/1243749340
;; システムに装飾キー渡さない
(setq mac-pass-control-to-system nil)
(setq mac-pass-command-to-system nil)
(setq mac-pass-option-to-system nil)

(add-to-list 
 'default-frame-alist
 '(font . "-apple-monaco-medium-r-normal--15-120-72-72-m-120-iso10646-1"))

(add-to-list 'exec-path (expand-file-name "~/bin"))
