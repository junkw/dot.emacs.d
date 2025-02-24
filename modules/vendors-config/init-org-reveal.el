;;; init-org-reveal.el --- el-get init file for package org-reveal

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Apr. 22, 2015
;; Keywords: .emacs, org-mode, presentation

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

(add-to-list 'org-export-backends 'reveal)
(setopt org-reveal-root (concat user-emacs-directory "lib/reveal.js"))

;; Workaround for changing `org-structure-template-alist' format in Org 9.2
(setopt org-reveal-note-key-char nil)
(add-to-list 'org-structure-template-alist '("n" . "note"))

;;; init-org-reveal.el ends here
