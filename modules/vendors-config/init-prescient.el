;;; init-prescient.el --- el-get init file for package prescient  -*- lexical-binding: t; -*-

;; (C) 2024  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Apr. 23, 2024
;; Keywords: .emacs, completion

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

(setopt prescient-aggressive-file-save t)
(setopt prescient-save-file (concat user-emacs-directory "var/cache/prescient-save.el"))

(with-eval-after-load 'orderless
  (setopt corfu-prescient-enable-filtering nil))

(prescient-persist-mode +1)
(corfu-prescient-mode +1)

;;; init-prescient.el ends here
