(require 'smartchr)
(add-hook 'cperl-mode-hook
	  '(lambda ()
	     (progn
	       (local-set-key (kbd "D") (smartchr '("D" "use Data::Dumper; warn Dumper ")))
	       )))
