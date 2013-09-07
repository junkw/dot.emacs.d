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

(require 'viewer)

;; Keep read-only
(viewer-stay-in-setup)

;; Open log and README files as read only
(setq view-mode-by-default-regexp "\\/\\(ChangeLog\\|NEWS\\|README\\)\\|\\.log\\'")

(defadvice view-mode-by-default-setup
  (around view-mode-by-default-setup-with-case-sensitive activate)
  "Use `view-mode-by-default-regexp' as a case sensitive."
  (let ((case-fold-search nil))
    ad-do-it))

;; Mode line color
(setq viewer-modeline-color-default    (face-foreground 'mode-line-buffer-id))
(setq viewer-modeline-color-unwritable "DarkOrange1")
(setq viewer-modeline-color-view       "OrangeRed1")

(defadvice viewer-change-modeline-color
  (around viewer-change-modeline-color-buffer-id activate)
  "Change `mode-line-buffer-id' color."
  (interactive)
  (when (eq (selected-window)
            (get-buffer-window (current-buffer)))
    (set-face-foreground
     'mode-line-buffer-id
     (cond ((and buffer-file-name view-mode
                 (not (file-writable-p buffer-file-name)))
            viewer-modeline-color-unwritable)
           (view-mode
            viewer-modeline-color-view)
           (t
            viewer-modeline-color-default)))
    (force-mode-line-update)))

(viewer-change-modeline-color-setup)

;; Integrate command for jumping to function definition
(define-overriding-view-mode-map emacs-lisp-mode ("RET" . find-function-at-point))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-viewer.el ends here
