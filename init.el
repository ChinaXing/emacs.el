(setq debug-on-error t)
;;-----------------------------------------------------
;; emacs core settings 
;;-----------------------------------------------------
(put 'dired-find-alternate-file 'disabled nil)
(setq inhibit-splash-screen t)
(setq default-directory "~/ChinaXing.org")
(add-hook 'after-init-hook (lambda ()
			     (unless (cdr command-line-args)
			       (setq initial-buffer-choice default-directory)
			       )))
;; default coding-system :utf-8
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

(column-number-mode 1)
(display-time)
(menu-bar-mode -1)

(setq calendar-latitude 30.2)
(setq calendar-longitude  120.0)

;;------------------------------------------------------
;; auto-install
;;------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/auto-install/")

;;------------------------------------------------------
;; package system
;;------------------------------------------------------
(require 'package)
(package-initialize)
;;------------------------------------------------------
;; PATH
;;------------------------------------------------------
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super)
  (global-set-key [kp-delete] 'delete-char)) ;; sets fn-delete to be right-delete
(setq package-archives 
      '(
	("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.milkbox.net/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")))
;;-------------------------------------------------------
;; crosshairs when idle
;;-------------------------------------------------------
;;(require 'crosshairs)
;;(toggle-crosshairs-when-idle 1)

(require 'epa-file)
(epa-file-enable)
(setq epa-file-encrypt-to nil)

;;-------------------------------------------------------
;; uniquify buffer
;;-------------------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;-------------------------------------------------------
;; hippie-expand
;;-------------------------------------------------------
(global-set-key (kbd "M-/") 'hippie-expand)

;;-------------------------------------------------------
;; iimage mode
;;-------------------------------------------------------
(iimage-mode)

;;-------------------------------------------------------
;;color theme
;;-------------------------------------------------------
(add-hook 'after-init-hook (lambda () 
			     (color-theme-initialize)
			     (color-theme-hober)
))

;;-------------------------------------------------------
;; Perl
;;-------------------------------------------------------
(defalias 'perl-mode 'cperl-mode)
;; -- Emacs::PDE
(add-hook 'cperl-mode-hook '(lambda () (load "pde-load") (abbrev-mode 0)))
(add-hook 'cperl-mode-hook '(lambda () (yas/minor-mode)))
(add-hook 'cperl-mode-hook '(lambda () (require 'perl-completion) (perl-completion-mode t)))
(add-hook 'cperl-mode-hook '(lambda () 
			      (when (require 'auto-complete nil t)
				(auto-complete-mode t)
				(make-variable-buffer-local 'ac-sources)
				(setq ac-sources
				      '(ac-source-perl-completion)))))

;; -------------------------------------------------------
;; Dired-k
;; -------------------------------------------------------
(require 'dired-k)
(define-key dired-mode-map (kbd "K") 'dired-k)

;; You can use dired-k alternative to revert-buffer
(define-key dired-mode-map (kbd "g") 'dired-k)
;;--------------------------------------------------------
;; web-mode
;;--------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html.ep\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))

;;---------------------------------------------------------
;; Haskell Indent
;;---------------------------------------------------------
;; shm not recommend these mode, so commented
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(add-hook 'haskell-mode-hook 'structured-haskell-mode)

(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "M-`") 'haskell-interactive-bring)
     (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
     (define-key haskell-mode-map (kbd "C-c C-n C-k") 'haskell-interactive-mode-clear)
     (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
     (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
     (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
     (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
     (define-key haskell-mode-map (kbd "<f8>") 'haskell-navigate-imports)))

(add-hook 'structured-haskell-mode-hook
	  '(lambda() 
	     (progn 	  
	       (require 'shm-case-split)
	       (define-key shm-map (kbd "C-c C-s") 'shm/case-split))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "24cb1b9c182198f52df7cebf378ee9ecca93a2daeb9a90049a2f1f556119c742" default)))
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(safe-local-variable-values
   (quote
    ((haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4)))))


;;---------------------------------------------------------
;; shortcut
;;---------------------------------------------------------
(defun indent-buffer ()
  "Indent the current buffer"
  (interactive)
  (save-excursion (indent-region (point-min) (point-max) nil))
  )
(global-set-key [f12] 'indent-buffer)

;; etags tags-table-list
(setq tags-table-list
      '("./TAGS" "../TAGS" "../../TAGS" "../../../TAGS")
      )
;; insert date/date-time
(defun insert-date (prefix)
  (interactive "P")
  (let ((format (cond
		 ((not prefix) "%Y-%m-%d %H:%M:%S")
		 ((equal prefix '(4)) "%Y-%m-%d")
		 ((equal prefix '(16)) "%Y-%m-%dT%H:%M:%S"))))
  (insert (format-time-string format))))

(global-set-key (kbd "C-c d") 'insert-date)

;;-----------------------------------------------------------
;; org mode
;;-----------------------------------------------------------
(require 'org)

;; org-mode project define
(setq org-publish-project-alist
      '(
        ("org-blog-content"
         ;; Path to your org files.
         :base-directory "~/ChinaXing.org/org/"
         :base-extension "org"

         :publishing-directory "~/ChinaXing.org/wintersmith/contents"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :html-extension "html"
         :table-of-contents t
         :section-numbers nil
         :body-only t ;; Only export section between <body></body>
         )

        ("org-blog-static"
         :base-directory "~/ChinaXing.org/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php\\|svg"
         :publishing-directory "~/ChinaXing.org/wintersmith/contents"
         :recursive t
         :publishing-function org-publish-attachment)
        ("blog" :components ("org-blog-content" "org-blog-static"))
        ))

(setq org-latex-to-pdf-process
      '("xelatex -interaction nonstopmode -output-directory %o %f"
	"xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"))

(setq org-src-fontify-natively t)

(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")

;; ----------------------------------------------------------------
;; insert article title
;; ----------------------------------------------------------------
(defun insert-project-article-head (prefix)
  (interactive "P")
  (let ((content (cond
		  ((not prefix) "#+BEGIN_HTML
---
date: %s
template: tech.jade
title: 
category: 
chage_frequency: monthly
tag: 
---
#+END_HTML
#+OPTIONS: toc:nil
#+TOC: headlines 2
")
		  ((equal prefix '(4)) "#+BEGIN_HTML
---
date: %s
template: article.jade
title: 
category: Life
change_frequency: never
---
#+END_HTML
")))
	(dateNow (format-time-string "%Y-%m-%d %H:%M:%S")))
    (insert (format content dateNow))))

(add-hook 'org-mode-hook
  (lambda () 
    (define-key org-mode-map (kbd "C-c C-p") 'org-publish-current-project)
    (define-key org-mode-map (kbd "C-c C-h") 'insert-project-article-head)))

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (emacs-lisp . t)
   (sh . t)
   (perl . t)
   (python . t)
   (R . t)
   (ditaa . t)
   (dot . t)
   ))

;;------------------------------------------------------------
;; custom
;;------------------------------------------------------------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
