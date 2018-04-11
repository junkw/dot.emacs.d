;;; init-php-mode.el --- el-get init file for package php-mode

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Dec. 18, 2012
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

(add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))

(with-eval-after-load 'php-mode
  (add-to-list 'which-func-modes 'php-mode)
  (setq php-manual-url 'ja)
  (setq php-mode-coding-style 'psr2)
  (setq php-lineup-cascaded-calls t)
  (setq php-template-compatibility nil)

;;;; Keymap
  (define-key php-mode-map (kbd "C-c C--") #'php-current-class)
  (define-key php-mode-map (kbd "C-c C-=") #'php-current-namespace))

;;;; Hooks
(defun jkw:php-mode-init ()
  "My config for PHP mode."
  (subword-mode +1)
  (setq c-basic-offset 4)

  (when (eq (buffer-size) 0)
    (insert "<?php\n\n")))

(add-hook 'php-mode-hook #'jkw:php-mode-init)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-php-mode.el ends here
