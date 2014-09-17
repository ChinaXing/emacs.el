(setq debug-on-error t)
;;-----------------------------------------------------
;; emacs core settings 
;;-----------------------------------------------------
(put 'dired-find-alternate-file 'disabled nil)
;; default coding-system :utf-8
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
;;------------------------------------------------------
;; auto-install
;;------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/auto-install/")

;;------------------------------------------------------
;; package system
;;------------------------------------------------------
(require 'package)
(setq package-archives '(
;; GNU
			 ("gnu" . "http://elpa.gnu.org/packages/")
;; ELPA: http://melpa.milkbox.net/
			 ("melpa" . "http://melpa.milkbox.net/packages/")
;; ELPA: http://marmalade-repo.org/
			 ("marmalade" . "http://marmalade-repo.org/packages/")))

;;-------------------------------------------------------
;; securty
;;-------------------------------------------------------
;;EasyPG
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
;; hightlight current line
;;-------------------------------------------------------
(global-hl-line-mode)

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
(add-hook 'haskell-mode-hook '(lambda () (haskell-indent-mode)))
;;---------------------------------------------------------
;; shortcut
;;---------------------------------------------------------
;; 1. indent buffer
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

;;-----------------------------------------------------------
;; org mode
;;-----------------------------------------------------------
(require 'org)

;; need by org-babel export src highlight

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
