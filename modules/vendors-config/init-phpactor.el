;;; init-phpactor.el --- el-get init file for package phpactor

;; (C) 2021  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jan. 18, 2021
;; Keywords: .emacs, completion, php

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

(defun jkw:phpactor-init ()
  "My config for phpactor."
  (make-local-variable 'eldoc-documentation-function)
  (setq eldoc-documentation-function 'phpactor-hover)
  (add-to-list 'exec-path (concat user-emacs-directory "vendor/phpactor/vendor/bin")))

(add-hook 'php-mode-hook #'jkw:phpactor-init)

;;;; Keymap

(when (require 'smart-jump nil t)
  (phpactor-smart-jump-register))

;;; init-phpactor.el ends here
