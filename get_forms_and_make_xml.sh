#! /bin/bash
forms=( "cl931s" "cl932s" "cl934s" "cl935s" "cl936s" "cl937s" "cl939s" "lg200s" "lg300s" "lg315s" )

for i in "${forms[@]}"; do
	# copy the file
	file="$i.fmb"
	if [ ! -e $file ]; then
		cp /wcis/dev/$file .
	fi
	
	# convert it into xml
	xml="${i}_fmb.xml"
	if [ ! -e $xml ]; then
		/oracle/Middleware/asinst_1/bin/frmf2xml.sh $file
	fi
	
	# find other forms called from this file
	grep -in -e wcis_call_form -e wcis_security\.callform $xml \
		| sed "s/\([0-9]\+\).\+wcis_security\.callform('\?\([^',)]\+\)'\?.\+/\1: \2/i" \
		| sed "s/\([0-9]\+\).\+wcis_call_form('\?\([^',)]\+\)'\?).\+/\1: \2/i" 
		> forms_called_from_$i 
done

