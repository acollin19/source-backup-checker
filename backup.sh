#!/bin/bash


# If the number of parameters does not equal 2, then print error message
if [ "$#" -ne 2 ];
then 
	echo Error: Expected two input parameters.
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
	exit 1

# If dir or (file and dir) dont exist or file and dir in same file, then print message
elif [[ ! -d "$1" ]] || ( [[ ! -d "$1" ]] && [[ ! -f "$2" ]]) || [[ "$1" == "$2" ]]; 
then
	echo "Error: Backup directory '/not_a_directory' does not exist."
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
	exit 2
	
# Create tar file with filename without the extension + backup date in format YYYYYMMDD
else	
       	date=$(date '+%Y%m%d')
	filename="$(basename $2)"
	tarfile="$1/$filename.$date.tar"

# If file exists, ask user if they wanna overwrite the file, and create tar file. Otherwise exit.
	if [[ -f "$tarfile" ]];
	then
	
		echo "Back up file '$tarfile' already exists. Overwrite? (y/n)"
		read answer
	        if [ "$answer" == "y" ];
		then

			tar -cf $tarfile $2
			exit 0
		else
			echo Error: File already exists. Not overwriting.
			exit 3
		
		fi

	fi
	# Tar file if else
	tar -cf $tarfile $2
fi
