;;; init-multiple-cursors.el --- el-get init file for package multiple-cursors

;; (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 4, 2013
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

(require 'smartrep)

(setq mc/list-file (concat user-emacs-directory "var/cache/multiple-cursors-list.el"))

;;;; Keymap
(define-prefix-command 'jkw:multiple-cursors-command-prefix-key)
(global-set-key (kbd "C-t") 'jkw:multiple-cursors-command-prefix-key)

(let ((prefix jkw:multiple-cursors-command-prefix-key))
  (define-key prefix (kbd "e") #'mc/edit-lines)
  (define-key prefix (kbd "r") #'mc/mark-all-in-region)
  (define-key prefix (kbd "t") #'mc/mark-all-like-this)
  (define-key prefix (kbd "d") #'mc/mark-all-dwim)
  (define-key prefix (kbd "D") #'mc/mark-all-like-this-dwim)
  (define-key prefix (kbd "i") #'mc/insert-numbers)
  (define-key prefix (kbd "s") #'mc/sort-regions)
  (define-key prefix (kbd "S") #'mc/reverse-regions)
  prefix)

(smartrep-define-key global-map "C-t"
  '(("n" . #'mc/mark-next-like-this)
    ("p" . #'mc/mark-previous-like-this)
    ("N" . #'mc/skip-to-next-like-this)
    ("P" . #'mc/skip-to-previous-like-this)
    ("m" . #'mc/mark-more-like-this-extended)
    ("u" . #'mc/unmark-next-like-this)
    ("U" . #'mc/unmark-previous-like-this)))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-multiple-cursors.el ends here
