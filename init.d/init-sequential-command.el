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

(seq-define-cursor-command back-to-indentation)
(seq-define-cursor-command org-beginning-of-line)
(seq-define-cursor-command org-end-of-line)

(define-sequential-command seq-beginnings
  seq-back-to-indentation
  seq-beginning-of-line
  seq-beginning-of-buffer
  seq-return)

(define-sequential-command org-seq-beginnings
  seq-back-to-indentation
  seq-org-beginning-of-line
  seq-beginning-of-buffer
  seq-return)

(define-sequential-command org-seq-ends
  seq-org-end-of-line
  seq-end-of-buffer
  seq-return)

(defadvice sequential-command-setup-keys (after seq-setup-keys-remap activate)
  "Replace original seq-home and org-seq-* with my commands."
  (global-set-key (kbd "C-a") 'seq-beginnings)
  (define-key org-mode-map (kbd "C-a") 'org-seq-beginnings)
  (define-key org-mode-map (kbd "C-e") 'org-seq-ends))

;; (ad-disable-advice 'sequential-command-setup-keys 'after 'seq-setup-keys-remap)
;; (ad-activate 'sequential-command-setup-keys)
(sequential-command-setup-keys)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved cl-functions mapcar constants)
;; End:

;;; init-sequential-command.el ends here
