;;; init-e2wm.el --- el-get init file for package e2wm

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Nov. 27, 2013
;; Keywords: .emacs, window

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

(lazyload 'e2wm '(e2wm:start-management)
  (require 'e2wm-config)

  ;; code
  (require 'e2wm-vcs)

  (when (require 'e2wm-bookmark nil t)
    (setq e2wm:c-code-recipe
          '(| (:left-max-size 45)
              (- (:upper-size-ratio 0.5)
                 files
                 (- (:upper-size-ratio 0.5)
                    bookmarks history))
              (- (:upper-size-ratio 0.7)
                 (| (:right-max-size 40)
                    main imenu)
                 sub)))

    (setq e2wm:c-code-winfo
          '((:name main)
            (:name bookmarks :plugin bookmarks-list)
            (:name files :plugin files)
            (:name history :plugin history-list)
            (:name sub :buffer "*info*" :default-hide t)
            (:name imenu :plugin imenu :default-hide nil))))

  ;; two
  (setq e2wm:c-two-right-default 'prev))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-e2wm.el ends here