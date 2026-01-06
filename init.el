;;; init.el --- Emacs init file  -*- lexical-binding: t; -*-

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 24, 2012
;; Keywords: .emacs

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
;; https://github.com/HKey/el-init

;;; Change Log:
;;

;;; Code:

(eval-when-compile
  (require 'cl-lib))
(require 'site-loaddefs nil t)

;;;; Variables
(defvar init-module-pre-init-regexp "\\`pre-init-"
  "Regular expression of init module name for pre loading.")

(defvar init-module-cui-init-regexp "\\`cui-init-"
  "Regular expression of init module name for no-window Emacs.")

(defvar init-module-gui-init-regexp "\\`gui-init-"
  "Regular expression of init module name for window Emacs.")

(defvar init-module-opt-init-regexp "\\`opt-init-"
  "Regular expression of init module name for optional loading.")

(defvar init-module-lazy-init-regexp "\\`lazy-init-\\(.+\\)\\.elc?\\'"
  "Regular expression of init module name for lazy loading.")

(defvar init-module-post-init-regexp "\\`post-init-"
  "Regular expression of init module name for post loading.")

(defvar init-module-modules-path
  (file-name-as-directory (concat user-emacs-directory "modules"))
  "`init-module-modules-path' contains init modules.")

(defvar init-module-core-path
  (file-name-as-directory (concat init-module-modules-path "core"))
  "`init-module-core-path' contains libraries for initializetion.")

(defvar init-module-builtins-config-path
  (file-name-as-directory (concat init-module-modules-path "builtins-config"))
  "`init-module-builtins-config-path' contains built-in packages' init files.")

(defvar init-module-local-config-path
  (file-name-as-directory (concat init-module-modules-path "local-config"))
  "`init-module-local-config-path' contains local or private init files.")

(defvar init-module-vendors-config-path
  (file-name-as-directory (concat init-module-modules-path "vendors-config"))
  "`init-module-vendors-config-path' contains el-get init files.")

(defvar init-module-initerror-file (concat user-emacs-directory "var/initerror")
  "Log file on loading init modules.")

(defvar init-module-safe-mode-p (file-exists-p init-module-initerror-file)
  "Return t as safe mode if initerror file exists.")

(defvar init-module-has-critical-errors-p nil)
(setq package--init-file-ensured t)
(with-eval-after-load 'package
  (setopt package-enable-at-startup nil))

(defvar custom-file--filename "pre-init-private-custom-variables.el")
(setopt custom-file (concat init-module-local-config-path custom-file--filename))

;;;; Internal functions
(defun init-module--list-files (directory regexp)
  "[internal] Show init modules containing in DIRECTORY with matching REGEXP.

If a elisp file has a byte-compiled file, show the byte-compiled file only."
  (cl-loop for el in (directory-files directory t)
           when (and (string-match regexp (file-name-nondirectory el))
                     (or (string-match "elc\\'" el)
                         (and (string-match "el\\'" el)
                              (not (locate-library (concat el "c"))))))
           collect (file-name-nondirectory el)))

(cl-defun init-module--load-file (file &optional (noerror t))
  "[internal] Load elisp file."
  (let ((module (file-name-sans-extension file)))
    (condition-case-unless-debug err
        (load module noerror)
      (error
       (setq init-module-has-critical-errors-p t)
       (message
        (format "[Error in module %s] %s"
                module
                (error-message-string err))
        )))))

(cl-defun init-module--load-files (directory regexp &optional noerror)
  "[internal] Load init modules in DIRECTORY matching the REGEXP specified."
  (cl-loop for file in (init-module--list-files directory regexp)
           do (init-module--load-file file (if debug-on-error nil noerror))))

(cl-defun init-module--lazy-load-files (directory regexp)
  "[internal] Lazy load init modules in DIRECTORY matching the REGEXP specified."
  (cl-loop for file in (init-module--list-files directory regexp)
           for feature = (save-match-data
                           (when (string-match regexp file)
                             (match-string 1 file)))
           do (eval-after-load feature
                `(init-module--load-file ',file))))

(cl-defun init-module--require-file (file &optional (noerror t))
  "[internal] Require elisp file."
  (let ((feature (intern (file-name-base file))))
    (condition-case-unless-debug err
        (when (require feature nil noerror)
          (message (format "Requiring %s...done" feature)))
      (error
       (setq init-module-has-critical-errors-p t)
       (message
        (format "[Error in module %s] %s"
                feature
                (error-message-string err))
        )))))

(cl-defun init-module--require-files (directory regexp &optional (noerror t))
  "[internal] Require init modules in DIRECTORY matching the REGEXP specified."
  (cl-loop for file in (init-module--list-files directory regexp)
           do (init-module--require-file file (if debug-on-error nil noerror))))

(defun init-module--save-initerror-file ()
  "[internal] Save error message on loading init modules."
  (if init-module-has-critical-errors-p
      (with-current-buffer "*Messages*"
        (write-file init-module-initerror-file))))

(defun init-module--core-initialize ()
  "[internal] Initialize Emacs init files in `init-module-core-path'."
  (add-to-list 'load-path init-module-core-path)
  (init-module--require-files       init-module-core-path init-module-pre-init-regexp nil)

  (unless init-module-safe-mode-p
    (if (null window-system)
        (init-module--require-files init-module-core-path init-module-cui-init-regexp)
      (init-module--require-files   init-module-core-path init-module-gui-init-regexp))

    (init-module--require-files     init-module-core-path init-module-opt-init-regexp)
    (init-module--require-files     init-module-core-path init-module-post-init-regexp)))

(defun init-module--builtins-config-initialize ()
  "[internal] Initialize Emacs init files in `init-module-builtins-config-path'."
  (add-to-list 'load-path init-module-builtins-config-path)
  (init-module--load-files          init-module-builtins-config-path init-module-pre-init-regexp nil)

  (unless init-module-safe-mode-p
    (if (null window-system)
        (init-module--load-files    init-module-builtins-config-path init-module-cui-init-regexp)
      (init-module--load-files      init-module-builtins-config-path init-module-gui-init-regexp))

    (init-module--load-files        init-module-builtins-config-path init-module-opt-init-regexp)
    (init-module--lazy-load-files   init-module-builtins-config-path init-module-lazy-init-regexp)
    (init-module--load-files        init-module-builtins-config-path init-module-post-init-regexp)))

(defun init-module--local-config-initialize ()
  "[internal] Initialize Emacs init files in `init-module-local-config-path'."
  (add-to-list 'load-path init-module-local-config-path)
  (init-module--load-files          init-module-local-config-path init-module-pre-init-regexp)

  (unless init-module-safe-mode-p
    (if (null window-system)
        (init-module--load-files    init-module-local-config-path init-module-cui-init-regexp)
      (init-module--load-files      init-module-local-config-path init-module-gui-init-regexp))

    (init-module--load-files        init-module-local-config-path init-module-opt-init-regexp)
    (init-module--lazy-load-files   init-module-local-config-path init-module-lazy-init-regexp)
    (init-module--load-files        init-module-local-config-path init-module-post-init-regexp)))

;;;; Command
(defun init-module-initialize ()
  "Initialize Emacs init files."
  (interactive)
  (init-module--core-initialize)
  (init-module--builtins-config-initialize)
  (init-module--local-config-initialize))

;;;; Bootstrap
(add-hook 'emacs-startup-hook #'init-module--save-initerror-file) ; Next time, launch as safe mode.
(init-module-initialize)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init.el ends here
