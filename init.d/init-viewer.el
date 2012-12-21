;;; init-viewer.el --- el-get init file for package viewer

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 25, 2012
;; Keywords: .emacs, view mode

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

(require 'pre-init-core)

(eval-after-load-q "view"
  ;; Keep read-only
  (viewer-stay-in-setup)

  ;; Open log and README files as read only
  (setq view-mode-by-default-regexp "\\(^ChangeLog\\|README\\|.log$\\)")

  ;; Mode line color
  (setq viewer-modeline-color-unwritable "DarkOrange1")
  (setq viewer-modeline-color-view "OrangeRed1")
  (viewer-change-modeline-color-setup)

  ;; Integrate command for jumping to function definition
  (define-overriding-view-mode-map emacs-lisp-mode ("RET" . find-function-at-point))
  )

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved cl-functions mapcar constants)
;; End:

;;; init-viewer.el ends here
