# create symlninks to files in ~/.zsh/ from ~/.zshrc, ~/.zshenv, etc.

DOTFILES = dot-zshrc dot-zshenv

test:
	@echo make dotfiles to mess things up.

dotfiles:
	# keep var assignments in the same commandline
	pwd=`pwd` ; \
	pfx=`basename $$pwd` ; \
	for i in $(DOTFILES); do \
	  cp $$i ~/.$${i##dot-}; \
	done
	ln -s `pwd` ~/.zsh
	if [ ! -e ~/.path ]; then \
	  echo $PATH | tr : \\n > ~/.path \
	fi
	if [ ! -e ~/.classpath ]; then \
	  echo $CLASSPATH | tr : \\n > ~/.classpath \
	fi

