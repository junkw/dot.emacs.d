;;; init-smartrep.el --- el-get init file for package smartrep

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 5, 2013
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

(require 'pre-init-core)

(setq smartrep-mode-line-string-activated nil)
(setq smartrep-mode-line-active-bg nil)

(smartrep-define-key prog-mode-map "M-g"
  '(("M-n" . 'next-error)
    ("M-p" . 'previous-error)))

(eval-after-load* 'flycheck
  (smartrep-define-key flycheck-mode-map "C-c !"
    '(("n" . 'flycheck-next-error)
      ("p" . 'flycheck-previous-error))))

(eval-after-load* 'org
  (smartrep-define-key org-mode-map "C-c"
    '(("C-n" . 'outline-next-visible-heading)
      ("C-p" . 'outline-previous-visible-heading))))

(eval-after-load* 'web-mode
  (smartrep-define-key web-mode-map "C-c C-b"
    '(("n" . 'web-mode-block-next)
      ("p" . 'web-mode-block-previous)))

  (smartrep-define-key web-mode-map "C-c C-e"
    '(("n" . 'web-mode-element-next)
      ("p" . 'web-mode-element-previous)))

  (smartrep-define-key web-mode-map "C-c e"
    '(("n" . 'web-mode-tag-next)
      ("p" . 'web-mode-tag-previous))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-smartrep.el ends here
