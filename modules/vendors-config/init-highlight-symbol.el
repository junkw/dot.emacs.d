;;; init-highlight-symbol.el --- el-get init file for package highlight-symbol

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

;; Color
(setq highlight-symbol-colors '("#FC5C94" "#FEB257" "#F3EA98" "#C1F161" "#BBF7EF" "#C2A1FF" "#FE87F4"))

;;;; Keymap
(global-set-key (kbd "C-x w .") #'highlight-symbol-at-point)
(global-set-key (kbd "M-s h .") #'highlight-symbol-at-point)
(global-set-key (kbd "M-s M-n") #'highlight-symbol-next)
(global-set-key (kbd "M-s M-p") #'highlight-symbol-prev)
(global-set-key (kbd "M-s h %") #'highlight-symbol-query-replace)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-highlight-symbol.el ends here
