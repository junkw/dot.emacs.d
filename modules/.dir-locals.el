;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil
  (indent-tabs-mode))
 (emacs-lisp-mode
  (byte-compile-warnings . (not free-vars unresolved mapcar constants))
  (whitespace-style face tabs trailing lines-tail)
  (whitespace-line-column . 80)))
