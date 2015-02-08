;;; init.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 24, 2012
;; Keywords: .emacs, el-get, ELPA

;;; This file is NOT part of GNU Emacs.

;;; License:
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; https://github.com/emacs-jp/init-loader

;;; Change Log:
;;

;;; Code:

(require 'cl-lib)

;;;; Installed packages via el-get
;; Fix original recipes
(setq el-get-sources
      '((:name dired+ :autoloads nil)
        (:name direx :depends popwin)
        (:name helm :autoloads nil :before (setq dired-bind-jump nil) :features helm-config)
        (:name helm-descbinds :prepare nil :library helm :after (helm-descbinds-mode +1))
        (:name helm-ls-git :depends (helm magit))
        (:name helm-migemo :depends (helm migemo))
        (:name helm-swoop :depends (helm migemo helm-migemo))
        (:name highlight-indentation :features highlight-indentation)
        (:name smartparens :features smartparens-config)
        (:name smartrep :features smartrep)
        (:name pcache
               :before (setq pcache-directory (concat user-emacs-directory "var/cache/pcache/")))
        (:name popwin :features popwin)
        (:name powerline :autoloads nil)
        (:name projectile :depends (dash helm s f pkg-info))
        (:name twittering-mode :features nil)
        (:name undo-tree :features undo-tree)
        (:name yasnippet :autoloads "yasnippet.el" :features yasnippet)))

(defvar jkw:el-get-package-list-from-recipe
  '(ace-isearch ace-jump-mode ace-window ag anzu auto-async-byte-compile auto-complete
                cl-lib-highlight cssm-mode dash-at-point dired-sync e2wm e2wm-bookmark
                eldoc-extension elisp-slime-nav emmet-mode expand-region foreign-regexp
                flycheck geben gist git-gutter-fringe goto-chg grep-a-lot helm-ag
                helm-c-yasnippet highlight-defined highlight-symbol info+ js2-mode
                linum-relative lispxmp magit markdown-mode migemo monokai-emacs
                multiple-cursors mykie org-mode php-completion php-mode psvn rainbow-mode
                recentf-ext scratch-ext sequential-command smart-newline tern viewer
                web-mode wgrep)
  "List of packages I use straight from recipe files.")

;;;; Internal functions
(defvar init-module-modules-directory (concat user-emacs-directory "modules/")
  "`init-module-modules-directory' contains init modules.")

(defvar init-module-safe-mode-p (file-exists-p (concat user-emacs-directory "var/log/init-module-error"))
  "Return t as safe mode if init-module-error file exists.")

(defun init-module--list-files (regexp)
  "Show init modules containing a match for REGEXP in `init-module-modules-directory'.

If a elisp file has a byte-compiled file, show the byte-compiled file only."
  (cl-loop for el in (directory-files init-module-modules-directory t)
           when (and (string-match regexp (file-name-nondirectory el))
                     (or (string-match "elc\\'" el)
                         (and (string-match "el\\'" el)
                              (not (locate-library (concat el "c"))))))
           collect (file-name-nondirectory el)))

(defun init-module--load-files (regexp)
  "Load init modules matching the REGEXP specified."
  (cl-loop for mod in (init-module--list-files regexp)
           do (condition-case err
                  (load (file-name-sans-extension mod))
                (error
                 (message (format "Error in init-module %s. %s"
                                  (file-name-sans-extension mod)
                                  (error-message-string err)))))))

;;;; Command
;; Need to init after loading el-get
(defun el-get-initialize-packages ()
  "Install packages via `el-get', and initialize them."
  (interactive)
  (el-get 'sync 'el-get)
  (let* ((src (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources)))
         (pkg (append src jkw:el-get-package-list-from-recipe)))
    (el-get 'sync pkg)))

(defun init-module-initialize ()
  "Initialize Emacs init files."
  (interactive)
  ;; Minimum config
  (init-module--load-files "\\`pre-init-")

  (unless init-module-safe-mode-p
    ;; Environment-dependent config
    (if (null window-system)
        (init-module--load-files "\\`cui-init-")
      (init-module--load-files "\\`gui-init-"))

    ;; el-get installer
    (if (require 'el-get nil t)
        (el-get-initialize-packages)
      (url-retrieve
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
       (lambda (s)
         (let (el-get-master-branch)
           (goto-char (point-max)) (eval-print-last-sexp)
           ;; After el-get is installed, inits ELPA and builds its recipe files,
           ;; finally installes all packages I use.
           (el-get 'sync 'package) (package-initialize)
           (el-get-initialize-packages)))))

    ;; Advanced config
    (init-module--load-files "\\`opt-init-")
    (init-module--load-files "\\`post-init-")))

;;;; Bootstrap
(add-to-list 'load-path init-module-modules-directory)
(setq custom-file (concat user-emacs-directory "modules/pre-init--custom.el"))

;; Need to init before loading el-get
(unless init-module-safe-mode-p
  (setq el-get-dir (concat user-emacs-directory "vendor/"))
  (setq package-user-dir (file-name-as-directory (concat el-get-dir "package/elpa")))
  (setq el-get-user-package-directory (concat user-emacs-directory "configs"))
  (with-eval-after-load 'el-get
    (add-to-list 'el-get-recipe-path (concat user-emacs-directory "etc/recipes/")))
  (add-to-list 'load-path (file-name-as-directory (concat el-get-dir "el-get"))))

(init-module-initialize)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init.el ends here
