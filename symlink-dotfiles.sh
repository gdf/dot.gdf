#!/bin/bash

for i in dot.*; do
  target=$HOME/.${i##dot.}
  if [ -e $target ]; then
    echo "$target already exists, skipping"
  else
    echo $target
    ln -s `pwd`/$i $target
  fi
done

