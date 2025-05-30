;;; init-auto-async-byte-compile.el --- el-get init file for package auto-async-byte-compile

;; (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 8, 2012
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

(setopt auto-async-byte-compile-init-file (concat init-module-core-path "pre-init-environments.el"))
(setopt auto-async-byte-compile-exclude-files-regexp
        "\\(\\(\\/\\(Desktop\\|Dropbox\\|vendor\\|var\\|te?mp\\|tests?\\|obsoleted-config\\)\\/.+\\)\\|\\.dir-locals\\|.+-init-private-.+\\)\\.el\\'")

;;; init-auto-async-byte-compile.el ends here
