;;
;; gdf customization for hacking ruby
;;

;; basic mode settings
(autoload 'ruby-mode "ruby-modes/ruby-mode" "Ruby editing mode." t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Rakefile" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("rakefile" . ruby-mode) auto-mode-alist))
;; default ruby-mode has tabs on?  ugh.
(add-hook 'ruby-mode-hook (lambda () (setq indent-tabs-mode nil)))

;; might need to also change compilation-error-regexp-systems-list
;; and rerun compilation-build-compilation-error-regexp-alist
;;;(append
;;; '((ruby) (".*\\([^ \n]+\\):\\([0-9]+\\):in `[a-zA-Z0-9_]+'.*" 1 2))
;;; compilation-error-regexp-alist-alist )

;; custom functions

(defun rdoc-open-buffer-launch (html-file)
  (interactive)
  (shell-command (concat "open " html-file))
)

(defun rdoc-open-buffer ()
  (interactive)
  (let (tempdir buffer-file filetrans htmlfile)
    (setq tempdir 
	  (concat
	   ;; the perl is a hack to remove the trailing \n
	   ;; i can't figure out how to do this in lisp...
	   (shell-command-to-string "mktemp -d /tmp/rdocXXXXXX|perl -pe chomp")
	   "/stupid"
	   ))
    (shell-command
     (concat "/usr/local/bin/rdoc -o " tempdir " " (buffer-file-name)))
    (setq filetrans
	  (replace-regexp-in-string "\\." "_"
				    (buffer-file-name)))
    ;;(setq htmlfile (concat tempdir "/files/" filetrans ".html"))
    (setq htmlfile (concat tempdir "/index.html"))
    (rdoc-open-buffer-launch htmlfile)
  )
)

(global-set-key [?\M-r] 'rdoc-open-buffer)