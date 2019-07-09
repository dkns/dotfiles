;;; package --- Summary -*- lexical-binding: t; -*-
;;; Code:
;;; Commentary:

(setq load-prefer-newer t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             )

(package-initialize)

(defvar dkns/emacs-dir (eval-when-compile (file-truename user-emacs-directory))
  "Path to this emacs.d directory.")

(defvar dkns/cache-dir (concat dkns/emacs-dir "cache/")
  "Directory for volatile storage.
Use this for files that change often, like cache files.")

(setq custom-file (concat dkns/cache-dir "/custom.el"))
(setq vc-follow-symlinks nil)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; basic config stuff
(setq-default indent-tabs-mode nil) ;; don't use spaces
(global-auto-revert-mode t) ;; automatically refresh buffers when file changes
(setq linum-format "%d ")

(eval-when-compile
  (require 'use-package))

(require 'bind-key)

;; open splits
(defun dkns/open-window-vertically ()
  "Open window to the bottom."
  (interactive)
  (split-window-vertically)
  (windmove-down))
(defun dkns/open-window-horizontally ()
  "Open window to the right."
  (interactive)
  (split-window-horizontally)
  (windmove-right))

;; settings
(show-paren-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
;; global hooks
(remove-hook 'find-file-hooks 'vc-find-file-hook)
(add-hook 'prog-mode-hook 'linum-mode)

;; Set default font
(cond
 ((find-font (font-spec :name "DejaVu Sans Mono"))
  (defvar dkns/default-font "DejaVu Sans Mono"))
 ((find-font (font-spec :name "Iosevka Regular"))
  (defvar dkns/default-font "Iosevka Regular")))

(set-face-attribute 'default nil
                    :family dkns/default-font
                    :height 110
                    :weight 'normal
                    :width 'normal)

;;; backups and all that stuff
;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
    `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
    `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
    emacs-tmp-dir)

;; modeline

(setq-default mode-line-format
              '(
                "%e"
                mode-line-front-space
                mode-line-client
                mode-line-modified
                " | "
                mode-line-buffer-identification
                " | "
                (flycheck-mode flycheck-mode-line)
                " | "
                mode-line-modes
                mode-line-end-spaces
                )
              )

;; custom keybinds
(defun dkns/edit-init ()
  "Automatically find and edit init file."
  (interactive)
  (find-file "/home/daniel/dotfiles/emacs/init.el")
  )

; ;; packages
; (use-package use-package
;  :custom
;  (use-package-verbose t)
;  (use-package-always-ensure t)
;  (use-package-always-defer t))

(setq exec-path (append exec-path '("~/.nvm/versions/node/v10.14.2/bin")))

(use-package evil
  :ensure t
  :init
  (with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)) ;; treat _ and - as part of words
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
  (progn
    (evil-mode 1)
    (setq evil-want-fine-undo t))
  )

(use-package evil-leader
  :ensure t
  :after evil
  :config
  (evil-leader/set-key "v" 'dkns/open-window-vertically)
  (evil-leader/set-key "h" 'dkns/open-window-horizontally)
  (evil-leader/set-key "d v" 'describe-variable)
  (evil-leader/set-key "d f" 'describe-function)
  (evil-leader/set-key "d k" 'describe-key)
  (evil-leader/set-key "e i" 'dkns/edit-init)

  (progn
      (evil-leader/set-leader "<SPC>")
      (global-evil-leader-mode t))
  )

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-magit
  :ensure t
  :after evil
  )

(use-package php-mode
  :ensure t
  :defer t
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.php$" . php-mode)))
  )

(use-package js2-mode
  :ensure t
  :defer t
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))
  )

(use-package org
  :ensure t
  :defer t
  )

(use-package flycheck
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'flycheck-mode)
  )

(use-package which-func
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'which-function-mode)
  )

(use-package which-key
  :ensure t
  :config
  (require 'which-key)
  (which-key-mode)
  )

(use-package auto-compile
  :ensure t
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

(use-package evil-escape
  :ensure t
  :config
  (setq-default evil-escape-key-sequence "ESCESC")
  )

(use-package magit
  :ensure t
  :bind
  (:map evil-normal-state-map ("<SPC> g s" . magit-status))
  )

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode)
  )

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  )

(use-package volatile-highlights
  :ensure t
  :after 'evil
  :init
  (volatile-highlights-mode t)
  :config
  (vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before
                        'evil-paste-pop 'evil-move)
  (vhl/install-extension 'evil)
  )

(use-package web-mode
  :ensure t
  :config
    (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
    (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  )

(use-package adaptive-wrap
  :ensure t
  :config
  (with-eval-after-load 'adaptive-wrap
  (setq-default adaptive-wrap-extra-indent 2))

  (add-hook 'visual-line-mode-hook
    (lambda ()
      (adaptive-wrap-prefix-mode +1)
      ))

  (global-visual-line-mode +1)
  )

(use-package jinja2-mode
  :ensure t
  )

(use-package fzf
  :ensure t
  )

(use-package indium
  :ensure t
  )

(use-package company
  :ensure t
  :diminish company-mode
  :init
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)
  (setq company-require-match nil)
  (setq company-dabbrev-downcase nil)
  (setq company-selection-wrap-around t)
  (setq company-tooltip-flip-when-above t)
  (setq company-tooltip-align-annotations t)
  :bind
  (:map company-active-map
   ("TAB"      . company-complete-common-or-cycle)
   ([tab]      . company-complete-common-or-cycle)
   ("S-TAB"    . company-select-previous-or-abort)
   ([backtab]  . company-select-previous-or-abort)
   ([S-tab]    . company-select-previous-or-abort)
   ("C-p"      . company-select-previous-or-abort)
   ("C-n"      . company-select-next-or-abort)
   ("C-l"      . company-complete-selection))
  :config
  (global-company-mode)
  )

(use-package projectile
  :ensure t
  :defer t
  :after (evil)
  :config
  (projectile-mode)
  :bind (:map evil-normal-state-map ("<SPC> l" . projectile-switch-project))
  )

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :init
  (global-git-gutter-mode)

  :config
  (use-package git-gutter-fringe
    :ensure t))

(use-package lsp-mode
  :commands lsp
  :ensure t
  :config
  (require 'lsp-clients)
  (setq lsp-prefer-flymake nil)
  (add-hook 'prog-mode-hook #'lsp)
  )

(use-package typescript-mode
  :ensure t)

(use-package lsp-ui
  :ensure t
  :custom
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-sideline-enable t)
  (lsp-ui-peek-peek-height 5))

(use-package company-lsp
    :ensure t
    :commands company-lsp
    :config
    (push 'company-lsp company-backends))

(use-package yaml-mode
  :ensure t
  )

(use-package dtrt-indent
  :ensure t
  :diminish dtrt-indent-mode
  :config
  (dtrt-indent-global-mode)
  )

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
  )

(use-package dockerfile-mode
  :ensure t
  )

(use-package docker-compose-mode
  :ensure t)

(use-package docker-tramp
  :ensure t)

(use-package oceanic-theme
  :config
  (load-theme 'oceanic t)
  :ensure t)

(use-package dap-mode
  :ensure t
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  (require 'dap-chrome)
  (require 'dap-firefox)
  (require 'dap-node)
  )

(use-package helm
  :ensure t
  :diminish helm-mode
  :bind
  (:map evil-normal-state-map ("<SPC> b" . 'helm-buffer-list))
  :config
  (helm-mode 1)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (setq helm-mode-fuzzy-match t
        helm-completion-in-region-fuzzy-match t)
  )

(use-package helm-projectile
  :ensure t
  :config
  (global-set-key (kbd "C-S-p") 'helm-projectile-switch-project)
  (global-set-key (kbd "C-p") 'helm-projectil-find-file)
  )

(use-package helm-dash
  :ensure t
  :after helm)

(use-package diminish
  :ensure t)

(when (not (version< emacs-version "25.2"))
  (use-package treemacs
    :ensure t
    )
  )

(provide 'init)
;;; init.el ends here
