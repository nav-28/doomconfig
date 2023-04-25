(setq user-full-name "Pranav"
      user-mail-address "pwadhwa@ualberta.ca")
;; font i use
(setq doom-font (font-spec :family "MesloLGS NF" :size 15 :weight 'regular)
       doom-variable-pitch-font (font-spec :family "SF Pro Text" :size 13))

(setq doom-theme 'doom-tokyo-night)
(setq org-directory "~/org/")

(setq display-line-numbers-type 'relative)


(setq explicit-shell-file-name "/bin/zsh")
(setq
   split-width-threshold 0
   split-height-threshold nil)

;; change garbage collector threshold
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

;; title
(setq-default frame-title-format '("hey bro, just FYI, this file is called %b or something"))

;; Don't show line numbers in org mode
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode 0)))

;; always use swipl as the inferior prolog process
(setq prolog-program-name "swipl")

(require 'treemacs-extensions)
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
  ;; Optional - enable lsp-mode automatically in scala files
  ;; You could also swap out lsp for lsp-deffered in order to defer loading
  :hook  (scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
  :config
  ;; Uncomment following section if you would like to tune lsp-mode performance according to
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  (setq gc-cons-threshold 100000000) ;; 100mb
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)
  (setq lsp-log-io nil)
  (setq lsp-completion-provider :capf)
  (setq lsp-prefer-flymake nil)
  ;; Makes LSP shutdown the metals server when all buffers in the project are closed.
  ;; https://emacs-lsp.github.io/lsp-mode/page/settings/mode/#lsp-keep-workspace-alive
  (setq lsp-keep-workspace-alive nil))

(use-package company
  :hook (scala-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf))


(use-package dart-mode
  :config
  (setq-local doom-modeline-major-mode-icon nil))

(setq lsp-dart-flutter-widget-guides nil)
(setq lsp-dart-outline nil)
(setq emojify-mode nil)

;; prettier-js config
(add-hook 'typescript-mode-hook 'lsp)
(add-hook 'js2-mode-hook 'lsp)
(add-hook 'web-mode-hook 'lsp)

;; format code on save
;;(add-hook 'scala-mode-hook 'format-all-mode)
;;(add-hook 'typescript-mode-hook 'format-all-mode)
;;(add-hook 'js2-mode-hook 'format-all-mode)
;;(add-hook 'web-mode-hook 'format-all-mode)
;;(add-hook 'dart-mode-hook 'format-all-mode)
;;

;; make emacs transparent
(set-frame-parameter (selected-frame) 'alpha '(95 . 95))
(add-to-list 'default-frame-alist '(alpha . (95 . 95)))
