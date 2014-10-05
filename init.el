(setq debug-on-error t)
;;-----------------------------------------------------
;; emacs core settings 
;;-----------------------------------------------------
(put 'dired-find-alternate-file 'disabled nil)
;; default coding-system :utf-8
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

(column-number-mode 1)
(display-time)
(menu-bar-mode -1)

;;------------------------------------------------------
;; auto-install
;;------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/auto-install/")

;;------------------------------------------------------
;; package system
;;------------------------------------------------------
(require 'package)
(package-initialize)
(setq package-archives 
      '(
	("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.milkbox.net/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")))
;;-------------------------------------------------------
;; crosshairs when idle
;;-------------------------------------------------------
(require 'crosshairs)
(toggle-crosshairs-when-idle 1)

(require 'epa-file)
(epa-file-enable)
(setq epa-file-encrypt-to nil)

;;-------------------------------------------------------
;; yasnippet-bundle -- Yet another snippet
;;-------------------------------------------------------
(add-hook 'after-init-hook '(lambda () (yas/global-mode 0)))

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

;;--------------------------------------------------------
;; web-mode
;;--------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html.ep\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))

;;---------------------------------------------------------
;; Haskell Indent
;;---------------------------------------------------------
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(add-hook 'haskell-mode-hook 'structured-haskell-mode)

(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
     (define-key haskell-mode-map (kbd "M-`") 'haskell-interactive-bring)
     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
     (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
     (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
     (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
     (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)))

(add-hook 'structured-haskell-mode-hook
  '(lambda() 
     (progn 	  
       (require 'shm-case-split)
       (define-key shm-map (kbd "C-c C-s") 'shm/case-split))))
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
  "Insert the current date. with prefix-argument
   if prefix is date, insert date only
   else insert date and time ( default )
  "
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

         ;; Path to your HiD project.
         :publishing-directory "~/ChinaXing.org/wintersmith/contents"
         :recursive t
         :publishing-function org-publish-org-to-html
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

(setq org-src-fontify-natively t)

(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")

(add-hook 'org-mode-hook
  (lambda () 
    (define-key org-mode-map (kbd "C-c C-p") 'org-publish-current-project)))

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
   ))

;;------------------------------------------------------------
;; custom
;;------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "24cb1b9c182198f52df7cebf378ee9ecca93a2daeb9a90049a2f1f556119c742" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
