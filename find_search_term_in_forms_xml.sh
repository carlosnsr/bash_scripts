#! /bin/bash

res=results
mkdir -p results

shopt -s nullglob  # so that if there are no xml files, that f does not get set to '*.xml' below

# iterate over the xml files in the current directory
for f in *.xml; do
	# find the search terms for icd9
	found="$res/found_in_$f"
	grep -i -e '[^u]pda' -e 'icd' "$f" > $found
	
	# delete the file if it is empty
	if [ -e $found -a ! -s $found ]; then
		echo "$f does not contain the search terms"
		rm -f $found
	fi
done

