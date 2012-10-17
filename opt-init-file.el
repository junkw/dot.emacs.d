;;; opt-init-file.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 17, 2012
;; Keywords: .emacs, dired

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

(eval-when-compile (require 'cl))
(require 'pre-init-core)

;; Find file at point
(ffap-bindings)

;; Opening a file larger than 25 MB, asks for confirmation first.
(setq large-file-warning-threshold (* 25 1024 1024))

;; File deletion makes use of the Trash.
(when mac-p
  (setq trash-directory "~/.Trash"))
(setq delete-by-moving-to-trash t)

;; Dired mode
(require 'wdired)
(setq wdired-allow-to-change-permissions t)
(define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)

;; Compression and uncompression with atool
;; http://d.hatena.ne.jp/mooz/20110911/p1
(defvar jkw:dired-additional-compression-suffixes
  '(".7z" ".Z" ".a" ".ace" ".alz" ".arc" ".arj" ".bz" ".bz2" ".cab" ".cpio" ".deb" ".gz"
    ".jar" ".lha" ".lrz" ".lz" ".lzh" ".lzma" ".lzo" ".rar" ".rpm" ".rz" ".t7z" ".tZ"
    ".tar" ".tbz" ".tbz2" ".tgz" ".tlz" ".txz" ".tzo" ".war" ".xz" ".zip")
  "Suffixes for compression and uncompression adding in `dired-compress-file-suffixes'.")
     
(eval-after-load-q "dired-aux"
  (when (executable-find "atool")
    (loop for suffix in jkw:dired-additional-compression-suffixes
          do (add-to-list 'dired-compress-file-suffixes
                          `(,(concat "\\" suffix "\\'") "" "aunpack")))))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; End:

;;; opt-init-file.el ends here
