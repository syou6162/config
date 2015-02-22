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
(el-get-bundle evil)
(el-get-bundle session)

(el-get-bundle abbrev-complete)
(el-get-bundle gist:532280b24ad87945a997:dabbrev-expand-multiple)
(el-get-bundle popup)

(el-get-bundle clojure-mode)
(el-get-bundle paredit)
(el-get-bundle nrepl)

(el-get-bundle cperl-mode)
(el-get-bundle set-perl5lib)

(el-get-bundle markdown-mode)

(el-get-bundle tarao/with-eval-after-load-feature-el)
(el-get-bundle anything
  (global-set-key (kbd "C-x b") 'anything-for-files)
  (with-eval-after-load-feature 'anything
    (define-key anything-map (kbd "M-n") 'anything-next-source)
    (define-key anything-map (kbd "M-p") 'anything-previous-source)))

(setq load-path
      (append
       (mapcar 
	(lambda (filename) (expand-file-name filename))
	(list))
       load-path))

(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
