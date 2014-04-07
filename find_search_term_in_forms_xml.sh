#! /bin/bash

shopt -s nullglob  # so that if there are no xml files, that f does not get set to '*.xml' below

# iterate over the xml files in the current directory
for f in *.xml; do
	echo $f
done

