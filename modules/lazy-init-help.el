;;; lazy-init-help.el --- Emacs init file

;; Copyright (C) 2016  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Aug. 20, 2016
;; Keywords: .emacs, help

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

;;;; Keymap
(define-key help-mode-map (kbd "j") #'next-line)
(define-key help-mode-map (kbd "k") #'previous-line)
(define-key help-mode-map (kbd "J") #'scroll-up-line)
(define-key help-mode-map (kbd "K") #'scroll-down-line)
(define-key help-mode-map (kbd "b") #'scroll-down-command)
(define-key help-mode-map (kbd "g") #'beginning-of-buffer)
(define-key help-mode-map (kbd "G") #'end-of-buffer)
(define-key help-mode-map (kbd "l") #'forward-char)
(define-key help-mode-map (kbd "h") #'backward-char)
(define-key help-mode-map (kbd "w") #'forward-word)
(define-key help-mode-map (kbd "W") #'backward-word)
(define-key help-mode-map (kbd "v") #'set-mark-command)
(define-key help-mode-map (kbd "<") #'help-go-back)
(define-key help-mode-map (kbd ">") #'help-go-forward)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; lazy-init-help.el ends here
