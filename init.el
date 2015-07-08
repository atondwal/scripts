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

(use-package racket-mode
  :mode ("\\.rkt\\'" . racket-mode)
  :interpreter ("racket" . racket-mode)
  :config
  (define-abbrev-table 'racket-mode-abbrev-table
    '(("lambda" "λ" nil 1)))
  (setq default-abbrev-mode t)

  ;; Special indentation for common functions
  (defun racket-add-keywords (face-name keyword-rules)
    (let* ((keyword-list (mapcar #'(lambda (x)
				     (symbol-name (cdr x)))
				 keyword-rules))
	   (keyword-regexp (concat "(\\("
				   (regexp-opt keyword-list)
				   "\\)[ \n]")))
      (font-lock-add-keywords 'racket-mode
			      `((,keyword-regexp 1  ',face-name))))
    (mapc #'(lambda (x)
	      (put (cdr x)
		   'racket-indent-function
		   (car x)))
	  keyword-rules))

  (racket-add-keywords
   'font-lock-keyword-face
   '((1 . for/append)))
  
  :ensure t)
(use-package geiser
  :config
  (add-hook 'racket-mode-hook (lambda () (geiser-mode t)))
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
(use-package dired-x)

;; Preferences
(setf inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(setf initial-buffer-choice default-directory)
(tool-bar-mode -1)
(menu-bar-mode -1)

(set-frame-parameter (selected-frame) 'alpha '(90 75))
(add-to-list 'default-frame-alist '(alpha 90 75))

(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))

(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode t)
  :ensure t)

;; Shell stuff
(defun split-shell ()
  (split-window)
  (eshell 'a))
(defun fresh-shell ()
  (eshell 'a))
