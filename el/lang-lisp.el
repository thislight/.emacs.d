(defun rubicon/sly-init ()
  (progn
   (setq sly-lisp-implementations
         '((ccl ("ccl"))
           (clisp ("clisp" "-q"))
           (cmucl ("cmucl" "-quiet"))
           (sbcl ("sbcl" "--noinform"))
           (roswell ("ros" "run")))
         sly-default-lisp 'roswell
   )
   (setq sly-net-coding-system 'utf-8-unix)

   (defun prelude-start-sly ()
     (unless (sly-connected-p)
             (save-excursion (sly))
     ))
   (add-hook 'sly-mode-hook 'prelude-start-sly)
  ))

(use-package sly
  :ensure t
  :init (rubicon/sly-init)
  :pin "melpa"
  :config (setq common-lisp-hyperspec-root "/usr/local/share/doc/hyperspec/HyperSpec/"
                common-lisp-hyperspec-symbol-table (concat common-lisp-hyperspec-root "Data/Map_Sym.txt")
                common-lisp-hyperspec-issuex-table (concat common-lisp-hyperspec-root "Data/Map_IssX.txt")
          ))

;; SLY contribs will autoloads:
(use-package sly-quicklisp
  :ensure t
)

(use-package sly-asdf
  :ensure t
)

;; Lispy https://github.com/abo-abo/lispy
(use-package lispy
  :ensure t
  :init (progn
          ;; enable lispy for all lisp mode
         (add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))
         ;; enable lispy for eval-expression
         (defun conditionally-enable-lispy ()
           (when (eq this-command 'eval-expression)
                 (lispy-mode 1)
           ))
         (add-hook 'minibuffer-setup-hook 'conditionally-enable-lispy)
        ))

(provide 'lang-lisp)
