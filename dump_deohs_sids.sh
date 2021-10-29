#!/bin/bash

DOMUSERS=$(wbinfo -u)

for user in ${DOMUSERS}; do
	SID=$(wbinfo -n "${user}"|awk -e '{ print $1 }')
	echo "$(echo -n ${user} | cut -d'\' -f2):${SID}"
done
