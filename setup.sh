#!/bin/bash

# setup the home account for this environment

# change the folowing as needed
BASE=`pwd`
files="gvimrc vimrc vim bash_profile bashrc bzaliases lscolors screenrc gitconfig"

# do the work
cd $HOME


# always remove the files to clean up old env
for file in $files; do
	rm .$file
done

# if the user wants to remain clean then exit.
if [ "$1" == "uninstall" ]; then
	exit 0
fi

# link new env
for file in $files; do
	ln -s $BASE/$file .$file
done

if [ ! -d ./bin ]; then
	mkdir ./bin
fi

# link bin files
for file in $BASE/bin/*; do
	ln -s $file ./bin
done

# set up rpmbuilds in my home dir
if [ ! -d ~/rpmbuild ]; then
	mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
	echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros
fi

