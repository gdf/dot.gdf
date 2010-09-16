;; 
;; Various useful functions for editing java stuffs.
;; 
;; $Id: gdf-java.el,v 1.3 2004/03/12 00:33:16 gdf Exp $
;;

(defvar gdf-java-locate-srclist ()
  "List of root source directories to search for Java files.")

(defvar gdf-java-locate-ignore "/\\(\\.\\.?\\|CVS\\)$"
  "Regexp: paths matching this will not be considered 
by `gdf-java-locate-sourcefile'")

(defun gdf-java-locate-srclist-add (dir) 
  "Adds a directory to `gdf-java-locate-srclist'.
More recently added dirs have search precedence over ones added earlier."
  (interactive "DAdd source directory: ")
  (setq gdf-java-locate-srclist (cons dir gdf-java-locate-srclist)))

(defun gdf-java-locate-sourcefile (classname)
  "Locates the .java file for the given classname, loads it into a buffer."
  ;;(interactive "sLocate class: ")
  (interactive
   (let ((defthing (thing-at-point 'word)))
     (list (read-string "Locate class: " defthing))))
  (let ((filename (concat classname ".java")))
    (gdf-locate-file-in-srcdirs filename)))

(defun gdf-locate-file-in-srcdirs (filename)
  "Recursively search directories `gdf-java-locate-srclist' for FILENAME.
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


(defun gdf-copyright ()
  "Inserts a BIE copyright notice at the top of the buffer."
  (interactive)
  (let (copyright-notice)
    (setq copyright-notice "/*\n-------------------------------------------------------------------\nBIE is Copyright 2001-2004 Brunswick Corp.\n-------------------------------------------------------------------\nPlease read the legal notices (docs/legal.txt) and the license\n(docs/bie_license.txt) that came with this distribution before using\nthis software.\n-------------------------------------------------------------------\n*/\n")
    (save-excursion
      (goto-char (point-min))
      (cond
       ((not (looking-at "/\\*\n-+\nBIE is Copy")) 
	(insert copyright-notice)
	(message "Inserted copyright notice."))
       (t
	(message "Already have copyright notice."))))))

(defun gdf-UpCamelCase (string)
  "Capitalize the first letter of STRING, leaving the other chars untouched.
This is different than `capitalize', which upcases the first char, but
downcases all the rest.

Returns the transformed string.
"
  (string-match "^\\(.\\)" string)
  (replace-match (upcase (match-string 1 string)) t t string 1))

(defun gdf-java-replace-attrs () 
  "Replace all rubylike attr tags with getters and setters.
Anything of the form \":attr TYPE NAME;\" will be replaced with 
get/set functions.  Whee.
"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward ":attr \\(\\w+\\) \\(\\w+\\);")
      (let (type name upname replacement)
	(setq type (match-string 1))
	(setq name (match-string 2))
	(save-match-data
	  (setq upname (gdf-UpCamelCase name)))
	(setq replacement
	      (concat
	       "protected " type " " name ";\n\n"
	       "public void set" upname "( " type " " name " ) {\n"
	       "    this." name " = " name ";\n"
	       "}\n\n"
	       "public " type " get" upname "() {\n"
	       "    return this." name ";\n"
	       "}\n"))
	(let (start end)
	  (setq start (match-beginning 0)) ;; mark start of match
	  (replace-match replacement t t nil nil)
	  (setq end (point)) ;; point is at end of replacement
	  (gdf-indent-region start (+ 1 end)))))
      (message "All attrs replaced")))

(defun gdf-indent-region (start end)
  "Indent region according to current mode.  Unlike `indent-region', may
be usefully called from a program."
  (interactive "r")
  (save-excursion
    (goto-char start)
    (while (< (point) end)
      (indent-according-to-mode)
      (forward-line 1))))

(defun join (delim partslist) 
  "Concat elements of PARTSLIST with DELIM. Ignores zero-length elements."
  (let (accum)
    (dolist (part partslist accum)
      (cond 
       ((> (length part) 0)
	(when accum
	  (setq accum (concat accum delim)))
	(setq accum (concat accum part)))))))
 
(defun gdf-java-stubber ()
  "Creates a java skeleton."
  (interactive)
  (let (classname packagename)
    (setq classname (file-name-nondirectory 
 		     (file-name-sans-extension buffer-file-name)))
    (setq packagename 
	  (join "." (split-string (file-name-directory buffer-file-name) "/")))
 	  
    (goto-char (point-min))
    (insert (concat
	     "package " packagename ";\n\n"
	     "public class " classname " {\n\n"
	     "public " classname "() {\n\n"
	     "}\n}\n" ))
    (gdf-indent-region (point-min) (point-max))
    (gdf-copyright)))

;; (defun xxx-debug (msg) ""
;;   (save-current-buffer
;;     (set-buffer "*GDFDEBUG*")
;;     (insert msg)))

(provide 'gdf-java)