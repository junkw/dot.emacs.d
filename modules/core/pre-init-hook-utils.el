;;; pre-init-hook-utils.el --- Emacs init file

;; (C) 2017  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Sep. 9, 2017
;; Keywords: .emacs, utility, hook

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

(eval-when-compile
  (require 'cl-lib))

(defun add-hooks (modes function)
  "`add-hook' extension
for batch adding to the listof MODES the function FUNCTION."
  (cl-loop for mode in modes
           when (fboundp mode)
           do (add-hook (intern (format "%s-hook" mode)) function)))

(provide 'pre-init-hook-utils)

;;; pre-init-hook-utils.el ends here
