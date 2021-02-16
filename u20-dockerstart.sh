#!/bin/bash

# Start RPCbind
/usr/sbin/service rpcbind start
status=$?
if [ $status -ne 0 ]; then
     echo "Failed to start rpcbind: $status"
fi

# Start SSHD
/usr/sbin/sshd -D
status=$?
if [ $status -ne 0 ]; then
     echo "Failed to start sshd: $status"
     exit $status
fi

