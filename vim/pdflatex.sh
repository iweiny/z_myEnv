#!/bin/sh

# Get the absolte path of the file.
file=$1
dirname=`dirname $file`
basename=`basename $file`
cd $dirname
dirname=`pwd`
file=$dirname/$basename

TEXINPUTS=$TEXINPUTS:$dirname

echo "$TEXINPUTS"

rm -f /tmp/*.aux
rm -f /tmp/*.log
rm -f /tmp/*.pdf
pushd /tmp
pdflatex $file
if [ "$?" != "0" ]; then
   popd
   exit 1
fi
popd


# Get the absolte path of the file.
outfile=$2
outdirname=`dirname $outfile`
outbasename=`basename $outfile`
cd $dirname
outdirname=`pwd`
outfile=$outdirname/$outbasename

mv /tmp/$outbasename $outfile

gv $outfile &

#if [ "$2" != "" ]; then
#   cp /tmp/tmp.vim.pdf $outfile
#else
#   cp /tmp/tmp.vim.pdf $basename.pdf
#fi

# clean up
#rm -f /tmp/tmp.vim.*


