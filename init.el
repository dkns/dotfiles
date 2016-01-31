(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;;; from purcell/emacs.d
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(package-initialize)
;; Set up the package manager of choice. Supports "el-get" and "package.el"
(setq pmoc "package.el")

;; List of all wanted packages
(setq
 wanted-packages
 '(
   darktooth-theme
   dash
   emmet-mode
   evil
   evil-jumper
   evil-leader
   evil-matchit
   evil-numbers
   evil-org
   evil-surround
   evil-visualstar
   exec-path-from-shell
   flycheck
   flycheck-pos-tip
   helm
   helm-projectile
   php-mode
   popup
   projectile
   python-mode
   web-mode
   undo-tree
   use-package
   ))

;; Package manager and packages handler
(defun install-wanted-packages ()
  "Install wanted packages according to a specific package manager"
  (interactive)
  (cond
   ;; package.el
   ((string= pmoc "package.el")
    (require 'package)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
    (package-initialize)
    (let ((need-refresh nil))
      (mapc (lambda (package-name)
          (unless (package-installed-p package-name)
        (set 'need-refresh t))) wanted-packages)
      (if need-refresh
      (package-refresh-contents)))
    (mapc (lambda (package-name)
        (unless (package-installed-p package-name)
          (package-install package-name))) wanted-packages)
    )
   ;; fallback
   (t (error "Unsupported package manager")))
  )

;; Install wanted packages
(install-wanted-packages)

(require 'use-package)
(require 'diminish)
(require 'bind-key)

;; evil
(global-evil-leader-mode)
(require 'evil)
(evil-mode 1)
(global-evil-matchit-mode t)
(global-evil-surround-mode t)
(evil-leader/set-leader "SPC")
(setq evil-leader/in-all-states t)
(setq evil-emacs-state-cursor '("red" box)
      evil-normal-state-cursor '("green" box)
      evil-visual-state-cursor '("orange" box)
      evil-insert-state-cursor '("red" bar)
      evil-replace-state-cursor '("red" bar)
      evil-operator-state-cursor '("red" hollow))
(setq evil-search-module 'evil-search
      evil-want-C-u-scroll t
      evil-want-C-w-in-emacs-state t)

;; open splits
(defun my-open-window-vertically ()
  (interactive)
  (split-window-vertically)
  (windmove-down))
(defun my-open-window-horizontally ()
  (interactive)
  (split-window-horizontally)
  (windmove-right))

(evil-leader/set-key "v" 'my-open-window-vertically)
(evil-leader/set-key "h" 'my-open-window-horizontally)
;; navigate splits
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

;; j and k move the visual line in long wrapped lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;; esc quits!
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
    In Delete Selection mode, if the mark is active, just deactivate it;
    then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

(global-set-key (kbd "RET") 'newline-and-indent)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Who use the bar to scroll?
(scroll-bar-mode 0)

;; word wrapping
(global-visual-line-mode t)
;; ===== Set the highlight current line minor mode =====

;; In every buffer, the line which contains the cursor will be fully
;; highlighted

(global-hl-line-mode -1)

;; ========== Enable Line and Column Numbering ==========

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

;; Line number displayed on left hand side
(global-linum-mode 1)

;; Theme
(load-theme 'darktooth t)

;; Editing html/css/js/php files
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . php-mode)) ;; decide wheter to use php-mode or web-mode for php files
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\''" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)
(setq-default show-paren-delay 0)

;; Highlight tabulations
(setq-default highlight-tabs t)

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)

;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; show spaces, tabs and stuff
(setq whitespace-style '(face
                         tabs
                         tab-mark
                         trailing))
(global-whitespace-mode)

;; show popup when using flycheck
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

(defvar my-linum-format-string "%5d")
(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)

(defun my-linum-get-format-string ()
  ; The + 2 defines the leeway we have in the sidebar
  (let* ((width (+ 3 (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat "%" (number-to-string width) "d")))
    (setq my-linum-format-string format)))

(defvar my-linum-current-line-number 0)

(setq linum-format 'my-linum-relative-line-numbers)

;(propertize (format my-linum-format-string noffset) 'face 'linum)
(defun my-linum-relative-line-numbers (line-number)
    (let ((offset (- line-number my-linum-current-line-number)))
      (if (= offset 0)
          (propertize (format my-linum-format-string line-number) 'face 'linum)
          (propertize (format my-linum-format-string (abs offset)) 'face 'linum))))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)

(blink-cursor-mode (- (*) (*) (*)))

;; projectile mode
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
(helm-projectile-on)

(defvar backup-directory "~/.backups")
(if (not (file-exists-p backup-directory))
    (make-directory backup-directory t))

(global-auto-revert-mode t)
(setq
 make-backup-files t        ; backup a file the first time it is saved
 backup-directory-alist `((".*" . ,backup-directory)) ; save backup files in ~/.backups
 auto-save-file-name-transforms `((".*" ,backup-directory t))
 backup-by-copying t     ; copy the current file into backup directory
 version-control t   ; version numbers for backup files
 delete-old-versions t   ; delete unnecessary versions
 kept-old-versions 6     ; oldest versions to keep when a new numbered backup is made (default: 2)
 kept-new-versions 9 ; newest versions to keep when a new numbered backup is made (default: 2)
 auto-save-default t ; auto-save every buffer that visits a file
 auto-save-timeout 20 ; number of seconds idle time before auto-save (default: 30)
 auto-save-interval 200 ; number of keystrokes between auto-saves (default: 300)
 )

;; set font
(set-frame-font "Inconsolata-11")

;; helm
(require 'helm)
(require 'helm-config)
(helm-mode 1)
(evil-leader/set-key "b" 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t
      helm-M-x-fuzzy-match t
      helm-locate-fuzzy-match t)
(define-key evil-normal-state-map (kbd "C-p") 'helm-for-files)
(define-key evil-normal-state-map (kbd "C-o") 'helm-locate)
(global-set-key (kbd "M-x") 'helm-M-x)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(setq helm-for-files-preferred-list '(
                      helm-source-projectile-files-list
                      helm-source-projectile-recentf-list
                      helm-source-buffers-list
                      helm-source-recentf
                      helm-source-projectile-directories-list
                      helm-source-projectile-projects
                      helm-source-bookmarks
                      helm-source-file-cache
                      helm-source-files-in-current-dir
                      helm-source-moccur
                      helm-source-locate
                      ))

;; remove gui and stuff
(tool-bar-mode 0)
(menu-bar-mode 0)
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; org mode
(require 'org)
(require 'org-habit)
(add-hook 'org-mode-hook 'turn-on-font-lock)
(setq org-log-done t)
(setq org-return-follows-link t)
(setq org-enable-priority-commands t)
(setq org-default-priority ?E)
(setq org-lowest-priority ?E)
(setq org-agenda-files (quote (
                   "~/Dropbox/org/todo.org"
                   "~/Dropbox/org/work.org")))
(setq org-default-notes-file "~/Dropbox/org/refile.org")
(add-to-list 'org-modules "org-habit")
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "DONE")))
(evil-leader/set-key "oa" 'org-agenda)
(evil-leader/set-key "osl" 'org-store-link)
(evil-leader/set-key "oc" 'org-capture)
(evil-leader/set-key-for-mode 'org-mode
  "d" 'org-todo
  "a" 'org-agenda)

(add-hook 'org-mode-hook
	  (lambda ()
	    (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
	    ))

;; display tooltips in echo area
(tooltip-mode -1)

(exec-path-from-shell-initialize)

(add-hook 'python-mode 'run-python)

(require 'emmet-mode)
(setq emmet-move-cursor-between-quotes t)
(evil-leader/set-key "em" 'emmet-expand-line)
(dolist (hook '(sgml-mode-hook html-mode-hook css-mode-hook web-mode-hook))
  (add-hook 'hook 'emmet-mode))

(defun dkns/web-mode ()
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-enable-current-element-highlight t))

(add-hook 'web-mode-hook 'dkns/web-mode)
(modify-syntax-entry ?_ "w")
(modify-syntax-entry ?- "w")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["color-237" "#D75F5F" "#AFAF00" "#FFAF00" "#87AFAF" "#D787AF" "#87AF87" "color-223"])
 '(custom-safe-themes (quote ("8855d6dbd8b4ea5d87146dc77ba1b8b7f06142ee8107429f0520c38777d9b39e" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "13590cc9554286c8e893463fd8e0dad7134d6b7db10060afbb6850db3e395f17" default)))
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(pos-tip-background-color "color-23")
 '(pos-tip-foreground-color "color-230"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package quickrun
  :ensure t)

(use-package evil-commentary
  :ensure t
  :defer t
  :diminish evil-commentary-mode
  :init
  (evil-commentary-mode))

(defun run-python-once ()
  (remove-hook 'python-mode-hook 'run-python-once)
  (run-python))

(add-hook 'python-mode-hook 'dkns/python-mode-hook)
(add-hook 'python-mode-hook 'run-python-once)

;; smartparens
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1))

(use-package js2-mode
  :ensure t)

(define-key global-map (kbd "RET") 'newline-and-indent)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2))

;; python-mode
;; ============
;; pre-requisites on ubuntu
;; sudo pip install --upgrade pip
;; sudo pip install jedi json-rpc --upgrade

(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            (setq python-indent-offset 4)))

(use-package anaconda-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'eldoc-mode))

(use-package company-anaconda
  :ensure t
  :config
  (add-to-list 'company-backends 'company-anaconda))

(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell) ;; if you want eshell support
  (setq venv-location "~/.virtualenvs/"))

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode t)
  (vhl/define-extension 'my-evil-highlights 'evil-yank 'evil-delete 'evil-paste-after)
  (vhl/install-extension 'my-evil-highlights))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode 'python-mode))

(use-package smooth-scroll
  :ensure t
  :config
  (smooth-scroll-mode 1)
  (setq smooth-scroll/vscroll-step-size 5)
  )

(use-package tldr
  :ensure t)

(use-package multi-web-mode
  :ensure t
  :config
  (setq mweb-default-major-mode 'html-mode)
  (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
		    (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
		    (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
  (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
  (multi-web-global-mode 1))

(use-package evil-escape
  :ensure t
  :config
  (setq-default evil-escape-key-sequence "jk"))

(use-package edbi
  :ensure t)

(use-package cider
  :ensure t)

(use-package alert
  :ensure t)

(use-package beacon
  :ensure t
  :defer 2
  :config
  (beacon-mode 1))
