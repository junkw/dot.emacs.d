;;; init-web-mode.el --- el-get init file for package web-mode  -*- lexical-binding: t; -*-

;; (C) 2013  Jumpei KAWAMI

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

(setopt web-mode-engines-alist '(("php" . "\\.html\\.php\\'")))

(setopt web-mode-enable-auto-pairing nil)
(setopt web-mode-enable-auto-indentation nil)
(setopt web-mode-enable-auto-expanding t)
(setopt web-mode-enable-comment-annotation t)
(setopt web-mode-enable-comment-interpolation t)
(setopt web-mode-enable-current-element-highlight t)
(setopt web-mode-enable-heredoc-fontification t)
(setopt web-mode-enable-sql-detection t)
(setopt web-mode-part-padding 0)

;;;; Hooks
(defun jkw:web-mode-init ()
  "My config for web-mode."
  (setq web-mode-script-padding 0)
  (setq web-mode-style-padding 0)

  (unless editorconfig-mode
    (setq indent-tabs-mode nil)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 4)))

(add-hook 'web-mode-hook #'jkw:web-mode-init)

;;;; Keymap
(keymap-set web-mode-map "C-;" nil)

(with-eval-after-load 'smartrep
  (smartrep-define-key web-mode-map "C-c C-b"
    '(("n" . #'web-mode-block-next)
      ("p" . #'web-mode-block-previous)))

  (smartrep-define-key web-mode-map "C-c C-e"
    '(("n" . #'web-mode-element-next)
      ("p" . #'web-mode-element-previous)))

  (smartrep-define-key web-mode-map "C-c C-t"
    '(("n" . #'web-mode-tag-next)
      ("p" . #'web-mode-tag-previous))))

;;; init-web-mode.el ends here
