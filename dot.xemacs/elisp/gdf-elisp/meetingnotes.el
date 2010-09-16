;;
;;
;;
(setq meetingnotes-meetings-directory "~/words")

(defun meetingnotes-new-meeting (name)
  "Opens a buffer for a new meeting"
  (interactive "sMeeting brief description: ")
  (let (filename)
    (setq filename (concat
	  meetingnotes-meetings-directory "/"
	  (format-time-string "%Y%m%d-%H%M--" (current-time))
	  (replace-in-string name " " "-")
	  ".txt"))
    (find-file filename)))

;;    (message (concat "Meeting desc: " filename))))
