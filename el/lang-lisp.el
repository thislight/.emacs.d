
(defun rubicon/slime-init ()
    (progn
      (setq slime-contribs '(slime-fancy)
	    slime-complete-symbol-function 'slime-fuzzy-complete-symbol
	    slime-net-coding-system 'utf-8-unix
	    slime-lisp-implementations
	    '((ccl ("ccl"))
	      (clisp ("clisp" "-q"))
	      (cmucl ("cmucl" "-quiet"))
	      (sbcl ("sbcl" "--noinform")))
	    slime-default-lisp 'sbcl
	    )
      (add-hook 'lisp-mode-hook (lambda () (run-hooks 'prelude-lisp-coding-hook)))
      (add-hook 'slime-repl-mode-hook (lambda () (run-hooks 'prelude-interactive-lisp-coding-hook)))
      ;; start slime automatically when we open a lisp file
      (defun prelude-start-slime ()
	(unless (slime-connected-p)
	  (save-excursion (slime))))

      (add-hook 'slime-mode-hook 'prelude-start-slime)
      ;; Stop SLIME's REPL from grabbing DEL,
      ;; which is annoying when backspacing over a '('
      (defun prelude-override-slime-repl-bindings-with-paredit ()
	(define-key slime-repl-mode-map
	  (read-kbd-macro paredit-backward-delete-key) nil))

      (add-hook 'slime-repl-mode-hook 'prelude-override-slime-repl-bindings-with-paredit)

      (eval-after-load "slime"
	'(progn
	   (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol
		 slime-fuzzy-completion-in-place t
		 slime-enable-evaluate-in-emacs t
		 slime-autodoc-use-multiline-p t)

	   (define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
	   (define-key slime-mode-map (kbd "C-c i") 'slime-inspect)
	   (define-key slime-mode-map (kbd "C-c C-s") 'slime-selector)))
      ))

(use-package slime
  :ensure t
  :init (rubicon/slime-init)
  :config (setq common-lisp-hyperspec-root "/usr/local/share/doc/hyperspec/HyperSpec/"
		common-lisp-hyperspec-symbol-table (concat common-lisp-hyperspec-root "Data/Map_Sym.txt")
		common-lisp-hyperspec-issuex-table (concat common-lisp-hyperspec-root "Data/Map_IssX.txt")))

(provide 'lang-lisp)
