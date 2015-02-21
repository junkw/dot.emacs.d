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

;;; Change Log:
;;

;;; Code:

(require 'cl-lib)

;;;; Internal functions
(defvar init-module-modules-directory (concat user-emacs-directory "modules/")
  "`init-module-modules-directory' contains init modules.")

(defvar init-module-initerror-file (concat user-emacs-directory "var/initerror")
  "Log file on loading init modules.")

(defvar init-module-safe-mode-p (file-exists-p init-module-initerror-file)
  "Return t as safe mode if initerror file exists.")

(defvar init-module-errors nil)

(defun init-module--list-files (regexp)
  "Show init modules containing a match for REGEXP in `init-module-modules-directory'.

If a elisp file has a byte-compiled file, show the byte-compiled file only."
  (cl-loop for el in (directory-files init-module-modules-directory t)
           when (and (string-match regexp (file-name-nondirectory el))
                     (or (string-match "elc\\'" el)
                         (and (string-match "el\\'" el)
                              (not (locate-library (concat el "c"))))))
           collect (file-name-nondirectory el)))

(cl-defun init-module--load-files (regexp &optional (initerror nil))
  "Load init modules matching the REGEXP specified."
  (cl-loop for mod in (init-module--list-files regexp)
           do (condition-case err
                  (load (file-name-sans-extension mod))
                (error
                 (message (format "Error in init-module %s. %s"
                                  (file-name-sans-extension mod)
                                  (error-message-string err))))
                (if initerror (setq init-module-errors t)))))

(defun init-module--save-initerror-file ()
  "Save error message on loading init modules."
  (with-current-buffer "*Messages*"
        (write-file init-module-initerror-file)))

;;;; Command
(defun init-module-initialize ()
  "Initialize Emacs init files."
  (interactive)
  ;; Minimum config
  (init-module--load-files "\\`pre-init-")

  (unless init-module-safe-mode-p
    ;; Environment-dependent config
    (if (null window-system)
        (init-module--load-files "\\`cui-init-" t)
      (init-module--load-files "\\`gui-init-" t))

    ;; Advanced config
    (init-module--load-files "\\`opt-init-" t)
    (init-module--load-files "\\`post-init-" t)))

;;;; Bootstrap
(add-to-list 'load-path init-module-modules-directory)
(setq custom-file (concat user-emacs-directory "modules/pre-init--custom.el"))

(init-module-initialize)

(if init-module-errors                  ; Next time, launch as safe mode.
    (add-hook 'after-init-hook #'init-module--save-initerror-file))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init.el ends here
