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

(evil-leader/set-key "v" 'dkns/open-window-vertically)
(evil-leader/set-key "h" 'dkns/open-window-horizontally)

;; settings
(show-paren-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(remove-hook 'find-file-hooks 'vc-find-file-hook)

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

(use-package darktooth-theme
  :ensure t
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

(use-package nlinum-relative
  :ensure t
  :config
  (nlinum-relative-setup-evil)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0)
  )

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
  :config
  (volatile-highlights-mode t)
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

(provide 'init)
;;; init.el ends here

