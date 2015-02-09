#! /bin/bash

if [ $# -lt 1 ];then
	echo ERROR: I need the name of the latex file to process
	exit 2
fi

if [ -e current.tex && ! -h current.tex ];then 
	echo ERROR: current.tex is a real file, not a symbolic link :-s
	exit 1
fi
rm -f current.tex
ln -sf "$1" current.tex

InFile="preamble.tex"

TmpFile=`mktemp`
TmpFile2=`mktemp`
pdflatex "$InFile"
find . -newer "$TmpFile" -name '*.mp' -type f -print > "$TmpFile2"
Lines="`wc -l $TmpFile2|cut -f1 -d' '`"
if [ "$Lines" -gt 0 ];then
	set -e
cat "$TmpFile2" |while read line; do
echo
echo Run mg for: $line
	mpost $line;
done
echo
echo Run pdflatex again
pdflatex  "$InFile"
fi

FileKernel=` sed -e 's!\.[^.]*$!!' <<< "$InFile"`
OutFileKernel=` sed -e 's!\.[^.]*$!!' <<< "$1"`
pdfcrop "$FileKernel".pdf
convert -density 1000 "$FileKernel-crop.pdf" "$OutFileKernel".png

rm -f "$TmpFile"
rm -f "$TmpFile2"
