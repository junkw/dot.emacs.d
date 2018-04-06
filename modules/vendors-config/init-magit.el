;;; init-magit.el --- el-get init file for package magit

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jan. 21, 2013
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

(defvar with-editor-file-name-history-exclude '())
(setq magit-repository-directories '(("~/Code/" . 3)
                                     ("~/etc/conf.d/" . 1)))

;;;; Alias
(defalias 'magit 'magit-status)

;;;; Keymap
(define-prefix-command 'jkw:magit-command-prefix-key)
(global-set-key (kbd "C-x g") 'jkw:magit-command-prefix-key)

(define-key jkw:magit-command-prefix-key (kbd "g") #'magit-status)
(define-key jkw:magit-command-prefix-key (kbd "G") #'magit-list-repositories)
(define-key jkw:magit-command-prefix-key (kbd "f") #'magit-find-file)
(define-key jkw:magit-command-prefix-key (kbd "F") #'magit-find-file-other-window)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-magit.el ends here
