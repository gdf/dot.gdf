;; local settings for orbitz laptop

(load-file "~/.xemacs/gfast/local.el")

(cond ((not running-xemacs)
       (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
       (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
       ))

