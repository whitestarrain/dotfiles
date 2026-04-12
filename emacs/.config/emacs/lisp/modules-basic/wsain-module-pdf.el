(straight-use-package '(org-noter :type git :host github :repo "org-noter/org-noter"))
(setq org-noter-always-create-frame nil)

(straight-use-package 'pdf-tools)
;; `M-x describe-variable RET features RET` to get feature name
(with-eval-after-load 'pdf-tools-autoloads
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook 'pdf-view-fit-height-to-window)
  (add-hook 'pdf-view-mode-hook 'pdf-view-roll-minor-mode)
  (add-to-list 'auto-mode-alist '("\\.[pP][dD][fF]\\'" . pdf-view-mode))
  (add-to-list 'magic-mode-alist '("%PDF" . pdf-view-mode))

  ;; auto translate word
  (add-hook 'pdf-view-mode-hook (lambda()
                                  (add-hook 'activate-mark-hook 'wsain/pdf-view-sdcv-trans-mark)))

  ;; delete annotation
  (define-key pdf-view-mode-map (kbd "C-c C-a D") nil)
  (define-key pdf-view-mode-map (kbd "C-c C-a d") 'pdf-annot-delete)
  )


;; extract scanned pdf toc
;;  https://github.com/dalanicolai/doc-tools-toc
;;  https://github.com/yuchen-lea/pdfhelper

;; (straight-use-package '(doc-tools-toc :type git :host github :repo "dalanicolai/doc-tools-toc"))
;; (with-eval-after-load 'pdf-tools-autoloads
;;                       (setq doc-toc-ocr-languages "eng+chi_sim"))


;; translate copy word in pdf


(provide 'wsain-module-pdf)
