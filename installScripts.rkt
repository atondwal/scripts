#!/usr/bin/env racket
#lang racket

(when (file-exists? "~/.emacs")
  (rename-file-or-directory "~/.emacs ~/.emacs.d/.emacs~"))
(define (softlink-file from to)
  (system (format "ln -s ~a ~a" from to)))
(define (eh path-string)
  (string-replace path-string "~/"
                  (path->string (find-system-path 'home-dir))))
(define (ade path-string)
   path-string)
(map (λ (pair)
       (match-let* ([`(,from ,to) pair]
                    [to (eh to)]
                    [from (ade from)])
         (when (file-exists? to)
           (rename-file-or-directory to (format "~a~~" to) #t)
           (when (file-exists? to)
             (delete-file to)))
         (softlink-file from to)))
     '(("init.el" "~/.emacs.d/init.el")
       ("dotXdefaults" "~/.Xdefaults")
       ("dotxmobarrc" "~/.xmobarrc")
       ("sshconfig" "~/.ssh/config")
       ("xmonad.hs" "~/.xmonad/xmonad.hs")
       ("eshell_alias" "~/.emacs.d/eshell/alias")))

(display-to-file (format "sh ~axinitcommon.sh~n" (current-directory))
                 (eh "~/.profile")
                 #:mode 'text
                 #:exists 'append)
