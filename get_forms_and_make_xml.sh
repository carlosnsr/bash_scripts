#! /bin/bash
source ~/bin/lib/bash_functions.lib

# forms=( "cl933s" )  # starting point
# forms=( "cl931s" "cl932s" "cl934s" "cl935s" "cl936s" "cl937s" "cl939s" "lg200s" "lg300s" "lg315s" )  # first pass
forms=( "lg210s" "lg220s" "lg230s" "lg260s" )  # second pass

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
	delete_if_empty $called_forms
done

