;;; init-ac-php.el --- el-get init file for package ac-php

;; (C) 2015  Jumpei KAWAMI

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

(with-eval-after-load 'auto-complete
  (require 'ac-php))

(with-eval-after-load 'company
  (require 'company-php))

(setopt ac-php-tags-path (substitute-in-file-name "${XDG_DATA_HOME}/ac-php"))

;;;; Hooks
(defun jkw:company-backends-for-ac-php-init ()
  "[internal] Set `company-backends' for php-mode."
  (company-mode +1)
  (add-to-list (make-local-variable 'company-backends) 'company-ac-php-backend)
  (ac-php-core-eldoc-setup))

(add-hook 'php-mode-hook #'jkw:company-backends-for-ac-php-init)

;;;; Keymap
(keymap-set php-mode-map "C-,"   #'ac-php-find-symbol-at-point)
(keymap-set php-mode-map "C-c <" #'ac-php-location-stack-back)

;;; init-ac-php.el ends here
