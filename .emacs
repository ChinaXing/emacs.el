(setq debug-on-error t)

;; iimage mode
(iimage-mode)

;; color-theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-pok-wob)

;; .emacs -- Emacs::PDE
(add-to-list 'load-path "~/.emacs.d/pde/")
(load "pde-load")

;; yasnippet -- Yet another snippet
(require 'yasnippet)
(yas/initialize)

;; load org
(require 'org)

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

;; org-mode project define
(setq org-publish-project-alist
      '(
        ("org-blog-content"
         ;; Path to your org files.
         :base-directory "~/ChinaXing.org/org/"
         :base-extension "org"

         ;; Path to your jekyll project.
         :publishing-directory "~/ChinaXing.org/jekyll/"
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
         :publishing-directory "~/ChinaXing.org/jekyll/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("blog" :components ("org-blog-content" "org-blog-static"))
        ))
;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (emacs-lisp . t)
   (sh . t)
   (perl . t)
   (python .t)
   ))
(setq org-src-fontify-natively t)

;; weibo
(add-to-list 'load-path "~/.emacs.d/weibo.emacs/")
(require 'weibo)

;; ibus-mode
(require 'ibus)
(add-hook 'after-init-hook 'ibus-mode-on)
(global-set-key (kbd "C-\\") 'ibus-toggle)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
