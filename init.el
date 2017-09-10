;;; init.el --- Emacs init file

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

(require 'cl-lib)
(require 'site-loaddefs nil t)

;;;; Variables
(defvar init-module-pre-init-regexp "\\`pre-init-"
  "Regular expression of init module names for pre loading.")

(defvar init-module-cui-init-regexp "\\`cui-init-"
  "Regular expression of no-window Emacs init module names.")

(defvar init-module-gui-init-regexp "\\`gui-init-"
  "Regular expression of window Emacs init module names.")

(defvar init-module-opt-init-regexp "\\`opt-init-"
  "Regular expression of init module names for optional loading.")

(defvar init-module-lazy-init-regexp "\\`lazy-init-\\(.+\\)\\.elc?\\'"
  "Regular expression of init module names for lazy loading.")

(defvar init-module-post-init-regexp "\\`post-init-"
  "Regular expression of init module names for post loading.")

(defvar init-module-modules-directory
  (file-name-as-directory (concat user-emacs-directory "modules"))
  "`init-module-modules-directory' contains init modules.")

(defvar init-module-builtins-config-directory
  (file-name-as-directory (concat init-module-modules-directory "builtins-config"))
  "`init-module-builtins-config-directory' contains built-in packages init files.")

(defvar init-module-core-directory
  (file-name-as-directory (concat init-module-modules-directory "core"))
  "`init-module-core-directory' contains library for initializetion.")

(defvar init-module-local-config-directory
  (file-name-as-directory (concat init-module-modules-directory "local-config"))
  "`init-module-local-config-directory' contains local init files.")

(defvar init-module-vendors-config-directory
  (file-name-as-directory (concat init-module-modules-directory "vendors-config"))
  "`init-module-vendors-config-directory' contains el-get init files.")

(defvar init-module-initerror-file (concat user-emacs-directory "var/initerror")
  "Log file on loading init modules.")

(defvar init-module-safe-mode-p (file-exists-p init-module-initerror-file)
  "Return t as safe mode if initerror file exists.")

(defvar init-module-errors nil)
(setq package--init-file-ensured t)
(setq package-enable-at-startup nil)

;;;; Internal functions
(defun init-module--list-files (directory regexp)
  "[internal] Show init modules containing a match for REGEXP in DIRECTORY of `init-module-modules-directory'.

If a elisp file has a byte-compiled file, show the byte-compiled file only."
  (cl-loop for el in (directory-files directory t)
           when (and (string-match regexp (file-name-nondirectory el))
                     (or (string-match "elc\\'" el)
                         (and (string-match "el\\'" el)
                              (not (locate-library (concat el "c"))))))
           collect (file-name-nondirectory el)))

(cl-defun init-module--load-file (file &optional (initerror nil))
  "[internal] Load elisp file."
  (let ((module (file-name-sans-extension file)))
    (condition-case err
        (load module)
      (error
       (message (format "[Error in module %s] %s" module (error-message-string err)))
       (if initerror (setq init-module-errors t))))))

(cl-defun init-module--load-files (directory regexp &optional (initerror nil))
  "[internal] Load init modules in DIRECTORY matching the REGEXP specified."
  (cl-loop for file in (init-module--list-files directory regexp)
           do (init-module--load-file file initerror)))

(cl-defun init-module--lazy-load-files (directory regexp)
  "[internal] Lazy load init modules in DIRECTORY matching the REGEXP specified."
  (cl-loop for file in (init-module--list-files directory regexp)
           for feature = (save-match-data
                           (when (string-match regexp file)
                             (match-string 1 file)))
           do (eval-after-load feature
                `(init-module--load-file ',file))))

(cl-defun init-module--require-file (file &optional (initerror nil))
  "[internal] Require elisp file."
  (let ((feature (intern (file-name-base file))))
    (condition-case err
        (when (require feature)
          (message (format "Requiring %s...done" feature)))
      (error
       (message (format "[Error in module %s] %s" feature (error-message-string err)))
       (if initerror (setq init-feature-errors t))))))

(cl-defun init-module--require-files (directory regexp &optional (initerror nil))
  "[internal] Require init modules in DIRECTORY matching the REGEXP specified."
  (cl-loop for file in (init-module--list-files directory regexp)
           do (init-module--require-file file initerror)))

(defun init-module--save-initerror-file ()
  "[internal] Save error message on loading init modules."
  (if init-module-errors
      (with-current-buffer "*Messages*"
        (write-file init-module-initerror-file))))

(defun init-module--builtins-config-initialize ()
  "[internal] Initialize Emacs init files in `init-module-builtins-config-directory'."
  (add-to-list 'load-path init-module-builtins-config-directory)
  (init-module--load-files init-module-builtins-config-directory init-module-pre-init-regexp)

  (unless init-module-safe-mode-p
    (if (null window-system)
        (init-module--load-files init-module-builtins-config-directory init-module-cui-init-regexp t)
      (init-module--load-files init-module-builtins-config-directory init-module-gui-init-regexp t))

    (init-module--load-files init-module-builtins-config-directory init-module-opt-init-regexp t)
    (init-module--lazy-load-files init-module-builtins-config-directory init-module-lazy-init-regexp)
    (init-module--load-files init-module-builtins-config-directory init-module-post-init-regexp t)))

(defun init-module--local-config-initialize ()
  "[internal] Initialize Emacs init files in `init-module-local-config-directory'."
  (add-to-list 'load-path init-module-local-config-directory)
  (init-module--load-files init-module-local-config-directory init-module-pre-init-regexp)

  (unless init-module-safe-mode-p
    (if (null window-system)
        (init-module--load-files init-module-local-config-directory init-module-cui-init-regexp t)
      (init-module--load-files init-module-local-config-directory init-module-gui-init-regexp t))

    (init-module--load-files init-module-local-config-directory init-module-opt-init-regexp t)
    (init-module--lazy-load-files init-module-local-config-directory init-module-lazy-init-regexp)
    (init-module--load-files init-module-local-config-directory init-module-post-init-regexp t)))

(defun init-module--core-initialize ()
  "[internal] Initialize Emacs init files in `init-module-core-directory'."
  (add-to-list 'load-path init-module-core-directory)
  (init-module--require-files init-module-core-directory init-module-pre-init-regexp)

  (unless init-module-safe-mode-p
    (if (null window-system)
        (init-module--require-files init-module-core-directory init-module-cui-init-regexp t)
      (init-module--require-files init-module-core-directory init-module-gui-init-regexp t))

    (init-module--require-files init-module-core-directory init-module-opt-init-regexp t)
    (init-module--require-files init-module-core-directory init-module-post-init-regexp t)))

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
