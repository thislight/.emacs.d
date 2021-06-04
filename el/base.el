;; Default font size
(defvar rubicon/default-font-size 110)
(set-face-attribute 'default nil :height rubicon/default-font-size)

;; Custom file
(defvar rubicon/custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Package repositories
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/")
	     t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Emacs customizations
(setq custom-file rubicon/custom-file
      make-backup-files nil
      display-line-numbers-type 'relative
      use-package-always-ensure t)

;; Keep buffer up to date
(global-auto-revert-mode t)

;; Line number
(global-display-line-numbers-mode)

;; Show matching parentheses
(show-paren-mode 1)

;; Avoid being overwrittenin
(if (file-exists-p rubicon/custom-file)
    (load custom-file))

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'base)
