;; orbitz-logfile-mode.el --- braindead-simple mode for viewing orbitz DC logs

;; Blatently rips off... um...  modeled on john manoogian's props-mode.el

;; TODO: Should be a minor mode

(defgroup orbitz-logfile-mode nil
  "Major (!) mode for viewing DC logs"
  :prefix "orbitz-logfile-mode-"
  :group 'languages)

(defun orbitz-logfile-mode ()
  "Major (!) mode for viewing DC logs

"
  (interactive)
  (kill-all-local-variables)
  (setq mode-name "orbitz-logfile-mode")
  (setq major-mode 'orbitz-logfile-mode)

  (defconst orbitz-logfile-mode-font-lock-keywords
    '(
      ;; Trace (data), Debug
      ( "^\\(\\(T|D\\)\\|.*\\)$"
	(1 font-lock-type-face nil t))
      ;; Info
      ( "^\\(I\\|.*\\)$"
	(1 font-lock-string-face nil t))
      ;; Warning
      ( "^\\(W\\|.*\\)$"
	(1 font-lock-keyword-face nil t))
      ;; Error, Critical
      ( "^\\(\\(E|C\\)\\|.*\\)$"
	(1 font-lock-variable-name-face nil t))
      )
    "gdf is not sure what this string is for.")

  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '((orbitz-logfile-mode-font-lock-keywords)
			     nil nil ((?\_ . "w"))))

  (run-hooks 'orbitz-logfile-mode-hook))

(provide 'orbitz-logfile-mode)