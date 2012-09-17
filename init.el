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

(eval-when-compile (require 'cl))

(add-to-list 'load-path user-emacs-directory)

(defun jkw:init-module-list-files (regexp)
  "Show init modules containing a match for REGEXP in `~/.emacs.d/'.
If a elisp file has a byte-compiled file, show the byte-compiled file only."
  (loop for el in (directory-files user-emacs-directory t)
        when (and (string-match regexp (file-name-nondirectory el))
                  (or (string-match "elc$" el)
                      (and (string-match "el$" el)
                           (not (locate-library (concat el "c"))))))
        collect (file-name-nondirectory el)))

(defun jkw:init-module-load-files (prefix)
  "Load init modules with PREFIX"
  (loop for mod in (jkw:init-module-list-files prefix)
        do (load (file-name-sans-extension mod))))

(defun jkw:init-module-initialize ()
  "Initialize Emacs init files"
  (jkw:init-module-load-files "^pre-init-")
  (jkw:init-module-load-files "^opt-init-")
  (jkw:init-module-load-files "^post-init-"))

(jkw:init-module-initialize)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
