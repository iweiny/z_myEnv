#!/bin/bash

# setup the home account for this environment

# change the folowing as needed
BASE=`pwd`
files="gvimrc vimrc vim bash_profile bashrc bzaliases lscolors"

# do the work
cd $HOME


# always remove the files to clean up old env
for file in $files; do
	rm .$file
done

# if the user wants to remain clean the exit.
if [ "$1" == "uninstall" ]; then
	exit 0
fi

# install new env
for file in $files; do
	ln -s $BASE/$file .$file
done


