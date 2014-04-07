#! /bin/bash
forms=( "cl931s" "cl932s" "cl934s" "cl935s" "cl936s" "cl937s" "cl939s" "lg200s" "lg300s" "lg315s" )

# Destination directories
fmbs=fmbs
xmls=xmls
res=results

mkdir -p $xmls
mkdir -p $fmbs
mkdir -p $res

for i in "${forms[@]}"; do
	# copy the file
	file="$i.fmb"
	if [ ! -e $fmbs/$file ]; then
		cp /wcis/dev/$file $fmbs/.
	fi
	
	# convert it into xml
	xml="${i}_fmb.xml"
	if [ ! -e $xmls/$xml ]; then
		/oracle/Middleware/asinst_1/bin/frmf2xml.sh $fmbs/$file
		mv $fmbs/$xml $xmls/. 
	fi
	
	# find other forms called from this file
	called_forms="$res/forms_called_from_$i"
	grep -in -e wcis_call_form -e wcis_security\.callform $xmls/$xml \
		| sed "s/\([0-9]\+\).\+wcis_security\.callform('\?\([^',)]\+\)'\?.\+/\1: \2/i" \
		| sed "s/\([0-9]\+\).\+wcis_call_form('\?\([^',)]\+\)'\?).\+/\1: \2/i" \
		| tr "[:upper:]" "[:lower:]" \
		> $called_forms
	# delete the file if it is empty
	if [ -e $called_forms -a ! -s $called_forms ]; then
		echo "$i does not call any forms"
		rm -f $called_forms
	fi
done

