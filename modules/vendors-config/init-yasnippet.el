;;; init-yasnippet.el --- el-get init file for package yasnippet

;; (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 28, 2013
;; Keywords: .emacs, snippet

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

;;;; Init

(setq yas-snippet-dirs `(,(concat user-emacs-directory "etc/snippets")))

(add-hook 'emacs-startup-hook #'yas-reload-all)
(add-hooks '(prog-mode org-mode) #'yas-minor-mode)

;;;; Keymap

(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-keymap (kbd "TAB") nil)
(define-key yas-keymap (kbd "S-TAB") nil)

(define-key yas-minor-mode-map (kbd "C-+") #'yas-expand)
(define-key yas-keymap (kbd "M-{") #'yas-next-field-or-maybe-expand)
(define-key yas-keymap (kbd "M-}") #'yas-prev-field)

;;; init-yasnippet.el ends here
