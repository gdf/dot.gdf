;;
;; runs rst2html, views result.
;;

(setq rst2html "rst2html.py")

(defun rst2html ()
  "Display current buffer as rst-fied HTML"
  (interactive)
  (shell-command (concat rst2html " " (buffer-file-name))
                 "*rst2html Command Output*")
  ;; from w3.el: defun w3-preview-this-buffer:
  ;;   (w3-fetch (concat "www://preview/" (buffer-name))))
  (w3-fetch (concat "www://preview/" "*rst2html Command Output*"))
  )
