;;; init-edit.el --- Editing settings -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:

(setq make-backup-files nil)                                  ; 不自动备份
(setq auto-save-default nil)                                  ; 不使用Emacs自带的自动保存


;; 解除不常用的快捷键定义
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "s-q") nil)
;; (global-set-key (kbd "M-z") nil)
;; (global-set-key (kbd "M-m") nil)
(global-set-key (kbd "C-x C-z") nil)
;; (global-set-key [mouse-2] nil)


;; Directly modify when selecting text
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

;; (message "init-base configuration: %.2fs"
;;          (float-time (time-subtract (current-time) my/init-base-start-time)))

(provide 'init-edit)

