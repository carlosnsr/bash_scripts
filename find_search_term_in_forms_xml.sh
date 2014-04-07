#! /bin/bash
source ~/bin/lib/bash_functions.lib

res=results
mkdir -p results

shopt -s nullglob  # so that if there are no xml files, that f does not get set to '*.xml' below

# iterate over the xml files in the current directory
for f in *.xml; do
	# find the search terms for icd9
	found="$res/found_in_$f"
	grep -i -e '[^u]pda' -e 'icd' "$f" > $found
	delete_if_empty $found "NOTE: $f does not contain the search terms"
done

