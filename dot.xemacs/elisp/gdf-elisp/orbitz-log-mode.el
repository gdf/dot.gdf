;;
;; Merge with the train version...
;;

(defgroup orbitz-log-mode nil
  "Major mode for browsing orbitz DC log files"
  :prefix "orbitz-log"
  :group 'languages)

;;;
;; I use a light background, ymmv:

(defface orbitz-log-data-face
  '((t (:foreground "black")))
  "Face for message stamp data: timestamp, IP, vmid, session, etc."
  :group 'orbitz-log)

(defface orbitz-log-trace-face
  '((t (:foreground "#AAAACC")))
  "Face for DATA (trace) messages."
  :group 'orbitz-log)

(defface orbitz-log-debug-face
  '((t (:foreground "steelblue")))
  "Face for DEBUG messages."
  :group 'orbitz-log)

(defface orbitz-log-info-face
  '((t (:foreground "green4")))
  "Face for INFO messages."
  :group 'orbitz-log)

(defface orbitz-log-warning-face
  '((t (:foreground "green4" :bold t)))
  "Face for WARNING messages."
  :group 'orbitz-log)

(defface orbitz-log-error-face
  '((t (:foreground "red")))
  "Face for ERROR messages."
  :group 'orbitz-log)

(defface orbitz-log-critical-face
  '((t (:foreground "red" :bold t)))
  "Face for CRITICAL messages."
  :group 'orbitz-log)

(defvar orbitz-log-trace-face 'orbitz-log-trace-face)
(defvar orbitz-log-debug-face 'orbitz-log-debug-face)
(defvar orbitz-log-info-face 'orbitz-log-info-face)
(defvar orbitz-log-warning-face 'orbitz-log-warning-face)
(defvar orbitz-log-error-face 'orbitz-log-error-face)
(defvar orbitz-log-critical-face 'orbitz-log-critical-face)

;;;

(defconst orbitz-log-font-lock-keywords
  '(("^T|.*$" . orbitz-log-trace-face)
    ("^D|.*$" . orbitz-log-debug-face)
    ("^I|.*$" . orbitz-log-info-face)
    ("^W|.*$" . orbitz-log-warning-face)
    ("^E|.*$" . orbitz-log-error-face)
    ("^C|.*$" . orbitz-log-critical-face)))

(defconst orbitz-log-font-lock-defaults
  '(orbitz-log-font-lock-keywords t nil nil nil))

(defun orbitz-log-mode ()
  "Major mode for browsing orbitz DC log files"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'orbitz-log-mode)
  (setq mode-name "Orbitz-Log")
  ;; (use-local-map ... )
  ;; (make-local-variable ... )

  (run-hooks 'orbitz-log-mode-hook))

(provide 'orbitz-log-mode)