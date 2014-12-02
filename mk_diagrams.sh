#! /bin/bash

if [ $# -lt 1 ];then
	echo ERROR: I need the name of the latex file to process
	exit
fi

TmpFile=`mktemp`
TmpFile2=`mktemp`
pdflatex $@
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
pdflatex $@
fi

FileKernel=` sed -e 's!\.[^.]*$!!' <<<$@`
pdfcrop "$FileKernel".pdf
convert -density 1000 "$FileKernel-crop.pdf" "$FileKernel".png

rm -f "$TmpFile"
rm -f "$TmpFile2"
