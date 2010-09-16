;;; DO NOT MODIFY THIS FILE
(if (featurep 'ruby-modes-autoloads) (error "Already loaded"))

;;;### (autoloads nil "_pkg" "ruby-modes/_pkg.el")

(package-provide 'ruby-modes :version 1.02 :author-version "1.6.8" :type 'regular)

;;;***

;;;### (autoloads (run-ruby inf-ruby-keys) "inf-ruby" "ruby-modes/inf-ruby.el")

(autoload 'inf-ruby-keys "inf-ruby" "\
Set local key defs for inf-ruby in `ruby-mode'." nil nil)

(autoload 'run-ruby "inf-ruby" "\
Run an inferior Ruby process, input and output via buffer *ruby*.
If there is a process already running in `*ruby*', switch to that buffer.
With argument, allows you to edit the command line (default is value
of `ruby-program-name').  Runs the hooks `inferior-ruby-mode-hook'
\(after the `comint-mode-hook' is run).
\(Type \\[describe-mode] in the process buffer for a list of commands.)" t nil)
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))

;;;***

;;;### (autoloads (ruby-mode) "ruby-mode" "ruby-modes/ruby-mode.el")

(autoload 'ruby-mode "ruby-mode" "\
Major mode for editing ruby scripts.
\\[ruby-indent-command] properly indents subexpressions of multi-line
class, module, def, if, while, for, do, and case statements, taking
nesting into account.

The variable `ruby-indent-level' controls the amount of indentation.
\\{ruby-mode-map}" t nil)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;;;***

;;;### (autoloads (rubydb) "rubydb3x" "ruby-modes/rubydb3x.el")

(autoload 'rubydb "rubydb3x" "\
Run rubydb on program FILE in buffer *gud-FILE*.
The directory containing FILE becomes the initial working directory
and source-file directory for your debugger." t nil)

;;;***

(provide 'ruby-modes-autoloads)
