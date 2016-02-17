(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; open splits
(defun my-open-window-vertically ()
  (interactive)
  (split-window-vertically)
  (windmove-down))
(defun my-open-window-horizontally ()
  (interactive)
  (split-window-horizontally)
  (windmove-right))
