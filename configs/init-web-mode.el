;;; init-web-mode.el --- el-get init file for package web-mode

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 23, 2013
;; Keywords: .emacs, css, html, javascript, php

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
(require 'smartrep)

(add-to-list 'auto-mode-alist '("\\.html?\\'"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.php\\'" . web-mode))

(with-eval-after-load 'web-mode
  (add-to-list 'which-func-modes 'web-mode)
  (setq web-mode-enable-comment-keywords t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-heredoc-fontification t)

;;;; Keymap
  (define-key web-mode-map (kbd "C-;") nil)

  (smartrep-define-key web-mode-map "C-c C-b"
    '(("n" . #'web-mode-block-next)
      ("p" . #'web-mode-block-previous)))

  (smartrep-define-key web-mode-map "C-c C-e"
    '(("n" . #'web-mode-element-next)
      ("p" . #'web-mode-element-previous)))

  (smartrep-define-key web-mode-map "C-c e"
    '(("n" . #'web-mode-tag-next)
      ("p" . #'web-mode-tag-previous))))

;;;; Hooks
(defun jkw:web-mode-hooks ()
  "My config for web-mode."
  (editorconfig-mode -1)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset    2)
  (setq web-mode-code-indent-offset   4)
  (setq web-mode-enable-auto-pairing nil)
  (setq indent-tabs-mode nil))

(add-hook 'web-mode-hook #'jkw:web-mode-hooks)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-web-mode.el ends here
