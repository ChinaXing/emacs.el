(setq debug-on-error t)

;; ELPA: http://melpa.milkbox.net/
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . 
	       "http://melpa.milkbox.net/packages/") t)
;; ELPA: http://marmalade-repo.org/
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/") t)

;; EasyPG
(require 'epa-file)
(epa-file-enable)
(setq epa-file-encrypt-to nil)

;; uniquify buffer
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; hightlight current line
(global-hl-line-mode)

;; default coding-system :utf-8
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; use hippie-expand
(global-set-key (kbd "M-/") 'hippie-expand)

;; do not load pacakge after init, but NOW
(setq package-enable-at-startup nil)
(package-initialize)

;; iimage mode
(iimage-mode)

;;color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-billw)

;; -- Perl
(defalias 'perl-mode 'cperl-mode)

;; -- Emacs::PDE
(add-hook 'cperl-mode-hook '(lambda () (load "pde-load")))

;; yasnippet -- Yet another snippet
(add-hook 'cperl-mode-hook '(lambda () (yas-minor-mode)))

;; load org
(require 'org)

;; need by org-babel export src highlight
(require 'htmlize)

;; org-mode project define
(setq org-publish-project-alist
      '(
        ("org-blog-content"
         ;; Path to your org files.
         :base-directory "~/ChinaXing.org/org/"
         :base-extension "org"

         ;; Path to your HiD project.
         :publishing-directory "~/ChinaXing.org/HiD/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4
         :html-extension "html"
         :table-of-contents t
         :body-only t ;; Only export section between <body></body>
         )

        ("org-blog-static"
         :base-directory "~/ChinaXing.org/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php\\|svg"
         :publishing-directory "~/ChinaXing.org/HiD/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("blog" :components ("org-blog-content" "org-blog-static"))
        ))

(setq org-src-fontify-natively t)
;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (emacs-lisp . t)
   (sh . t)
   (perl . t)
   (python .t)
   ))
;; add [[img:logo.png][logo]] support
(defun org-custom-link-img-follow (path)
  (org-open-file-with-emacs  path))
(defun org-custom-link-img-export (path desc format)
  (cond
   ((eq format 'html)
    (format "<img src=\"/%s\" alt=\"%s\"/>"
            (replace-regexp-in-string "^\\(\\.\\./\\|\\./\\)+" ""  path)
            desc))))
(org-add-link-type "img" 'org-custom-link-img-follow 'org-custom-link-img-export)

(add-to-list 'iimage-mode-image-regex-alist
             (cons (concat "\\[\\[img:\\(~?" iimage-mode-image-filename-regex "\\)\\]") 1))

;; ibus-mode
;;(require 'ibus)
;;(add-hook 'after-init-hook 'ibus-mode-on)
;;(global-set-key (kbd "C-\\") 'ibus-toggle)
