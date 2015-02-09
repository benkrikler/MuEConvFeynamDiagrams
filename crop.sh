#! /bin/bash

state=0
sed -e 's!\\!\\\\!g' /dev/stdin | while read line;do
	#echo BEN: $line
	#od -c <<< "$line" 
	if [ "$state" -eq 0 ] && `grep 'begin{document}'  <<< $line &> /dev/null`; then 
		state=1
		#echo Change state
	elif [ "$state" -eq 1 ]; then
	       if `grep 'end{document}' <<< "$line" &> /dev/null`;then state=2; exit 0;fi
	       echo $line
	       #od -c <<< "$line" 
	fi
done
