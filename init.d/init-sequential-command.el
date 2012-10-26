;;; init-sequential-command.el --- el-get init file for package sequential-command

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 25, 2012
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

(require 'sequential-command-config)
(sequential-command-setup-keys)

(define-sequential-command jkw:seq-home
  back-to-indentation
  beginning-of-line
  beginning-of-buffer
  seq-return)

(define-sequential-command jkw:org-seq-home
  back-to-indentation
  org-beginning-of-line
  beginning-of-buffer
  seq-return)

(global-set-key (kbd "C-a") 'jkw:seq-home)
(define-key org-mode-map (kbd "C-a") 'jkw:org-seq-home)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; init-sequential-command.el ends here
