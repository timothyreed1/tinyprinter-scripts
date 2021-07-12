#!/bin/bash
# Print BTC price and weather to my printer
# treed Mon Jun  1 23:38:12 EDT 2020

BHEADER=""
BVALUE=""
CONTENT=""
USAGE="$0 -[bewW]"
APPSTATUS=NONE
PATH="${PATH}:/usr/local/tinyprinter/bin"

for x in $* ; do
	case $x in 
	-b ) # BTC PRICE
		BHEADER="BTC/USD @ `date +%m/%d/%y`"
		BVALUE="`curl -s http://api.coindesk.com/v1/bpi/currentprice.json | python -c "import json, sys ; print(json.load(sys.stdin)['bpi']['USD']['rate'])"`"
		CONTENT="${CONTENT}<h4>${BHEADER}</h4><p>${BVALUE}</p>"
		APPSTATUS=OK
		;;
	-w ) # CURRENT WEATHER IN NYC
		WHEADER="Current Weather"
		WVALUE="`curl wttr.in?format=\"%l:+%C+%t\"`"
		CONTENT="${CONTENT}<h4>$WHEADER</h4><p>$WVALUE</p>"
		APPSTATUS=OK
		;;
	-W ) # CURRENT WEATHER IN NYC
		WHEADER="Current Weather in NYC"
		WVALUE=""
		CONTENT="${CONTENT}<h4>$WHEADER</h4>"
		IFS=$'\n'
		for x in `read-weather.py` ; do
			WVALUE="${WVALUE}<p>${x}</p>"
		done
		CONTENT="${CONTENT}<p>${WVALUE}</p>"
		APPSTATUS=OK
		;;
	--h* ) echo "$USAGE" ; exit 0
		;;
	esac
done

if [ "${APPSTATUS}" = "OK" ] ; then
	eval curl \'https://device.li/uoy1p4t83nrbmf8wv6wu?from=AM_NEWS\' -H \'content-type: application/json\' -d \'{\"html\":\"$CONTENT\"}\'
	exit $?
else
	echo "USAGE: $USAGE" >&2
	exit 1
fi
