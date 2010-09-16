;; props-mode.el --- major mode for editing .properties files

;; Author: john manoogian III <jm3@jm3.net>
;; Maintainer: jm3
;; Keywords: languages

;;; original at:
;;; http://www.jm3.net/code/lisp/deprecated/props-mode.el
;;; minor mods by gdf

;; TODO

(defgroup props-mode nil
  "Major mode for editing properties files."
  :prefix "props-mode-"
  :group 'languages)

(defface props-comment-face
  '((t
     (:foreground "blue4")))
  "Face for comments"
  :group 'props-mode)

(defface props-property-name-face
  '((t
     (:foreground "magenta4")))
  "Face for prop names"
  :group 'props-mode)

(defface props-value-face
  '((t
     (:foreground "steelblue")))
  "Face for prop values"
  :group 'props-mode)


(defun props-mode ()
  "Major mode for editing properties files

Overview:
it's really fucking simple, alright? just use it.

"
  (interactive)
  (kill-all-local-variables)
  (setq mode-name "props-mode")
  (setq major-mode 'props-mode)
  (setq comment-start "#")
(defconst props-mode-font-lock-keywords
  '(

    ;; name=value pairs
   ("^\\(.+\\) *\\(=\\) *\\(.*\\)$"
     (1 font-lock-variable-name-face nil t)
     (2 font-lock-comment-face nil t)
     (3 font-lock-string-face nil t))

   ;; line comments
   ("#.*$" 0 font-lock-comment-face t)

    ;; cvs/rcs ident strings, optionally within html comments
    ("#?.*\\$\\(Id[^$]+\\)\\$"
      (0 font-lock-preprocessor-face t)
    )
      
    )
  "font-lockety-lock.")

  (make-local-variable 'font-lock-defaults)  
  (setq font-lock-defaults '((props-mode-font-lock-keywords)
			     nil nil ((?\_ . "w"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(run-hooks 'props-mode-hook))
(provide 'props-mode)
