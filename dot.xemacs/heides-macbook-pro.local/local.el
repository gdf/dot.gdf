;; local settings for tofu and heides-macbook-pro

;; xxx todo tabs-not-spaces for elisp!

(cond ((not running-xemacs)
       (setq resize-mini-windows nil)

       (setq load-path (cons "~/.xemacs/elisp/gnuemacs" load-path))
       (autoload 'python-mode "python-mode" "Python editing mode" t)
       (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))

       ;; (load "haskell-mode-2.1/haskell-site-file")
       (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
       (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
       (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

       (setq frame-title-format "%b")

       ; for osx:
       ;; Old-skool light-on-dark-gray emacs colors
       ; darkslategray is #2f4f4f
       (custom-set-faces
	`(default ((t (:stipple nil
				:background "DarkSlateGray"
				:foreground "Wheat"
				:inverse-video nil
				:box nil
				:strike-through nil
				:overline nil
				:underline nil
				:slant normal
				:weight normal
				:height 116
				:width normal
				:family "apple-andale mono"))))
	`(paren-face-match-light ((t (:background "#3F4F4F"))))
	`(cursor ((t (:background "#DDEECC")))))

       (custom-set-faces
	`(paren-face-match-light ((t (:background "#DDEECC"))))
	`(cursor ((t (:background "#00FFFF")))))

       (setq mac-command-key-is-meta nil)       ; Use option for the meta key.

       )) ; (end) not running-xemacs

(cond (running-xemacs
       (set-frame-size (selected-frame) 80 70)

       ;; enable setnu-mode to get line numbers (and lots of beeping...)
       (require 'setnu)

       (gnuserv-start)
       ;;gnuserv-visit-hook
       ;(add-hook 'gnuserv-visit-hook (lambda () (set-frame-size (selected-frame) 80 70)))

       )) ; (end) running-xemacs


;;(load "gdf-elisp/gdf-ruby")

;;; Erlang mode (from lib/tools in OTP src distro)
;(setq load-path (cons "~/.xemacs/elisp/erlang" load-path))
;(setq erlang-root-dir "/usr/local")
;; (setq exec-path (cons "/usr/local/bin" exec-path))
;(require 'erlang-start)

;;; messing around with xml/sgml mode
;; (copied with minor mods from sgml-position in psgml-edit.el)
(defun xml-current-path ()
  (interactive)
  (let ((el (sgml-find-context-of (point)))
	(gis nil))
    (while (not (sgml-off-top-p el))
      (push (sgml-element-gi el) gis)
      (setq el (sgml-element-parent el)))
    (let ((path 
	   (concat "/" (mapconcat #'sgml-general-insert-case gis "/"))))
      (message "%s" path))))


