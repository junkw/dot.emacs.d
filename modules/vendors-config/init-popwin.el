;;; init-popwin.el --- el-get init file for package popwin

;; (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Aug. 7, 2013
;; Keywords: .emacs, window manager

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

(popwin-mode +1)

;;;; Display config
(push '(all-mode :noselect t) popwin:special-display-config)
(push 'apropos-mode popwin:special-display-config)
(push '(" *auto-async-byte-compile*" :noselect t) popwin:special-display-config)
(push '("*Backtrace*" :noselect t) popwin:special-display-config)
(push '("*Compile-Log*" :height 10 :noselect t) popwin:special-display-config)
(push '("*el-get packages*" :position bottom :height 25) popwin:special-display-config)
(push '("*Flycheck errors*" :position bottom :height 10 :noselect t :stick t) popwin:special-display-config)
(push '("*vc-log*" :stick t) popwin:special-display-config)

;;;; Keymap
(global-set-key (kbd "C-z") popwin:keymap)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-popwin.el ends here
