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

;;; Change Log:
;;

;;; Code:

(require 'cl-lib)

(setq custom-file (concat user-emacs-directory "etc/custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;;;; Customization
(defgroup init-module nil
  "Init module."
  :group  'initialization
  :prefix "init-module-")

(defcustom init-module-init-directory (concat user-emacs-directory "init.d/")
  "`init-module-init-directory' contains init modules."
  :type  'string
  :group 'init-module)

(add-to-list 'load-path init-module-init-directory)

(defcustom init-module-load-only-pre-init-files nil
  "If this variable is non-nil, startup with minimum Emacs config."
  :type  'boolean
  :group 'init-module)

(defcustom init-module-opt-init-file-regexp "^opt-init-"
  "Regexp matching opt-init filename."
  :type  'string
  :group 'init-module)

;;;; Internal functions
(defun init-module-list-files (regexp)
  "Show init modules containing a match for REGEXP in `init-module-init-directory'.

If a elisp file has a byte-compiled file, show the byte-compiled file only."
  (cl-loop for el in (directory-files init-module-init-directory t)
           when (and (string-match regexp (file-name-nondirectory el))
                     (or (string-match "elc$" el)
                         (and (string-match "el$" el)
                              (not (locate-library (concat el "c"))))))
           collect (file-name-nondirectory el)))

(defun init-module-load-files (regexp)
  "Load init modules matching the REGEXP specified."
  (cl-loop for mod in (init-module-list-files regexp)
           do (condition-case err
                  (load (file-name-sans-extension mod))
                (error
                 (message (format "Error in init-module %s. %s"
                                  (file-name-sans-extension mod)
                                  (error-message-string err)))))))

;;;; Command
(defun init-module-initialize ()
  "Initialize Emacs init files."
  (interactive)
  ;; Minimum config
  (init-module-load-files "^pre-init-")

  (unless init-module-load-only-pre-init-files
    ;; Environment-dependent config
    (if (null window-system)
        (init-module-load-files "^cui-init-")
      (init-module-load-files "^gui-init-"))
    ;; Advanced config
    (init-module-load-files init-module-opt-init-file-regexp)
    (init-module-load-files "^post-init-")))

(init-module-initialize)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init.el ends here
