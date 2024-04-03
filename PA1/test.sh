#!/usr/bin/tcsh
source colors

# If colors aren't printing, try uncommenting this line:
# set Macintosh

# The following lines are the same as colorechousingswitch (and are explained there):
if ( $?Macintosh ) then
    alias eco '(printf "%b " \!:*)|rev|cut -c2-|rev'
    echo -n eco\  > echoline
else
    echo -n echo\  > echoline
endif

foreach i (`seq 1 $#argv`)
    set arg = $argv[$i]
    if ( "$arg" == "-" ) then
        echo -n - >> echoline
    else if ( "$arg" == "-n" ) then
        (echo -n -; echo n) >>& echoline
    else if ( "$arg" !~ -[roygbpcmwy]* && "$arg" !~ --* ) then
        echo $arg >> echoline
    else
        set newarg = `echo "$arg" | sed 's/-//g'`
        
        if ( "$newarg" =~ [lbd][brycgmopw]* && "$newarg" !~ bro* && "$newarg" !~ bri* ) then
            set firstChar = `echo $newarg | cut -c1`
            if ( "$firstChar" == "l" ) then
                set adjective = "light"
            else if ( "$firstChar" == "b" ) then
                set adjective = "bright"
            else if ( "$firstChar" == "d" ) then
                set adjective = "dark"
            endif
            
            set letters = `echo $newarg | sed 's/^.//'`
            set newarg = `echo "$adjective$letters" | tr -d ' '`
        endif
        
        if ( $newarg =~ "*r" ) set newarg  = ${newarg}ed
        if ( $newarg =~ "*o" ) set newarg  = ${newarg}range
        if ( $newarg =~ "*y" && $newarg !~ "*[ae]y" ) set newarg  = ${newarg}ellow
        if ( $newarg =~ "*g" ) set newarg  = ${newarg}reen
        if ( $newarg =~ "*b" ) set newarg  = ${newarg}lue
        if ( $newarg =~ "*p" ) set newarg  = ${newarg}urple
        if ( $newarg =~ "*c" ) set newarg  = ${newarg}yan
        if ( $newarg =~ "*m" ) set newarg  = ${newarg}agenta
        if ( $newarg =~ "*w" && $newarg !~ "*ow" ) set newarg  = ${newarg}hite
        if ( $newarg == "pink" ) set newarg  = "pink"
        if ( $newarg == "brown" ) set newarg  = "brown"
        
        # Synonyms replacement using `tr` and `cut`
        if ("$newarg" == "lightwhite") then
            set newarg = "white"
        else if ("$newarg" =~ *grey* ) then
            set newarg = `echo "$newarg" | tr 'e' 'a'`
        else if ("$newarg" =~ .*magenta* && "$newarg" !~ dark* && "$newarg" !~ light* && "$newarg" !~ bright*) then
            set newarg = `echo "$newarg" | cut -d'm' -f1`"purple"
        endif
        
        echo -n '"$'$newarg'"'\ >> echoline
        continue
    endif
    
    if ( $i != $#argv ) then
        echo -n " " >> echoline
    endif
end

source echoline
cat echoline | cut -d\  --complement -f1 >> colorechoout; rm -f echoline
echo -n "$reset"