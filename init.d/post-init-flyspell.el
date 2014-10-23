;;; post-init-flyspell.el --- Emacs init file

;; Copyright (C) 2013  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gflyspell.com>
;; Created: Jan. 22, 2014
;; Keywords: .emacs, spell check

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

(lazyload 'flyspell nil
  (require 'ispell)
  (setq-default ispell-program-name (executable-find "aspell"))
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")) ; for Japanese

;;;; Command
  (when (locate-library "popup")
    ;; http://d.hatena.ne.jp/mooz/20100423/p1
    (defun flyspell-correct-word-with-popup ()
      "Pop up a menu of possible corrections for misspelled word before point."
      (interactive)
      ;; use the correct dictionary
      (flyspell-accept-buffer-local-defs)
      (let ((cursor-location (point))
            (word (flyspell-get-word nil)))
        (if (consp word)
            (let ((start (car (cdr word)))
                  (end (car (cdr (cdr word))))
                  (word (car word))
                  poss ispell-filter)
              ;; now check spelling of word.
              (ispell-send-string "%\n")	; put in verbose mode
              (ispell-send-string (concat "^" word "\n"))
              ;; wait until ispell has processed word
              (while (progn
                       (accept-process-output ispell-process)
                       (not (string= "" (car ispell-filter)))))
              ;; Remove leading empty element
              (setq ispell-filter (cdr ispell-filter))
              ;; ispell process should return something after word is sent.
              ;; Tag word as valid (i.e., skip) otherwise
              (or ispell-filter
                  (setq ispell-filter '(*)))
              (if (consp ispell-filter)
                  (setq poss (ispell-parse-output (car ispell-filter))))
              (cond
               ((or (eq poss t) (stringp poss))
                ;; don't correct word
                t)
               ((null poss)
                ;; ispell error
                (error "Ispell: error in Ispell process"))
               (t
                ;; The word is incorrect, we have to propose a replacement.
                (flyspell-do-correct (popup-menu* (car (cddr poss)) :scroll-bar t :margin t)
                                     poss word cursor-location start end cursor-location)))
              (ispell-pdict-save t)))))

;;;; Keymap
    (define-key flyspell-mode-map (kbd "C-M-<return>") 'flyspell-correct-word-with-popup)))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; post-init-flyspell.el ends here
