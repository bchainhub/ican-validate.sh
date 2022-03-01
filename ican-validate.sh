#!/bin/bash

BC=$(which bc)
if [[ -x "$BC" ]]; then
	ord() {
		LC_CTYPE=C printf '%d' "'$1"
	}
	alphabet_pos() {
		if [ -n "$1" ] && [ "$1" -eq "$1" ] 2>/dev/null; then
			echo $1
		else
			UPPER=$(echo "$1" | tr '[:lower:]' '[:upper:]')
			echo $((`ord $UPPER` - 55))
		fi
	}
	ICAN=${1//[[:blank:]]/}
	COUNTRY=${ICAN:0:2}
	CHECKSUM=${ICAN:2:2}
	BCAN=${ICAN:4}
	BCCO=`echo $BCAN``echo $COUNTRY`
	for ((i=0; i<${#BCCO}; i++)); do
		SUM+=`alphabet_pos ${BCCO:$i:1}`
	done
	OPERAND=`echo $SUM``echo $CHECKSUM`
	if [[ `echo "$OPERAND % 97" | $BC` -eq 1 ]]; then
		echo "Valid ICAN."
		exit 0
	else
		echo "Invalid ICAN!"
		exit 1
	fi
else
	echo "'bc' not found!"
	exit 2
fi
