#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILES="\
	.bashrc \
	.gitconfig \
	.tmux.conf \
	.vimrc\
	"

for f in $FILES; do
	read -p "Replace $f (y/n)? " CONT
	if [ "$CONT" = "y" ]; then
		rm ~/$f
		ln -s $DIR/$f ~/$f
	fi
done
