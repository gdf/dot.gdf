;; gdf's .emacs.  share and enjoy.
;;; $Id: init.el,v 1.13 2006/02/23 22:27:38 gdf Exp $

(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

(setq load-path (cons "~/.xemacs/elisp" load-path))

;;; Set up per-host configuration.  Loads "~/.xemacs/<hostname>/local.el" .
; (system-name) does not appear consistent. It most certainly does not
;  reliably return what `hostname` does, across various boxes.
; Of course, `hostname` varies pretty wildly depending on what local net
; you're on...
(add-to-list 'load-path (concat "~/.xemacs/__default.host__"))
(setq local-hostname (shell-command-to-string "hostname | tr -d \\\\n"))
(add-to-list 'load-path (concat "~/.xemacs/" local-hostname))
(load "local")

(setq next-line-add-newlines nil) ; should be the default in xemacs, but...

;; modes
(setq auto-mode-alist (cons '("\\.cgi$" . perl-mode) auto-mode-alist))
(setq auto-mode-alist
      (append '(("\\.\\(m?[pP][Llm]\\|al\\)$" . perl-mode))  auto-mode-alist ))
(add-hook 'mh-letter-mode-hook 'turn-on-auto-fill)
(setq auto-mode-alist (cons '("newrumor\\." . mh-letter-mode) auto-mode-alist))

;;20040302 use xml-mode (psgml) for html docs
(setq auto-mode-alist (cons '("\\.html$" . xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.jsp$" . xml-mode) auto-mode-alist))

(setq tempo-interactive t)

;; whee.  my butt is on fire.
(global-set-key [?\C-h] 'delete-backward-char)
(global-set-key [?\M-?] 'help-command)
(global-set-key [?\M-a] 'auto-fill-mode)
(global-set-key [?\M-g] 'goto-line)
(global-set-key [?\C-b] 'kill-this-buffer)
(global-set-key [?\C-l] 'fill-paragraph-or-region)

;; one line scroll up/down
(defun scroll-up-one-line () (interactive) (scroll-up 1) )
(defun scroll-down-one-line () (interactive) (scroll-down 1) )
;;(global-set-key [(control \.)] 'scroll-up-one-line) ; C-.
;;(global-set-key [(control \;)] 'scroll-down-one-line) ; C-;
;; this is *terrible* but at least works with my damn terminal
(defun up-and-rd () (interactive) (scroll-up 1) (redraw-display))
(defun down-and-rd () (interactive) (scroll-down 1) (redraw-display))
(global-set-key [(control ?n)] 'up-and-rd)
(global-set-key [(control ?p)] 'down-and-rd)
(global-set-key [?\C-l] 'redraw-display) ;; don't recenter
;; map scroll wheel to scrollup, scrolldown
(global-set-key [(button5)] 'up-and-rd)
(global-set-key [(button4)] 'down-and-rd)


;; cperl-mode stuff
(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq interpreter-mode-alist (append interpreter-mode-alist
                                     '(("miniperl" . perl-mode))))
(setq cperl-hairy nil) ;; bells n witless...  damn electric keywords.
(setq cperl-font-lock t)
(setq cperl-electric-lbrace-space t)
(setq cperl-electric-parens nil)
(setq cperl-electric-linefeed t) ;; ??
(setq cperl-electric-keywords nil) ;; ugh.  ulch.
(setq cperl-info-on-command-no-prompt t)
(setq cperl-clobber-lisp-bindings t)
(setq cperl-auto-newline nil) ;; good god!

;; C-x/- and C-xj-.  fun.

;; more gdf stuff
(defun scroll-up-and-loop () 
  "Scroll down one page.  
At the end of the buffer, first move point to end, then loop to top."
  (interactive)
  (if (= (point) (point-max))
      (goto-char (point-min))
    (if (< (window-end) (point-max))
	(scroll-up nil)
      (goto-char (point-max)))))

(defun scroll-down-and-loop () 
  "Scroll up one page.  
At the top of the buffer, first move point to top, then loop to bottom."
  (interactive)
  (if (= (point) (point-min))
      (goto-char (point-max))
    (if (> (window-start) (point-min))
	(scroll-down nil)
      (goto-char (point-min)))))

(global-set-key [?\C-v] 'scroll-up-and-loop)
(global-set-key [?\M-v] 'scroll-down-and-loop)

;; perl sub search fn
(defun point-sub-search ()
  "search for the sub definition for the sub at before the point"
  (interactive)
  ; get the pointed-to-word
  (let (here there string subname)
    (save-excursion
      (forward-word -1)
      (setq here (point))
      (forward-word 1)
      (setq there (point))
      (setq string (buffer-substring here there)))
    (setq subname (concat "sub " string))
;    (forward-word -1)
    (or
     (search-backward subname nil t); return nil, not point, if fail
     (search-forward subname); will give err on fail
     )
))

(global-set-key [?\M-s] 'point-sub-search)

;; speedbar
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)

;; jde
;0jde; ;; fucked up, just use java-mode for a while.
;0jde; (require 'jde)

;;???
;;20040302 (defvar html-helper-bold-face 
;;20040302   (defface html-helper-bold-face
;;20040302     '((((class color)
;;20040302 	(background dark))
;;20040302        (:foreground "wheat" :bold t))
;;20040302       (((class color)
;;20040302 	(background light))
;;20040302        (:foreground "peru" :bold t))
;;20040302       (t
;;20040302        (:foreground "peru" :bold t)))
;;20040302     "Custom bold face."
;;20040302     :group 'html-helper-faces))
;;20040302 (defvar html-tag-face (make-face 'html-tag-face))

;0jde; (setq jde-setnu-mode-enable t)

(defun java-mode-set-to-andy-madness () 
  "Set up java-mode to indent with real tabs, but with <8 chars per tab."
  (interactive)
  (setq c-tab-always-indent nil)
  (setq indent-tabs-mode t)
  ;;(c-set-style "linux")
;  (append '("gdf-java" "linux" (c-basic-offset . 4))
;	  c-style-alist)
  (c-add-style "gdf-java" '("linux" (c-basic-offset . 3)))
  (c-set-style "gdf-java")
  ;; note: tab-width *must* match c-basic-offset
  ;; or else tabs will be inserted until indentation equals c-basic-offset
  (setq tab-width 3)
  (font-lock-mode t)
  (line-number-mode 1)
)

(defun java-mode-set-to-bmadigan ()
  "Set up java-mode to fit brian's forte tabbing"
  (interactive)
  (setq c-tab-always-indent t)
  (setq indent-tabs-mode nil)
  (c-add-style "bmadigan-java" 
	       '("linux" (c-basic-offset . 4)))
  (c-set-style "bmadigan-java")
  (setq tab-width 4)  
)

(defun java-mode-happiness ()
  "Set up java-mode to rule, indentationally"
  (interactive)
  (c-add-style "gdf-happy-java"
	       '("linux"
		 (c-tab-always-indent . t)
		 (indent-tabs-mode . nil)
		 (c-basic-offset . 4)
		 (tab-width . 4)
		 ;; handle inline-open rule, to catch { after "throws" clause
		 ;; inline-open: indent "throws, undent the following openbrace
		 ;; topmost-intro-cont: indent "extends"/"implements" clauses
		 ;; class-open: undent class openbrace when on its own line
		 (c-offsets-alist . ((inline-open . 0)
				     (topmost-intro-cont . +)
				     (class-open . 0)
				     ))
		 ))
  (c-set-style "gdf-happy-java")
)

;(add-hook 'java-mode-hook 'java-mode-set-to-andy-madness)
;; ant -find looks up the fs for a build.xml!  whee!
;; setting the bfcs to undecided-unix makes emacs output nice \n's
;; also see (setq-default buffer-file-coding-system 'undecided-unix)
(add-hook 'java-mode-hook
	  (lambda ()
	    (java-mode-happiness)
	    (set (make-local-variable 'compile-command)
		 (concat "ant -find build.xml -emacs "))
	    (setenv "ANT_OPTS" "") ;; delete ant_opts, to not use jikes
	    (setq buffer-file-coding-system 'undecided-unix)
	    (font-lock-mode t)
	    ))
(global-set-key [?\M-m] 'compile)
;(add-hook 'java-mode-hook
;	  (lambda ()
;	    (font-lock-mode nil)))


(defun make-sane-python-mode-style ()
  "Set up a good python mode: the default uses tab chars and 8-space indents"
  (interactive)
  (c-add-style "gdf-python"
	       '("python"
		 (indent-tabs-mode . nil)
		 (c-basic-offset . 2)
		 (tab-width . 2)
		 (c-tab-always-indent . t)))
  (c-set-style "gdf-python")
)
(add-hook 'python-mode-hook
	  (lambda ()
	    (make-sane-python-mode-style)
	    (set-variable 'py-indent-offset 2)
	    (set-variable 'indent-tabs-mode nil)
	    (font-lock-mode t)))


;;; javascript-mode now comes with xemacs:
;8; ;; javascript mode?  3 july 01 - http://hesketh.com/schampeo/javascript/
;8; (autoload 'javascript-mode
;8;   "~/elisp/javascript-cust"
;8;   "javascript mode" t nil)

(setq auto-mode-alist 
      (append '(("\\.js$" . javascript-mode))
	      auto-mode-alist))

;; folding-mode
(autoload 'folding-mode          "folding" "Folding mode" t)
(autoload 'turn-off-folding-mode "folding" "Folding mode" t)
(autoload 'turn-on-folding-mode  "folding" "Folding mode" t)

;;20040302 ;;(setq fold-mode-marks-alist
;;20040302 ;;    (append '((html-helper-mode "<%-- {{{" "<%-- }}}"))
;;20040302 ;;	      fold-mode-marks-alist))
;;20040302 
;;20040302 ;; for hs-minor-mode in html-helper-mode
;;20040302 ;;(defun html-helper-hs-sexp-block "" (interactive)
;;20040302   
;;20040302 
;;20040302 ;; maybe should just add the blocks stuff to hs-mode-hook?
;;20040302 (defun hs-happy-html-helper ()
;;20040302   "Turn on hs-minor-mode in html-helper-mode, and get it to
;;20040302    consider matched tags as a \"block\"."
;;20040302   (interactive)
;;20040302 
;;20040302   (hs-minor-mode t)
;;20040302   (defvar gdf-taglist)
;;20040302   (defvar gdf-starttag)
;;20040302   (defvar gdf-endtag)
;;20040302   (setq gdf-taglist (regexp-opt '("table" "tr" "td" "b" )))
;;20040302   (setq gdf-starttag (concat "<" gdf-taglist "[ \t\n]"))
;;20040302   (setq gdf-endtag (concat "</" gdf-taglist ">"))
;;20040302   ;; need a forward-sexp function
;;20040302   (pushnew '(html-helper-mode gdf-starttag gdf-endtag)
;;20040302 	   hs-special-modes-alist :test 'equal)
;;20040302 )
;;20040302 ;;(add-hook 'html-helper-mode-hook 'hs-happy-html-helper)

;obs; (defun gdf-kill-frame () "" (interactive)
;obs;   (if (gnuserv-buffer-clients (current-buffer))
;obs;       (gnuserv-edit)
;obs;     (delete-frame (selected-frame) t)))
(if (fboundp 'gnuserv-start)
    (progn
      (gnuserv-start)
      (defun gdf-kill-frame () "" (interactive)
	(if (gnuserv-buffer-clients (current-buffer))
	    (gnuserv-edit)
	  (delete-frame (selected-frame) t))))
  (defun gdf-kill-frame () "" (interactive)
    (delete-frame (selected-frame) t)))

(global-set-key '[(control \x)(control \c)] 'gdf-kill-frame)

;; (global-set-key '[(control \;) (control \;)] 'rumor)

;; (define-key global-map '(shift tab) 'self-insert-command)

(define-key global-map '[(control \')] 'font-lock-mode)

(defun gdf-c ()
  (interactive)
  (let (starttag endtag)
    (setq starttag "<c:out value=\"")
    (setq endtag "\" />")
    (save-excursion
      (goto-char (region-beginning))
      (insert starttag))
    (save-excursion
      (goto-char (region-end))
      (insert endtag)))
)


(defun gdf-html-tag-region (tag)
  "Wraps the region in a given tag."
  (interactive "*sTag to wrap with: ")
  (let (starttag endtag)
    (setq starttag (concat "<" (upcase tag) ">"))
    (setq endtag (concat "</" (upcase tag) ">"))
    (save-excursion
      (goto-char (region-beginning))
      (insert starttag))
    (save-excursion
      (goto-char (region-end))
      (insert endtag)))
  ;; unselect region:
  (setq point (region-beginning))
  (setq mark (point))
)
(add-hook 'html-mode-hook
	  (function
	   (lambda ()
	     (local-set-key [?\M-e] 'gdf-html-tag-region))))

(defun gdf-extract-var (var)
  "Replaces the region with a variable; inserts variable definition on the line preceding the region."
  (interactive "*sVariable name: ")
  (save-excursion
    (goto-char (region-beginning))
    (save-excursion
      (kill-region (region-beginning)(region-end)))
    (insert var)
    (beginning-of-line)
    (open-line 1)
    (insert (concat var " = " ))
    (yank)))
;;(define-key global-map '[(control \c)(control \y)] 'gdf-extract-var)
(global-set-key '[(control \c)(control \y)] 'gdf-extract-var)

;; try out rst-mode:
(autoload 'rst-mode "rst-mode" "mode for editing reStructuredText docs")

(cond ((not running-xemacs)
       ;;
       ;; Stuff for gnu emacs only here
       ;;
       
       ;; ARGH
       ;;; resize-minibuffer-mode makes the minibuffer automatically
       ;;; resize as necessary when it's too big to hold its contents
       ;; ARGH (autoload 'resize-minibuffer-mode "rsz-minibuf" nil t)
       ;(resize-minibuffer-mode nil)
       ;; ARGH (setq resize-minibuffer-window-exactly nil)

       (global-font-lock-mode t)

       ;;(load "gdf-htmlhider")

       ;; Turn off toolbars and scrollbars
      ; (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
      ; (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
       ;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

       ))

(cond (running-xemacs
       ;;
       ;; Code for any version of XEmacs/Lucid Emacs goes here
       ;;
       
       ;; turn off tool(icon)bar, scrollbars
       ;;(set-specifier menubar-visible-p nil)
       (custom-set-variables
	'(toolbar-visible-p nil)
	'(scrollbars-visible-p nil))

       (font-lock-mode t)

       ;; This changes the variable which controls the text that goes
       ;; in the top window title bar.  (However, it is not changed
       ;; unless it currently has the default value, to avoid
       ;; interfering with a -wn command line argument I may have
       ;; started emacs with.)
       (if (equal frame-title-format "%S: %b")
	   (setq frame-title-format "%b"))

       ;; note to self: lazy-lock-mode hangs xemacs frequently!

       (defun display-that-image-in-buffer (file)
	 "Puts the image contained in the file in the current buffer"
	 (interactive "f")
	 (let ((IT (make-glyph-internal)))     ;; IT, a la Stephen King
	   (set-glyph-property IT 'image file) ;; not as in ITaly
	   (make-annotation IT nil 'text)))

       )) ; (end) running-xemacs

;; make sgml-mode (xml-mode) not suck!  yay!
(add-hook 'xml-mode-hook
	  (lambda ()
	    ;; Don't use DTDs:
	    (setq sgml-warn-about-undefined-element nil)
	    ;; Effectively, indent in tags even without a DTD:
	    (set (make-local-variable 'sgml-indent-data) t)
	    (set (make-local-variable 'indent-tabs-mode) nil)
	    ))

;;	    (setq sgml-indent-data t)))

(put 'narrow-to-region 'disabled nil)

(add-hook 'sql-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (setq tab-width 2)))

;; 2005 apr 14: more types for xml-mode
(setq auto-mode-alist (cons '("\\.wsdl$" . xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xsd$" . xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xsl$" . xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xslt$" . xml-mode) auto-mode-alist))
; intellij configuration xml files:
(setq auto-mode-alist (cons '("\\.iml$" . xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ipr$" . xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.iws$" . xml-mode) auto-mode-alist))
; 2005 oct 17: Rakefiles are ruby-mode
(setq auto-mode-alist (cons '("^Rakefile" . ruby-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.svg$" . xml-mode) auto-mode-alist))

;; ARGH!  C-z is too easy to fat-finger instead of C-x C-s
(global-set-key '[(control \z)] nil)

;; Open (and modify) zipped/archived files
(auto-compression-mode 1)
; Open JAR files as ZIP archives
(setq auto-mode-alist (cons '("\\.jar$" . archive-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.war$" . archive-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ear$" . archive-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.egg$" . archive-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("^bshrc" . bsh-script-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.bsh$" . bsh-script-mode) auto-mode-alist))

(add-hook 'sh-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (setq tab-width 2)))

;(read-abbrev-file "~/.xemacs/global-abbrevs")

;;(load "gdf-elisp/gdf-ruby")