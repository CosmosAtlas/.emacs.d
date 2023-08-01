;; fresh emacs-v2

;;
;; Startup Configuration
;;

(setq gc-cons-threshold (* 50 1000 1000))

;; remove useless UI
(when window-system
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (set-fringe-mode 10)
  (menu-bar-mode -1))

;; cleaner interface
(setq inhibit-startup-message t)
(setq initial-scratch-message "")


;; determine platform running
(defvar cz/windows-p (eq system-type 'windows-nt))
(defvar cz/linux-p (eq system-type 'gnu/linux))


;; setup straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package straight
  :config
  (setq straight-use-package-by-default t))

;; load org here using straight to deal with version mismatch issues
(straight-use-package 'org)

;; (defvar org--inhibit-version-check nil)

;; Emacs built-in configurations
(org-babel-load-file (expand-file-name "configs/built-in.org" user-emacs-directory))

;; setup evil first, so always vim bindings!
(org-babel-load-file (expand-file-name "configs/evil.org" user-emacs-directory))

;; load other settings
(org-babel-load-file (expand-file-name "configs/keys.org" user-emacs-directory))  ; load keybinding setup first
(org-babel-load-file (expand-file-name "configs/appearance.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "configs/org.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "configs/minibuffer.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "configs/behavior-enhancements.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "configs/project-management.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "configs/completion.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "configs/magit.org" user-emacs-directory))

;; managing custom files
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
