(defvar wsain-dir (file-name-directory load-file-name)
  "The root dir of the Emacs conf.")

(defvar wsain-lisp-dir (expand-file-name "lisp" wsain-dir)
  "The home of wsain's basic functionality.")

(defvar wsain-modules-dir (expand-file-name "modules" wsain-lisp-dir)
  "The home of wsain's module configs.")

(defvar wsain-themes-dir (expand-file-name "themes" wsain-lisp-dir)
  "The home of wsain's themes.")

(add-to-list 'load-path wsain-lisp-dir)
(add-to-list 'load-path wsain-modules-dir)
(add-to-list 'load-path wsain-themes-dir)

(require 'init-ui)
(require 'init-edit)
(require 'init-straight)

(require 'wsain-module-ivy)

(straight-use-package 'org-mode)
(straight-use-package 'org-noter)
(straight-use-package 'pdf-tools)

(straight-use-package 'markdown-mode)
(straight-use-package 'imenu-list)

(straight-use-package 'treemacs)

(add-to-list 'custom-theme-load-path wsain-themes-dir)
(load-theme 'gruber-darker t)

