#! /bin/bash

test="List ENTSVR SMB File Shares from ENTWKS client"
host="entfile.example.net"
user="alice"
pass="Vagrant!234"
cmd="smbclient -L //${host} -U ${user}%${pass}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]	CIFS	ENTWKS	${test}	${0}"
else
        echo -e "[F]	CIFS	ENTWKS	${test}	${0}"
fi

