(setq user-full-name "Pranav"
      user-mail-address "pwadhwa@ualberta.ca")
;; font i use
(setq doom-font (font-spec :family "MesloLGS NF" :size 15 :weight 'regular)
       doom-variable-pitch-font (font-spec :family "SF Pro Text" :size 13))

(setq doom-theme 'doom-dark+)
(setq org-directory "~/org/")

(setq display-line-numbers-type 'relative)


(setq explicit-shell-file-name "/bin/zsh")
(setq
   split-width-threshold 0
   split-height-threshold nil)

;; change garbage collector threshold
;; change max bytes read from subprocess cause emacs for OSX has a lower value and causes error in metals
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

;; title
(setq-default frame-title-format '("hey bro, just FYI, this file is called %b or something"))

;; add dart mode to run flutter and dart apps in emacs
(add-hook 'dart-mode-hook 'lsp)
