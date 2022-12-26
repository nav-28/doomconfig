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

;; treemacs icons
(setq doom-themes-treemacs-theme "doom-colors")

;; add dart mode to run flutter and dart apps in emacs
(add-hook 'dart-mode-hook 'lsp)

;; scala metals

(use-package scala-mode
  :interpreter ("scala" . scala-mode))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package lsp-mode
  :hook  (scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
  :config
  ;; Uncomment following section if you would like to tune lsp-mode performance according to
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  (setq gc-cons-threshold 100000000) ;; 100mb
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)
  ;; (setq lsp-log-io nil)
  ;; (setq lsp-completion-provider :capf)
  (setq lsp-prefer-flymake nil)
  ;; Makes LSP shutdown the metals server when all buffers in the project are closed.
  ;; https://emacs-lsp.github.io/lsp-mode/page/settings/mode/#lsp-keep-workspace-alive
  (setq lsp-keep-workspace-alive nil))


(use-package company
  :hook (scala-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf))

(use-package dap-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode))


;; prettier-js config
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'rjsx-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'lsp)
(add-hook 'js2-mode-hook 'lsp)
