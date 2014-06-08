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
  (require 'e2wm-vcs)

  ;; plugin
  (when (and (featurep 'direx) (featurep 'direx-project))
    ;; https://gist.github.com/kiwanami/1998307
    (defun e2wm:def-plugin-direx (frame wm winfo)
      "e2wm plugin for direx file list."
      (let* ((buf (e2wm:history-get-main-buffer))
             (dbuf (with-current-buffer buf
                     (or
                      (ignore-errors
                        (direx-project:jump-to-project-root-noselect))
                      (direx:find-directory-noselect
                       (or default-directory "."))))))
        (with-current-buffer dbuf
          (direx:item-expand direx:root-item)
          (setq header-line-format "DireX file list")
          (setq mode-line-format
                '("-" mode-line-mule-info
                  " " mode-line-position "-%-")))
        (wlf:set-buffer wm (wlf:window-name winfo) dbuf)))

    (e2wm:plugin-register 'direx
                          "DireX"
                          'e2wm:def-plugin-direx))

  ;; code
  (when (and (require 'e2wm-bookmark nil t)
             (ignore-errors (e2wm:plugin-get 'direx)))

    (setq e2wm:c-code-winfo
          '((:name main)
            (:name bookmarks :plugin bookmarks-list)
            (:name files :plugin direx)
            (:name history :plugin history-list)
            (:name sub :buffer "*info*" :default-hide t)
            (:name imenu :plugin imenu :default-hide nil)))

    (setq e2wm:c-code-recipe
          (if laptop-screen-p
              '(| (:left-max-size 42)
                  (- (:upper-size-ratio 0.5)
                     imenu
                     (- (:upper-size-ratio 0.6)
                        files bookmarks))
                  (- (:upper-size-ratio 0.7)
                     main sub))
            ;; for desktop
            '(| (:left-max-size 45)
                (- (:upper-size-ratio 0.5)
                   files
                   (- (:upper-size-ratio 0.5)
                      bookmarks history))
                (- (:upper-size-ratio 0.7)
                   (| (:right-max-size 40)
                      main imenu)
                   sub)))))

  ;; two
  (setq e2wm:c-two-right-default 'prev))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; init-e2wm.el ends here
