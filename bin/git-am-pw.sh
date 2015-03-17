#!/bin/sh

wget_git_file=/tmp/wget-git-am-file

patch=$1

echo ""
echo ""
echo "getting : $patch"
echo ""
echo ""

rm $wget_git_file
wget -O $wget_git_file $patch
git am $wget_git_file
rm $wget_git_file

