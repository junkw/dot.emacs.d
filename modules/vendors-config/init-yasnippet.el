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

(setopt yas-snippet-dirs `(,(concat user-emacs-directory "etc/snippets")))

(add-hook 'emacs-startup-hook #'yas-reload-all)
(add-hooks '(prog-mode org-mode) #'yas-minor-mode)

;;;; Keymap

(keymap-set yas-minor-mode-map "TAB" nil)
(keymap-set yas-keymap "TAB" nil)
(keymap-set yas-keymap "S-TAB" nil)

(keymap-set yas-minor-mode-map "C-+" #'yas-expand)
(keymap-set yas-keymap "M-{" #'yas-next-field-or-maybe-expand)
(keymap-set yas-keymap "M-}" #'yas-prev-field)

;;; init-yasnippet.el ends here
