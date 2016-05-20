(eval-after-load "sql"
  '(progn
     (load-library "sql-indent")
     (load-library "sql-complete")
     (load-library "sql-transform")))

(setq auto-mode-alist
      (cons '("\\.sql$" . sql-mode) auto-mode-alist))

(defun sql-mode-hooks()
  (setq sql-indent-offset 2)
  (setq indent-tabs-mode nil)
  (setq sql-user "root")
  (setq sql-password "")
  (sql-set-product "mysql"))

(add-hook 'sql-mode-hook 'sql-mode-hooks)
