;;; post-init-man.el --- Emacs init file

;; Copyright (C) 2012  Jumpei KAWAMI

;; Author: Jumpei KAWAMI <don.t.be.trapped.by.dogma@gmail.com>
;; Created: Oct. 13, 2012
;; Keywords: .emacs, man, woman

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

(autoload 'woman "woman" "Decode and browse a UN*X man page." t)
(autoload 'woman-find-file "woman" "Find, decode and browse a specific UN*X man-page file." t)

(eval-after-load-q 'woman
  ;; Paths
  (add-to-list 'woman-manpath "~/.emacs.d/share/man")
  (setq woman-cache-filename "~/.emacs.d/var/cache/woman") ; Update cache: C-u M-x woman

  ;; Doesn't make new frame
  (setq woman-use-own-frame nil)

  ;; For imenu
  (setq woman-imenu t)
  (setq woman-imenu-generic-expression
        '((nil "\n\\([A-Z].*\\|\\cj.*\\)" 1)
          ("*Subsections*" "^ \\{3,4\\}\\([A-Z].*\\|\\cj.*\\)" 1)))

  ;; Jump to SEE ALSO by <r>
  (setq Man-see-also-regexp "\\(SEE ALSO\\|関連項目\\)")

  ;; Jump to heading by <n> and <p>
  (setq Man-first-heading-regexp
        "^\\(NAME\\|名[前称]\\|[ \t]*No manual entry fo.*\\)$")
  (setq Man-heading-regexp "^\\([A-Z][A-Z0-9 /-]+\\|\\cj+\\)$")

  ;; Keymap
  (defvar jkw:woman-pager-keybinds
    '(("j" . next-line)
      ("k" . previous-line)
      ("J" . (lambda () (interactive) (scroll-up 1)))
      ("K" . (lambda () (interactive) (scroll-down 1)))
      ("b" . scroll-down)
      ("l" . forward-char)
      ("h" . backward-char))
    "My keybinds for WoMan mode.")
  (jkw:define-keys woman-mode-map jkw:woman-pager-keybinds))

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-emacs-unix
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not free-vars unresolved mapcar constants)
;; End:

;;; post-init-man.el ends here
