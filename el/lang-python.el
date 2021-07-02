
(use-package elpy
  :ensure t
  :defer t
  :init (progn
	  (advice-add 'python-mode :before 'elpy-enable)
	  (setq elpy-rpc-ignored-buffer-size 40960000)))

(use-package poetry
  :ensure t
  :defer t
  :after 'elpy
  :init (add-hook 'elpy-mode-hook 'poetry-tracking-mode))

(provide 'lang-python)
