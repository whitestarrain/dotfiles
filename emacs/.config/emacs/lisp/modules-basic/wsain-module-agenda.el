(make-directory "~/Agenda" t)
(setq org-agenda-files '("~/Agenda"))
(setq org-default-notes-file "~/Agenda/default.org")

;; ;; https://github.com/rougier/svg-tag-mode
;; (straight-use-package 'svg-tag-mode)
;; ;; for linux, svg-lib default use 96 dpi to calculation, computer that use other dpi need scale
;; (with-eval-after-load 'svg-tag-mode-autoloads
;;   (setq svg-lib-style-default '(:background "#282828"
;;                               :foreground "#ebdbb2"
;;                               :padding 1
;;                               :margin 0
;;                               :stroke 2
;;                               :radius 3
;;                               :alignment 0.5
;;                               :width 20
;;                               ;; :height 0.9
;;                               :height 0.45
;;                               ;; :scale 0.75
;;                               :scale 0.4
;;                               :ascent center
;;                               :crop-left nil
;;                               :crop-right nil
;;                               :collection "material"
;;                               :font-family "JetBrainsMono Nerd Font"
;;                               ;; :font-size 12
;;                               :font-size 6
;;                               :font-weight regular)))
;;

(provide 'wsain-module-agenda)
