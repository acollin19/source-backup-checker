#!/bin/bash

#3 If script does not take in two parameters print message
if [ "$#" -ne 2 ];
then
        echo Error: Expected two input parameters.
        echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
        exit 1

# Check if they're in the same directories
elif [ "$1" == "$2" ];
then
	exit 2

#4 Script checking if first parameter is a directory 
elif [ ! -d "$1" ];
then
        echo "Error: Input parameter #2 '$1' is not directory."
        echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
        exit 2

#4 Script checking if second parameter is a directory
elif [ ! -d "$2" ];
then
	echo "Error: Input parameter #2 '$2' is not a directory."
        echo "Usage: ./srcdiff.sh <orginaldirectory> <comparisondirectory>"
        exit 2

#5 Checking for differences in directories and output just the difference. Check if its empty	
else
	iterate=$(diff -q $1 $2)
        if [ -z "$iterate" ];
	then
		exit 0	
	else
# Substitutes certain lines to match output
		
		diff -q $1 $2 | awk '{print $2,$3,$4,$5}' | sed -e 's/differ/differs./' -e 's/^in.*/&is missing/' -e 's/.*and //' -e 's/: /\//' -e 's/in //'

		exit 3

	fi
fi
