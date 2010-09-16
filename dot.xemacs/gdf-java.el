
(setq gdf-java-locate-srclist ())
(setq gdf-java-locate-ignore "/\\(\\.\\.?\\|CVS\\)$")

;; (gdf-java-locate-srclist-add "~/cheese/bie/src")
;; (gdf-java-locate-srclist-add "~/cheese/bie/commons-bie")
;; (gdf-java-locate-srclist-add "~/cheese/bie/commons-tools")

(defun gdf-java-locate-srclist-add (dir) ""
  (setq gdf-java-locate-srclist (cons dir gdf-java-locate-srclist)))

(defun pristine-gdf-java-locate-sourcefile (classname)
  "Locates the .java file for the given classname, loads it into a buffer."
  (interactive "sLocate class: ")
  (let ((filename (concat classname ".java")))
    (gdf-locate-file-in-srcdirs filename)))

(defun gdf-java-locate-sourcefile (classname)
  "Locates the .java file for the given classname, loads it into a buffer."
  (interactive
   (let ((defname (thing-at-point 'word)))
     (list (read-string "Locate class: " defname))))
  (let ((filename (concat classname ".java")))
    (gdf-locate-file-in-srcdirs filename)))

;; UpdateActionCommand

(defun gdf-locate-file-in-srcdirs (filename)
  "Recursively search directories gdf-java-locate-srclist for FILENAME.
If found, FILENAME will be loaded into a new buffer and made current."
  (let ((foundfile nil))
    (dolist (dir gdf-java-locate-srclist foundfile)
      (unless foundfile
	(setq foundfile (gdf-locate-file-in-dir filename dir))))
    (if foundfile
	(find-file foundfile)
      (message (concat "Can't locate " filename)))))

(defun gdf-locate-file-in-dir (filename dir)
  "Returns either nil or the absolute filename of a filename under dir."

  (let ((absfile (expand-file-name filename dir)))
    (if (file-exists-p absfile)
	absfile ;; return value if file found here
      (let ((subdirs (directory-files dir t nil nil "onlyDirectories"))
	    (retval nil))
	(dolist (f subdirs retval)
	  (unless retval
	    (unless (string-match gdf-java-locate-ignore f)
	      (progn
		(when (file-directory-p f)
		  (setq retval (gdf-locate-file-in-dir filename f)))))))))))

;; (defun xxx-debug (msg) ""
;;   (save-current-buffer
;;     (set-buffer "*GDFDEBUG*")
;;     (insert msg)))
