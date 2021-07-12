#!/bin/bash
# Start the printer process
# treed Sun 13 Jun 2021 01:34:16 PM EDT


python3 /usr/local/tinyprinter/python-paperang/littleprinter.py &
program_1_pid=$!
printer_file="${HOME}/my-printer.printer"

trap onexit INT
function onexit() {
	kill -9 $program_1_pid
	exit 1
}
sleep 10

if test ! -f ${printer_file} ; then
	echo "Can't find ${printer_file}" >&2
	exit 1
fi

while test 1 -eq 1 ; do
	( cd /usr/local/tinyprinter/sirius-client 
	yarn ts-node bin/client.ts run --uri wss://littleprinter.nordprojects.co/api/v1/connection -p ${printer_file} -d filesystem
	)
	sleep 5
done

kill -9 $program_1_pid

exit 0

