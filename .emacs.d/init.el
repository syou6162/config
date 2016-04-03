(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle init-loader)
(el-get-bundle auto-complete)
(el-get-bundle session)

(el-get-bundle emacswiki:abbrev-complete)
(el-get-bundle gist:532280b24ad87945a997:dabbrev-expand-multiple)

(el-get-bundle popup)

(el-get-bundle clojure-mode)
(el-get-bundle paredit)

(el-get-bundle ruby-mode)

(el-get-bundle mode-compile
  :url "http://perso.eei.cena.fr/boubaker/distrib/mode-compile.el")
(el-get-bundle cperl-mode)
(el-get-bundle emacswiki:perltidy)
(el-get-bundle syohex/emacs-reply)
(el-get-bundle set-perl5lib)

(el-get-bundle markdown-mode)
(el-get-bundle recentf-ext)
(el-get-bundle ddskk)

(el-get-bundle magit :branch "master")

(el-get-bundle tarao/with-eval-after-load-feature-el)
(el-get-bundle anything
  (global-set-key (kbd "C-x b") 'anything-for-files)
  (with-eval-after-load-feature 'anything
    (define-key anything-map (kbd "M-n") 'anything-next-source)
    (define-key anything-map (kbd "M-p") 'anything-previous-source)))

(el-get-bundle gist:7349439:ginger-rephrase-api)
(el-get-bundle gist:5457732:ginger-api)

;; To install inf-clojrue
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq load-path
      (append
       (mapcar 
	(lambda (filename) (expand-file-name filename))
	(list))
       load-path))

(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
