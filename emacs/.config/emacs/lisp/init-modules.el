(defvar wsain-basic-modules-dir (expand-file-name "modules-basic" wsain-lisp-dir)
  "The home of wsain's basic module configs.")
(defvar wsain-lang-modules-dir (expand-file-name "modules-lang" wsain-lisp-dir)
  "The home of wsain's lang module configs.")
(defvar wsain-themes-dir (expand-file-name "custom-themes" wsain-lisp-dir)
  "The home of wsain's themes.")

(add-to-list 'load-path wsain-basic-modules-dir)
(add-to-list 'load-path wsain-lang-modules-dir)
(add-to-list 'custom-theme-load-path wsain-themes-dir)

;; basic modules
(require 'wsain-module-ivy)
(require 'wsain-module-which-key)
(require 'wsain-module-themes)
(require 'wsain-module-org)
(require 'wsain-module-pdf)
(require 'wsain-module-ui)

;; lang modules
(require 'wsain-module-lisp)

;; others
(straight-use-package 'markdown-mode)
(straight-use-package 'imenu-list)

(straight-use-package 'treemacs)

(straight-use-package 'zoxide)

(provide 'init-modules)
