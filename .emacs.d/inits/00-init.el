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

(when (>= emacs-major-version 23)
 (setq fixed-width-use-QuickDraw-for-ascii t)
 (setq mac-allow-anti-aliasing t)
 (set-face-attribute 'default nil
                     :family "monaco"
                     :height 140)
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0208
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0212
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'katakana-jisx0201
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 ;;; Unicode フォント
 (set-fontset-font
  (frame-parameter nil 'font)
  'mule-unicode-0100-24ff
  '("monaco" . "iso10646-1"))
;;; キリル，ギリシア文字設定
;;; 注意： この設定だけでは古代ギリシア文字、コプト文字は表示できない
;;; http://socrates.berkeley.edu/~pinax/greekkeys/NAUdownload.html が必要
;;; キリル文字
 (set-fontset-font
  (frame-parameter nil 'font)
  'cyrillic-iso8859-5
  '("monaco" . "iso10646-1"))
;;; ギリシア文字
 (set-fontset-font
  (frame-parameter nil 'font)
  'greek-iso8859-7
  '("monaco" . "iso10646-1"))
 (setq face-font-rescale-alist
       '(("^-apple-hiragino.*" . 1.2)
         (".*osaka-bold.*" . 1.2)
         (".*osaka-medium.*" . 1.2)
         (".*courier-bold-.*-mac-roman" . 1.0)
         (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
         (".*monaco-bold-.*-mac-roman" . 0.9)
         ("-cdac$" . 1.3))))

(setq default-frame-alist
      (append (list '(foreground-color . "azure3")
		    '(background-color . "black")
		    '(border-color . "black")
		    '(mouse-color . "white")
		    '(cursor-color . "white")
		    '(width . 160)
		    '(height . 47)
		    '(top . 0)
		    '(left . 10)
		    '(alpha . (80 60)))    ;;ここ
		    default-frame-alist))

;; (tool-bar-mode -1)

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

;; http://d.hatena.ne.jp/hitode909/20090531/1243749340
;; システムに装飾キー渡さない
(setq mac-pass-control-to-system nil)
(setq mac-pass-command-to-system nil)
(setq mac-pass-option-to-system nil)

(require 'tramp)
(setq tramp-default-method "sshx")

(add-to-list 
 'default-frame-alist
 '(font . "-apple-monaco-medium-r-normal--15-120-72-72-m-120-iso10646-1"))