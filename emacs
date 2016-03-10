;; -*- Emacs-Lisp -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(org-agenda-files
   (list "~/physics/worklog/2011/october.org" "~/physics/worklog/2011/september.org"))
 '(safe-local-variable-values (quote ((org-export-html-auto-postamble))))
 '(show-paren-mode t)
 '(tab-width 4)
 '(indent-tabs-mode nil)
 '(transient-mark-mode t))
 '(global-font-lock-mode t nil (font-lock)
 '(show-paren-mode t nil (paren)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-code ((t (:inherit shadow)))))

(when (fboundp 'global-font-lock-mode) (global-font-lock-mode t)) ; font-lock highlight syntax
(setq diff-switches "-u")                                         ; default to unified diffs
(normal-erase-is-backspace-mode 0)                                ; Fix the backspace doing delete
(setq line-number-mode t)                                         ; Show line number
(setq column-number-mode t)                                       ; Show column number
(transient-mark-mode t)                                           ; Highlight selected region
(global-set-key "\M-g" 'goto-line)                                ; Alt-g runs the goto-line function
(show-paren-mode 1)                                               ; highlight matching parentheses
(column-number-mode 1)                                            ; Show column number at bottom of screen

;
; Additional packages I often use
;
(setq load-path (cons (expand-file-name "~/.emacs.d/lisp") load-path)) ; where I keep them
(autoload 'markdown-mode "markdown-mode" "highlight markdown" t)   ; Load markdown mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))       ;
(autoload 'cmake-mode "cmake-mode.el" t)                           ; Load cmake mode
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))


;(setq explicit-bash-args (list "--login" "-i"))

;;(setq font-lock-maximum-size nil)
(set-face-foreground font-lock-comment-face "red")
(set-background-color "Black")
(set-foreground-color "White")
(set-cursor-color "LightSkyBlue")
(set-keyboard-coding-system 'latin-9) ; intl keys with '-nw'
(set-terminal-coding-system 'latin-9)

;
; other settings
;
(add-hook 'c-mode-hook 'hs-minor-mode)               ; hide-show for c
(add-hook 'c++-mode-hook 'hs-minor-mode)             ; hide-show for c++
(global-set-key (kbd "C-c <left>")  'hs-hide-block)  ; shortkey hide
(global-set-key (kbd "C-c <right>") 'hs-show-block)  ; shortkey show
(if (and (boundp 'i-use-hideshow) i-use-hideshow)    ; autoload hideshow
    (autoload 'hs-minor-mode "hideshow"
      "Selective code display" t))
(global-set-key [C-next] 'next-buffer)               ; tab between buffers : C-pgup
(global-set-key [C-prior] 'previous-buffer)          ; tab between buffers : C-pgdn
(global-set-key (kbd "C-x <up>") 'windmove-up)       ; windmove to navigate windows based on their position                                                                                                                                                            
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on) ; deal with colors for shell propmt

; customize c++ indent style, no namespace indentation
; For more info see
; http://www.emacswiki.org/emacs/CPlusPlusMode
; and
; http://stackoverflow.com/questions/2619853/emacs-override-indentation
(c-add-style "nni-cc-mode"
             '("cc-mode"  ; inherit from cc-mode
             (c-offsets-alist . ((innamespace . [0])))))
(defun nni-c++-mode-hook () (c-set-style "nni-cc-mode"))
(add-hook 'c++-mode-hook 'nni-c++-mode-hook)

;
; Org-mode settings
;
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq browse-url-browser-function                    ; use chromium when opening links
      (quote browse-url-generic))
(setq browse-url-generic-program "chromium")
; ;; enable org-babel languages
; (org-babel-do-load-languages
;  'org-babel-load-languages
;  '((emacs-lisp . t)
;    (sh . t)
;    (python . t)
;    (ditaa . t)
;    (gnuplot . t)
;    (screen . t)
;    (R . t)))


;; (defvar missing-packages-list nil
;;   "List of packages that `try-require' can't find.")
;; 
;; ;; attempt to load a feature/library, failing silently
;; (defun try-require (feature)
;;   "Attempt to load a library or module. Return true if the
;; library given as argument is successfully loaded. If not, instead
;; of an error, just add the package to a list of missing packages."
;;   (condition-case err
;;       ;; protected form
;;       (progn
;;         (message "Checking for library `%s'..." feature)
;;         (if (stringp feature)
;;             (load-library feature)
;;           (require feature))
;;         (message "Checking for library `%s'... Found" feature))
;;     ;; error handler
;;     (file-error  ; condition
;;      (progn
;;        (message "Checking for library `%s'... Missing" feature)
;;        (add-to-list 'missing-packages-list feature 'append))
;;      nil)))
;; 
;; (when (try-require 'org-latex)
;;  ;; XXX 2010-03-25 TEMP Fix for conflict TikZ/hyperref: loading atbegshi
;;  ;; before document class beamer
;;(add-to-list 'org-export-latex-classes
;;			 '("beamer"
;;			   "\\RequirePackage{atbegshi}\n\\documentclass{beamer}\n"
;;			   org-beamer-sectioning))
;;  )
; ;

;
; slime settings
;
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
(setq inferior-lisp-program "clisp")  ; slime needs to know which lisp to use
(autoload 'slime-selector "slime" t)
(eval-after-load "slime" '(progn (slime-setup)))
