#!/bin/bash

BC=$(which bc)
if [[ -x "$BC" ]]; then
	ord() {
		LC_CTYPE=C printf '%d' "'$1"
	}
	alphabet_pos() {
		echo $((`ord $1` - 55))
	}
	ICAN=${1//[[:blank:]]/}
	COUNTRY=${ICAN:0:2}
	CHECKSUM=${ICAN:2:2}
	BCAN=${ICAN:4}
	COUNTRYSUM=`alphabet_pos ${COUNTRY:0:1}``alphabet_pos ${COUNTRY:1}`
	OPERAND=`echo $BCAN``echo $COUNTRYSUM``echo $CHECKSUM`
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
