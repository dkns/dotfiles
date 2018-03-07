;;; package --- Summary -*- lexical-binding: t; -*-
;;; Code:
;;; Commentary:

(setq load-prefer-newer t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '(("melpa" . "https://melpa.org/packages/")
               ("gnu" . "https://elpa.gnu.org/packages/")
               ("org" . "https://orgmode.org/elpa/"))
             )

(package-initialize)

(defvar dkns/emacs-dir (eval-when-compile (file-truename user-emacs-directory))
  "Path to this emacs.d directory.")

(defvar dkns/cache-dir (concat dkns/emacs-dir "cache/")
  "Directory for volatile storage.
Use this for files that change often, like cache files.")

(setq custom-file (concat dkns/cache-dir "/custom.el"))

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
(set-face-attribute 'default nil
                    :family "Source Code Pro"
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

;; packages
(use-package evil
  :ensure t
  :init
  (with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)) ;; treat _ and - as part of words
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
  :ensure
  :config
  (evil-leader/set-key "v" 'dkns/open-window-vertically)
  (evil-leader/set-key "h" 'dkns/open-window-horizontally)
  (evil-leader/set-key "d v" 'describe-variable)
  (evil-leader/set-key "d f" 'describe-function)

  (progn
      (evil-leader/set-leader "<SPC>")
      (global-evil-leader-mode t))
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
  :defer t
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

(use-package git-gutter-fringe
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'git-gutter)
  (setq-default fringes-outside-margins t)
  ;; thin fringe bitmaps
  ;; stolen from https://github.com/hlissner/.emacs.d
  )

(use-package darktooth-theme
  :ensure t
  :config
  (load-theme 'darktooth t)
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
  :config

  (global-company-mode)
  (setq company-idle-delay 0.2)
  (setq company-selection-wrap-around t)
  (define-key company-active-map [tab] 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  )

(use-package company-tern
  :ensure t
  :config
  (add-to-list 'company-backends 'company-tern)
  )

(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-mode)
  )

(provide 'init)
;;; init.el ends here
