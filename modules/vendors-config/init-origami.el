;;; init-origami.el --- el-get init file for package origami

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Mar. 14, 2015
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

(require 'pre-init-hook-utils)

(add-to-list 'origami-parser-alist '(php-mode . origami-c-style-parser))
(defvar origami-enabled-modes (mapcar #'car origami-parser-alist))

;;;; Hooks
(add-hooks origami-enabled-modes #'origami-mode)

(defun origami-close-all-nodes-with-view-mode ()
  "[internal] If `w/view-mode' is enabled, close every fold in the buffer."
  (when (memq major-mode origami-enabled-modes)
    (call-interactively
     (if view-mode
         #'origami-close-all-nodes
       #'origami-reset))))

(add-hook 'view-mode-hook #'origami-close-all-nodes-with-view-mode)

;;;; Keymap
(global-set-key (kbd "M-i") #'origami-recursively-toggle-node)

(with-eval-after-load 'view-mode
  (define-key view-mode-map (kbd "C-i") #'origami-recursively-toggle-node)
  (define-key view-mode-map (kbd "t")   #'origami-toggle-all-nodes)
  (define-key view-mode-map (kbd "[")   #'origami-previous-fold)
  (define-key view-mode-map (kbd "]")   #'origami-next-fold))

;;; init-origami.el ends here
