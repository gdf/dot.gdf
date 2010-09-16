#!/bin/zsh
#
# Utility functions for dotfiles.
# Sourcing this shouldn't do anything destructive!
#

if [ -z "$HOSTNAME" ]; then 
  export HOSTNAME=`hostname`
fi

#
# Sources the given file and any host-specific versions
# of it.
# Eg: given file zshenv and host cken, this will:
#  - First source zshenv, if it exists.
#  - Second source zshenv-cken, if it exists, or else
#    - source zshenv-default, if it exists.
hosty_source() {
  local -r file=$1
  if [ -e "$file" ]; then
    . "$file"
  fi
  if [ -e "$file-$HOSTNAME" ]; then
    . "${file}-${HOSTNAME}"
  elif [ -e "${file}-default" ]; then
    . "${file}-default"
  fi
}
