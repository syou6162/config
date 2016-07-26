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

(el-get-bundle s)
(el-get-bundle hvesalai/scala-mode2)
(el-get-bundle ensime/emacs-scala-mode)
(el-get-bundle sbt-mode)
(el-get-bundle ensime/ensime-emacs)

(el-get-bundle typescript-mode)
(el-get-bundle json-mode)
(el-get-bundle tss)

(el-get-bundle markdown-mode)
(el-get-bundle recentf-ext)
(el-get-bundle ddskk)
(el-get-bundle smartchr)

(el-get-bundle magit :branch "master")

(el-get-bundle helm)
(el-get-bundle sigma/gh.el)
(el-get-bundle sigma/pcache)
(el-get-bundle sigma/logito)
(el-get-bundle syohex/emacs-helm-open-github)
(el-get-bundle web-mode)

(el-get-bundle shibayu36/emacs-open-github-from-here)

(el-get-bundle helm-git-grep)
(el-get-bundle helm-ag)

(el-get-bundle emacswiki:sql)
(el-get-bundle emacswiki:sql-indent)
(el-get-bundle emacswiki:sql-complete)
(el-get-bundle emacswiki:sql-transform)

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
