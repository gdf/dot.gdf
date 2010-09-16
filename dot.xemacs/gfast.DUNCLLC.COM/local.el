;; local settings for orbitz

(defvar font-lock-function-name-face nil "no clue, but makes indenting work?")
(defvar font-lock-other-type-face nil "indent my vars!@#!@")

; set background color to burn the eyes less
(set-face-background 'default "#DDEECC")
;; doesn't work? (set-face-font 'default (make-font-specifier "-*-profontwindows-*-*-*-*-12-*-*-*-*-*-*-*"))

(cond (running-xemacs

       ;;(add-to-list 'load-path (expand-file-name "~/.xemacs/elisp/fsf-compat"))
       (load "overlay")

;new       (load "gdf-htmlhider-xemacs")
;new       (add-hook 'html-helper-mode-hook 
;new		 (function 
;new		  (lambda () 
;new		    (local-set-key '[(control \c)(\h)] 'gdf-invisiblock)
;new		    (local-set-key '[(control \c)(\s)] 'gdf-ol-clear-one)
;new		    (local-set-key '[(control \c)(\a)] 'gdf-ol-clear)
;new		    ;; (font-lock-mode 251)
;new		    )))

       (set-frame-size (selected-frame) 80 70) 
      
       )) ; (end) running-xemacs


;; gdf-java mode.  whoo.
(setq load-path (cons (expand-file-name "~/.xemacs/elisp/gdf-elisp") load-path))
(require 'gdf-java)
(gdf-java-locate-srclist-add "~/cheese/bie/plugins/actions")
(gdf-java-locate-srclist-add "~/cheese/bie/commons-tools")
(gdf-java-locate-srclist-add "~/cheese/bie/src")
(global-set-key "\C-c\C-f" 'gdf-java-locate-sourcefile)

(require 'props-mode)
(setq auto-mode-alist (cons '("\\.properties$" . props-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.properties\\.tmpl$" . props-mode) auto-mode-alist))

(require 'orbitz-log-mode)

(add-hook 'ruby-mode-hook
   	  (lambda ()
   	    (setq indent-tabs-mode nil)))

(load "graphviz-dot-mode")

(load "gdf-elisp/meetingnotes")
