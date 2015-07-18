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
  (string-append
   (path->string (current-directory))
   path-string))
(map (λ (pair)
       (match-let* ([`(,from ,to) pair]
                    [to (eh to)]
                    [from (ade from)])
         (when (file-exists? to)
           (rename-file-or-directory to (format "~a~~" to) #t))
         (softlink-file from to)))
     '(("init.el" "~/.emacs.d/init.el")
       ("dotXdefaults" "~/.Xdefaults")
       ("dotxmobarrc" "~/.xmobarrc")
       ("sshconfig" "~/.ssh/config")
       ("xmonad.hs" "~/.xmonad/xmonad.hs")))

(display-to-file (format "sh ~axinitcommon.sh" (current-directory))
                 (eh "~/.profile")
                 #:mode 'text
                 #:exists 'append)
