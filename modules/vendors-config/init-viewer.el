;;; init-viewer.el --- el-get init file for package viewer

;; (C) 2012  Jumpei KAWAMI

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
(setq view-mode-by-default-regexp "/\\(ChangeLog\\|NEWS\\|README\\)\\|.+\\.log\\'")

(defun view-mode-by-default-setup--with-case-sensitive ()
  "Use `view-mode-by-default-regexp' as a case sensitive.

Advice function for `view-mode-by-default-setup'."
  (let ((case-fold-search nil))
    (when (and buffer-file-name view-mode-by-default-regexp
               (string-match view-mode-by-default-regexp buffer-file-name))
      (view-mode 1)
      (message "view-mode by view-mode-by-default-regexp."))))

(advice-add 'view-mode-by-default-setup :override #'view-mode-by-default-setup--with-case-sensitive)

;; Mode line color
(setq viewer-modeline-color-default (face-foreground 'mode-line-buffer-id))
(setq viewer-modeline-color-unwritable "#F92672")
(setq viewer-modeline-color-view       "#FD971F")

(defun viewer-change-modeline-color--buffer-id-switcher ()
  "Change `mode-line-buffer-id' color.

Advice function for `viewer-change-modeline-color'"
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

(advice-add 'viewer-change-modeline-color :override #'viewer-change-modeline-color--buffer-id-switcher)

(viewer-change-modeline-color-setup)

;; Integrate command for jumping to function definition
(define-overriding-view-mode-map emacs-lisp-mode ("RET" . find-function-at-point))

;;; init-viewer.el ends here
