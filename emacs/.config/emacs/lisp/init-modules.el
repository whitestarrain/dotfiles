(defvar wsain-basic-modules-dir (expand-file-name "modules-basic" wsain-lisp-dir)
  "The home of wsain's basic module configs.")
(add-to-list 'load-path wsain-basic-modules-dir)

(defvar wsain-lang-modules-dir (expand-file-name "modules-lang" wsain-lisp-dir)
  "The home of wsain's lang module configs.")
(add-to-list 'load-path wsain-lang-modules-dir)

;; press M-x load-library to use
(defvar wsain-option-modules-dir (expand-file-name "modules-option" wsain-lisp-dir)
  "The home of wsain's option module configs.")
(add-to-list 'load-path wsain-option-modules-dir)

(defvar wsain-themes-dir (expand-file-name "custom-themes" wsain-lisp-dir)
  "The home of wsain's themes.")
(add-to-list 'custom-theme-load-path wsain-themes-dir)

;; basic modules
(require 'wsain-module-clipboard)
(require 'wsain-module-git)
(require 'wsain-module-ivy)
(require 'wsain-module-which-key)
(require 'wsain-module-org)
(require 'wsain-module-pdf)
(require 'wsain-module-ui)
(require 'wsain-module-nav)
(require 'wsain-module-completion)
(require 'wsain-module-translate)
(require 'wsain-module-themes)

;; lang modules
(require 'wsain-module-lisp)
(require 'wsain-module-markdown)


(provide 'init-modules)
