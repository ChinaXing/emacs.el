(setq debug-on-error t)

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
