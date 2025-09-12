(let ((dir (locate-user-emacs-file "lisp")))
  (add-to-list 'load-path (file-name-as-directory dir)))

(with-temp-message ""
  (require 'init-ui)
  (require 'init-edit)
  )

