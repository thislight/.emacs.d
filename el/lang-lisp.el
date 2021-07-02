(defun rubicon/slime-init ()
  (progn
    (setq slime-contribs '(slime-fancy)
          slime-complete-symbol-function 'slime-fuzzy-complete-symbol
          slime-net-coding-system 'utf-8-unix
          slime-lisp-implementations
          '((ccl ("ccl"))
            (clisp ("clisp" "-q"))
            (cmucl ("cmucl" "-quiet"))
            (sbcl ("sbcl" "--noinform"))
            (roswell ("ros" "run")))
          slime-default-lisp 'roswell
	  )
    (add-hook 'lisp-mode-hook (lambda () (run-hooks 'prelude-lisp-coding-hook)))
    (add-hook 'slime-repl-mode-hook (lambda () (run-hooks 'prelude-interactive-lisp-coding-hook)))
    ;; start slime automatically when we open a lisp file
    (defun prelude-start-slime ()
      (unless (slime-connected-p)
        (save-excursion (slime))
	))

    (add-hook 'slime-mode-hook 'prelude-start-slime)

    (eval-after-load "slime"
      '(progn
         (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol
               slime-fuzzy-completion-in-place t
               slime-enable-evaluate-in-emacs t
               slime-autodoc-use-multiline-p t)

         (define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
         (define-key slime-mode-map (kbd "C-c i") 'slime-inspect)
         (define-key slime-mode-map (kbd "C-c C-s") 'slime-selector))
      ))
  (defun slime-qlot-exec (directory)
    (interactive (list (read-directory-name "Project directory: ")))
    (slime-start :program "qlot"
                 :program-args '("exec" "ros" "-S" "." "run")
                 :directory directory
                 :name 'qlot
                 :env (list (concat "PATH=" (mapconcat 'identity exec-path ":")))
		 )))

(use-package slime
  :ensure t
  :init (rubicon/slime-init)
  :config (setq common-lisp-hyperspec-root "/usr/local/share/doc/hyperspec/HyperSpec/"
                common-lisp-hyperspec-symbol-table (concat common-lisp-hyperspec-root "Data/Map_Sym.txt")
                common-lisp-hyperspec-issuex-table (concat common-lisp-hyperspec-root "Data/Map_IssX.txt")
		))

(provide 'lang-lisp)
