;;; package --- Summary
;;; Code:
;;; Commentary:

(setq load-prefer-newer t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; basic config stuff
(setq-default indent-tabs-mode nil) ;; don't use spaces
(global-auto-revert-mode t) ;; automatically refresh buffers when file changes

(eval-when-compile
  (require 'use-package))

(require 'bind-key)
(require 'diminish)

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
(remove-hook 'find-file-hooks 'vc-find-file-hook)

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

;; packages
(use-package evil
  :ensure t
  :init
  (use-package evil-leader
    :ensure
    :config
    (evil-leader/set-key "v" 'dkns/open-window-vertically)
    (evil-leader/set-key "h" 'dkns/open-window-horizontally)

    (progn
        (evil-leader/set-leader "<SPC>")
        (global-evil-leader-mode t))
    )
  (with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)) ;; treat _ and - as part of words
  :config
  (progn
    (evil-mode 1)
    (setq evil-want-fine-undo t))
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
  (which-function-mode)
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
  (load-theme 'darktooth-theme t)
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
      (diminish 'visual-line-mode)))

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

(use-package helm
  :ensure t
  :config
  
  (helm-mode 1)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-fuzzy-match-fn t)
  (global-set-key (kbd "M-x") 'helm-M-x)
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

(use-package company-term
  :ensure t
  :config
  (add-to-list 'company-backends 'company-tern)
  )

(use-package helm-flx
  :ensure t
  :config
  (helm-flx-mode +1)
  (setq helm-flx-for-helm-find-files t)
  (setq helm-flx-for-helm-locate t)
  )

(use-package helm-fuzzier
  :ensure t
  :config
  (helm-fuzzier-mode 1)
  )

(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-mode)
  )

(use-package helm-projectile
  :bind (("C-S-P" . helm-projectile-switch-project)
         :map evil-normal-state-map
         ("C-p" . helm-projectile))
  :ensure t
  :config
  (evil-leader/set-key
    "ps" 'helm-projectile-ag
    "pa" 'helm-projectile-find-file-in-known-projects
  )
  )


(provide 'init)
;;; init.el ends here
