;;; init-lsp-bridge.el --- el-get init file for package lsp-bridge

;; (C) 2024  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: May. 4, 2024
;; Keywords: .emacs, LSP, completion

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

;; LSP server

;; Mode

(defun jkw:lsp-bridge--php-mode-init ()
  "My lsp-bridge config for PHP mode."
  (corfu-mode -1)
  (lsp-bridge-mode +1))

(with-eval-after-load 'php-mode
  (add-hook 'php-mode-hook #'jkw:lsp-bridge--php-mode-init))

;;; init-lsp-bridge.el ends here
