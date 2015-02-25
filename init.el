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

(defvar init-module-modules-directory (concat user-emacs-directory "modules/")
  "`init-module-modules-directory' contains init modules.")

(defvar init-module-initerror-file (concat user-emacs-directory "var/initerror")
  "Log file on loading init modules.")

(defvar init-module-safe-mode-p (file-exists-p init-module-initerror-file)
  "Return t as safe mode if initerror file exists.")

(defvar init-module-errors nil)

;;;; Internal functions
(defun init-module--list-files (regexp)
  "[internal] Show init modules containing a match for REGEXP in `init-module-modules-directory'.

If a elisp file has a byte-compiled file, show the byte-compiled file only."
  (cl-loop for el in (directory-files init-module-modules-directory t)
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

(cl-defun init-module--load-files (regexp &optional (initerror nil))
  "[internal] Load init modules matching the REGEXP specified."
  (cl-loop for file in (init-module--list-files regexp)
           do (init-module--load-file file initerror)))

(cl-defun init-module--lazy-load-files (regexp)
  "[internal] Lazy load init modules matching the REGEXP specified."
  (cl-loop for file in (init-module--list-files regexp)
           for feature = (save-match-data
                           (when (string-match regexp file)
                             (match-string 1 file)))
           do (eval-after-load feature
                `(init-module--load-file ',file))))

(defun init-module--save-initerror-file ()
  "[internal] Save error message on loading init modules."
  (if init-module-errors
      (with-current-buffer "*Messages*"
        (write-file init-module-initerror-file))))

(add-hook 'emacs-startup-hook #'init-module--save-initerror-file) ; Next time, launch as safe mode.

;;;; Command
(defun init-module-initialize ()
  "Initialize Emacs init files."
  (interactive)
  ;; Minimum config
  (init-module--load-files init-module-pre-init-regexp)

  (unless init-module-safe-mode-p
    ;; Environment-dependent config
    (if (null window-system)
        (init-module--load-files init-module-cui-init-regexp t)
      (init-module--load-files init-module-gui-init-regexp t))

    ;; Advanced config
    (init-module--load-files init-module-opt-init-regexp t)
    (require 'site-loaddefs nil t)
    (init-module--lazy-load-files init-module-lazy-init-regexp)
    (init-module--load-files init-module-post-init-regexp t)))

;;;; Bootstrap
(add-to-list 'load-path init-module-modules-directory)
(setq custom-file (concat user-emacs-directory "modules/pre-init--custom.el"))

(init-module-initialize)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init.el ends here
