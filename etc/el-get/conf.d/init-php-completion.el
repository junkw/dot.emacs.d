;;; init-php-completion.el --- el-get init file for package php-completion

;; Copyright (C) 2014  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 31, 2014
;; Keywords: .emacs, php

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

;;;; Hooks
(defun jkw:php-completion-mode-hooks ()
  "My php-completion-mode config for PHP mode."
  (php-completion-mode 1)
  (when (require 'auto-complete nil t)
    (make-variable-buffer-local 'ac-sources)
    (add-to-list 'ac-sources 'ac-source-php-completion-patial)
    (auto-complete-mode 1)))

(add-hook 'php-mode-hook 'jkw:php-completion-mode-hooks)

;;;; Keymap
(define-key php-mode-map (kbd "M-TAB") 'phpcmp-complete)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-php-completion.el ends here