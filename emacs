
(global-set-key "\M-g" 'goto-line)  ; Alt-g runs the goto-line
                                    ; function.

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(org-agenda-files (list "~/physics/worklog/2011/october.org" "~/physics/worklog/2011/september.org"))
 '(safe-local-variable-values (quote ((org-export-html-auto-postamble))))
 '(show-paren-mode t)
 '(tab-width 4)
 '(transient-mark-mode t))
 '(global-font-lock-mode t nil (font-lock)
 '(show-paren-mode t nil (paren)))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(global-font-lock-mode t)
;;(setq font-lock-maximum-size nil)
(set-face-foreground font-lock-comment-face "red")
(set-background-color "Black")
(set-foreground-color "White")
(set-cursor-color "LightSkyBlue")

;; Show column number at bottom of screen
(column-number-mode 1)

;; Load cmake mode
(setq load-path (cons (expand-file-name "~/.emacs.d/") load-path))
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;;; Load automatically hide-show with c code
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)

;;; some shortcut for folding with hideshow 
(require 'hideshow)
;;(setq hs-minor-mode-hook nil) ; I do not like hs-hide-initial-comment-block
(global-set-key (kbd "C-c <left>")  'hs-hide-block)
(global-set-key (kbd "C-c <right>") 'hs-show-block)

(global-set-key [C-next] 'next-buffer)       ; tabbing like with firefox
(global-set-key [C-prior] 'previous-buffer) ;

;; Org-mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)
;; use chromium when opening links
(setq browse-url-browser-function (quote browse-url-generic))
(setq browse-url-generic-program "chromium")
;; enable org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sh . t)
   (python . t)
   (ditaa . t)
   (gnuplot . t)
   (screen . t)
   (R . t)))


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
;; slime needs to know which lisp to use
(setq inferior-lisp-program "clisp")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
(require 'slime-autoloads)
(slime-setup)
