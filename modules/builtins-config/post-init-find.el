;;; post-init-find.el --- Emacs init file

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 20, 2015
;; Keywords: .emacs, isearch

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

;; http://dev.ariel-networks.com/articles/emacs/part5/
(defun isearch-mode--with-region (orig-fun forward &optional regexp op-fun recursive-edit word)
  "Start isearch with mark-set keywords.

Advice function for `w/isearch-mode'
(ORIG-FUN needs args FORWARD, REGEXP, OP-FUN, RECURSIVE-EDIT and WORD)."
  (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
      (progn
        (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
        (deactivate-mark)
        (funcall orig-fun forward regexp op-fun recursive-edit word)
        (if (not forward)
            (isearch-repeat-backward)
          (goto-char (mark))
          (isearch-repeat-forward)))
    (funcall orig-fun forward regexp op-fun recursive-edit word)))

(advice-add 'isearch-mode :around #'isearch-mode--with-region)


;;;; Keymap

(keymap-set isearch-mode-map "M-y" #'isearch-yank-pop)

;;; post-init-find.el ends here
