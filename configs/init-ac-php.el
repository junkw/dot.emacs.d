;;; init-ac-php.el --- el-get init file for package ac-php

;; Copyright (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 31, 2015
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

;;;; Face
(set-face-attribute 'ac-php-candidate-face nil :inherit 'ac-candidate-face)
(set-face-attribute 'ac-php-selection-face nil :inherit 'ac-selection-face)

;;;; Keymap
(with-eval-after-load 'php-mode
  (define-key php-mode-map (kbd "C-,")   #'ac-php-find-symbol-at-point)
  (define-key php-mode-map (kbd "C-c <") #'ac-php-location-stack-back))

;;;; Hooks
(defun jkw:ac-php-hooks ()
  "ac-php config for PHP mode."
  (auto-complete-mode +1)
  (add-to-list 'ac-sources 'ac-source-php)
  (yas-minor-mode-on))

(add-hook 'php-mode-hook #'jkw:ac-php-hooks)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-ac-php.el ends here
