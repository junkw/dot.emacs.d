;;; post-init-file.el --- Emacs init file

;; (C) 2015  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Feb. 20, 2015
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

(require 'cl-lib)
(eval-when-compile
  (require 'pre-init-environments))

;; Opening a file larger than 100 MB, asks for confirmation first.
(setq large-file-warning-threshold 100000000)

;; Make the file executable if it is a shell script
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

;; File deletion makes use of the Trash.
(when mac-p
  (setq trash-directory "~/.Trash"))
(setq delete-by-moving-to-trash t)

;;;; FFAP
(setq ffap-machine-p-known 'accept)

;; http://mbork.pl/2019-02-17_Inserting_the_current_file_name_at_point
(defun insert-current-file-name-at-point (&optional full-path)
  "Insert the current filename at point.

With prefix argument, use FULL-PATH."
  (interactive "P")
  (let* ((buffer
	  (if (minibufferp)
	      (window-buffer
	       (minibuffer-selected-window))
	    (current-buffer)))
	 (filename (buffer-file-name buffer)))
    (if filename
	(insert (if full-path filename (file-name-nondirectory filename)))
      (error (format "Buffer %s is not visiting a file" (buffer-name buffer))))))

;;;; Dired
(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)
(setq file-system-info (purecopy "-kH"))
(setq dired-listing-switches (purecopy "-alh"))

(require 'wdired)
(setq wdired-create-parent-directories t)
(setq wdired-allow-to-change-permissions t)

(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil)
(setq ls-lisp-dirs-first t)

(require 'dired-aux)
(setq dired-isearch-filenames 'dwim)

;; Compression and uncompression with atool
;; http://d.hatena.ne.jp/mooz/20110911/p1
(defvar jkw:dired-additional-compression-suffixes
  '(".7z" ".Z" ".a" ".ace" ".alz" ".arc" ".arj" ".bz" ".bz2" ".cab" ".cpio" ".deb" ".gz"
    ".jar" ".lha" ".lrz" ".lz" ".lzh" ".lzma" ".lzo" ".rar" ".rpm" ".rz" ".t7z" ".tZ"
    ".tar" ".tbz" ".tbz2" ".tgz" ".tlz" ".txz" ".tzo" ".war" ".xz" ".zip")
  "Suffixes for compression and uncompression adding in `dired-compress-file-suffixes'.")

(when (executable-find "atool")
  (cl-loop for suffix in jkw:dired-additional-compression-suffixes
           do (add-to-list 'dired-compress-file-suffixes
                           `(,(concat "\\" suffix "\\'") "" "aunpack"))))

;; Batch convert coding system
;; http://www.bookshelf.jp/soft/meadow_25.html#SEC273
(defvar dired-default-file-coding-system nil
  "Default coding system for converting file(s).")

(defvar dired-file-coding-system 'no-conversion)

(defun dired-convert-coding-system ()
  "Function for converting coding system on dired."
  (let ((file (dired-get-filename))
        (coding-system-for-write dired-file-coding-system)
        failure)
    (condition-case err
        (with-temp-buffer
          (insert-file-contents file)
          (write-region (point-min) (point-max) file))
      (error (setq failure err)))
    (if (not failure)
        nil
      (dired-log "convert coding system error for %s:\n%s\n" file failure)
      (dired-make-relative file))))

(defun dired-do-convert-coding-system (coding-system &optional arg)
  "Convert file(s) in specified CODING-SYSTEM.

ARG is like in `dired-map-over-marks'."
  (interactive
   (list (let ((default (or dired-default-file-coding-system
                            buffer-file-coding-system)))
           (read-coding-system
            (format "Coding system for converting file(s) (default, %s): " default)
            default))
         current-prefix-arg))
  (check-coding-system coding-system)
  (setq dired-file-coding-system coding-system)
  (dired-map-over-marks-check
   (function dired-convert-coding-system) arg 'convert-coding-system t))

;;;; Keymap
(global-set-key (kbd "M-o") #'insert-current-file-name-at-point)

(define-key dired-mode-map (kbd "C-c C-e") #'wdired-change-to-wdired-mode)
(define-key dired-mode-map (kbd "E") #'dired-do-convert-coding-system)

;;; post-init-file.el ends here
