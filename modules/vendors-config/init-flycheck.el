;;; init-flycheck.el --- el-get init file for package flycheck

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 10, 2013
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

(require 'smartrep)

(setq flycheck-check-syntax-automatically '(mode-enabled save))
(setq flycheck-display-errors-delay 0.5)
(setq-default flycheck-emacs-lisp-load-path 'inhert)

(add-hook 'prog-mode-hook #'flycheck-mode)

;;;; Keymap
(with-eval-after-load 'flycheck
  (smartrep-define-key flycheck-mode-map "C-c !"
    '(("n" . #'flycheck-next-error)
      ("p" . #'flycheck-previous-error))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-flycheck.el ends here
