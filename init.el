;; Set up package manager
(add-to-list 'load-path "~/.emacs.d/lisp/use-package/")
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(use-package package
  :config
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (package-initialize))

;; Theme stuff
(use-package zenburn-theme
	     :config
	     (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
	     (load-theme 'zenburn t)
	     :ensure t)

(use-package geiser :ensure t)
(use-package quack :ensure t)

  :ensure t)
(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode t)
  :ensure t)

(use-package magit
  :bind ("C-x m" . magit-status)
  :ensure t)
(use-package tramp
  :ensure t
  :config
  (setq tramp-debug-buffer t)
  (setq tramp-default-method "ssh"))
(use-package em-tramp
  :config
  (setq eshell-prefer-lisp-functions t)
  (setq eshell-prefer-lisp-variables t)
  (setq password-cache t)
  (setq password-cache-expiry 120))

(use-package wgrep :ensure t)
;; Lisp Stuff
(define-abbrev-table 'scheme-mode-abbrev-table
  '(("lambda" "λ" nil 1)))
(setq default-abbrev-mode t)

;; Preferences
(require 'dired-x)
(setf inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(setf initial-buffer-choice default-directory)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
