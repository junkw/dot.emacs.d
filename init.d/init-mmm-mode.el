;;; init-mmm-mode.el --- el-get init file for package mmm-mode

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Dec. 26, 2012
;; Keywords: .emacs, php, html, css, javascript

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

(require 'mmm-vars)

(setq mmm-global-mode 'maybe)

;; Javascript in HTML
(mmm-add-group
 'embedded-js
 '((js-code
    :submode js2-mode
    :face    mmm-code-submode-face
    :delimiter-mode nil
    :front   "<script[^>]*>[ \t]*\n?"
    :back    "[ \t]*</script>"
    :insert  ((?j js-tag nil @ "<script type=\"text/javascript\">\n"
                  @ "" _ "" @ "\n</script>" @)))
   (js-inline
    :submode js2-mode
    :face    mmm-code-submode-face
    :delimiter-mode nil
    :front   "\\bon\\w+=\""
    :back    "\"")))
(mmm-add-mode-ext-class 'nxml-mode "\\.[sx]?html?\\'" 'embedded-js)

;; CSS in HTML
(mmm-add-group
 'embedded-css
 '((css-code
    :submode css-mode
    :face    mmm-declaration-submode-face
    :delimiter-mode nil
    :front   "<style[^>]*>[ \t]*\n?"
    :back    "[ \t]*</style>"
    :insert  ((?c css-tag nil @ "<style type=\"text/css\">\n"
                  @ "" _ "" @ "\n</style>" @)))
   (css-inline
    :submode css-mode
    :face    mmm-declaration-submode-face
    :delimiter-mode nil
    :front   "\\bstyle=\\s-*\""
    :back    "\"")))
(mmm-add-mode-ext-class 'nxml-mode "\\.[sx]?html?\\'" 'embedded-css)

;; PHP View file
(mmm-add-group
 'php-view
 '((php-code
    :submode php-mode
    :face    mmm-code-submode-face
    :front   "<\\?\\(php\\)?"
    :back    "\\?>"
    :insert  ((?p php-section nil @ "<?php" @ " " _ " " @ "?>" @)
              (?b php-block nil @ "<?php" @ "\n" _ "\n" @ "?>" @)))
   (php-output
    :submode php-mode
    :face    mmm-output-submode-face
    :front   "<\\?php *echo "
    :back    "\\?>"
    :include-front t
    :front-offset  5
    :insert  ((?e php-echo nil @ "<?php" @ " echo " _ " " @ "?>" @)))))
(mmm-add-mode-ext-class 'nxml-mode "\\.html\\.php\\'" 'php-view)
(add-to-list 'auto-mode-alist '("\\.html\\.php\\'" . nxml-mode))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-mmm-mode.el ends here
