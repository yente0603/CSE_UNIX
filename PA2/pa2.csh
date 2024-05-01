#!/usr/bin/tcsh
echo
echo Echo echoed, '"'You said, "'$*'".'"'
echo
echo | sed -n "iSed's "'"i"'" said, "'"You said, '"'$*'"'."'
echo
echo $*:q | sed "s/.*/Sed's "'"s"'" said, "'"You said, '"'&'"'."/'
echo
echo $*:q | sed "iSed's "'"i" and "a" said, "You said, '"'""\
		 a'."'"'\
		|tr -d "\n"; echo
echo
echo $*:q | sed "x;s/.*/Sed's hold space was used to say, "'"You said, '"'/;G;s/\n//;x;s/.*/'."'"'"/;x;G;s/\n//"
echo
