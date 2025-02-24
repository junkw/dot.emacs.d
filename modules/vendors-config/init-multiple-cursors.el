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

(setopt mc/list-file (concat user-emacs-directory "var/cache/multiple-cursors-list.el"))

;;;; Keymap
(define-prefix-command 'jkw:multiple-cursors-command-prefix-key)
(keymap-global-set "C-t" 'jkw:multiple-cursors-command-prefix-key)

(let ((prefix jkw:multiple-cursors-command-prefix-key))
  (keymap-set prefix "e" #'mc/edit-lines)
  (keymap-set prefix "r" #'mc/mark-all-in-region)
  (keymap-set prefix "t" #'mc/mark-all-like-this)
  (keymap-set prefix "d" #'mc/mark-all-dwim)
  (keymap-set prefix "D" #'mc/mark-all-like-this-dwim)
  (keymap-set prefix "i" #'mc/insert-numbers)
  (keymap-set prefix "s" #'mc/sort-regions)
  (keymap-set prefix "S" #'mc/reverse-regions)
  prefix)

(with-eval-after-load 'smartrep
  (smartrep-define-key global-map "C-t"
    '(("n" . #'mc/mark-next-like-this)
      ("p" . #'mc/mark-previous-like-this)
      ("N" . #'mc/skip-to-next-like-this)
      ("P" . #'mc/skip-to-previous-like-this)
      ("m" . #'mc/mark-more-like-this-extended)
      ("u" . #'mc/unmark-next-like-this)
      ("U" . #'mc/unmark-previous-like-this))))

;;; init-multiple-cursors.el ends here
