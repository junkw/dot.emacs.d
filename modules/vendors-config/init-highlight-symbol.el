;;; init-highlight-symbol.el --- el-get init file for package highlight-symbol  -*- lexical-binding: t; -*-

;; (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Jul. 24, 2013
;; Keywords: .emacs, highlight

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

(setopt highlight-symbol-idle-delay 0.8)
(setopt highlight-symbol-colors '("#FC5C94" "#FEB257" "#F3EA98" "#C1F161" "#BBF7EF" "#C2A1FF" "#FE87F4"))

;;;; Hooks
(add-hook 'prog-mode-hook 'highlight-symbol-mode)
(add-hook 'prog-mode-hook 'highlight-symbol-nav-mode)

;;;; Keymap
(keymap-set goto-map "h ." #'highlight-symbol-at-point)
(keymap-set goto-map "h %" #'highlight-symbol-query-replace)
(keymap-set goto-map "h n" #'highlight-symbol-next)
(keymap-set goto-map "h p" #'highlight-symbol-prev)

(with-eval-after-load 'smartrep
  (smartrep-define-key goto-map "h"
    '(("n" . #'highlight-symbol-next)
      ("p" . #'highlight-symbol-prev))))

;;; init-highlight-symbol.el ends here
