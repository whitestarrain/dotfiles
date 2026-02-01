(straight-use-package 'posframe)
(setq default-input-method "rime")
(use-package rime
  :straight t
  :custom
  (rime-emacs-module-header-root (concat (shell-command-to-string "nix eval --raw nixpkgs#emacs") "/include"))
  (rime-librime-root (shell-command-to-string "nix eval --raw nixpkgs#librime"))
  (rime-share-data-dir (concat (shell-command-to-string "nix eval --raw /etc/nixos#nixosConfigurations.R9000K.config.home-manager.users.wsain.i18n.inputMethod.package") "/share/rime-data"))
  (rime-show-candidate 'posframe)
  :config
  (setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            :internal-border-width 10)))

;; (setq rime-translate-keybindings
;;           '("C-f" "C-b" "C-n" "C-p" "C-g" "<left>" "<right>" "<up>" "<down>" "<prior>" "<next>" "<delete>"))

(provide 'wsain-module-nixos-rime)
