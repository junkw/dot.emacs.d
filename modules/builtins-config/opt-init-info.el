;;; opt-init-info.el --- Emacs init file

;; Copyright (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: May. 20, 2015
;; Keywords: .emacs, info

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

(require 'pre-init-keymap-utils)
(require 'info)

;; In addition to INFOPATH
(add-to-list 'Info-additional-directory-list (concat user-emacs-directory "share/info"))

;;;; Keymap
(define-vimlike-key-sets Info-mode-map)
(define-key Info-mode-map (kbd "!")   #'Info-help)
(define-key Info-mode-map (kbd "b")   #'Info-scroll-down)
(define-key Info-mode-map (kbd "o")   #'Info-follow-nearest-node)
(define-key Info-mode-map (kbd ":")   #'Info-goto-node)
(define-key Info-mode-map (kbd "M-n") #'Info-next-reference)
(define-key Info-mode-map (kbd "M-p") #'Info-prev-reference)
(define-key Info-mode-map (kbd "B")   #'Info-history-back)
(define-key Info-mode-map (kbd "F")   #'Info-history-forward)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; opt-init-info.el ends here