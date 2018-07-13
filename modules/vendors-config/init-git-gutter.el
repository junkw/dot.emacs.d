;;; init-git-gutter.el --- el-get init file for package git-gutter

;; (C) 2018  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 6, 2018
;; Keywords: .emacs, git

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

;;;; Hooks
(add-hook 'prog-mode-hook #'git-gutter-mode)

;;;; Keymap
(global-set-key (kbd "M-g n")     #'git-gutter:next-hunk)
(global-set-key (kbd "M-g p")     #'git-gutter:previous-hunk)
(global-set-key (kbd "M-g v =")   #'git-gutter:popup-hunk)
(global-set-key (kbd "M-g v s")   #'git-gutter:stage-hunk)
(global-set-key (kbd "M-g v r")   #'git-gutter:revert-hunk)
(global-set-key (kbd "M-g v SPC") #'git-gutter:mark-hunk)

(with-eval-after-load 'smartrep
  (smartrep-define-key prog-mode-map "M-g"
    '(("n" . #'git-gutter:next-hunk)
      ("p" . #'git-gutter:previous-hunk))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-git-gutter.el ends here
