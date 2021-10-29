#!/bin/bash

for user in $(cat deohs_sids.txt); do
	USERNAME=$(echo ${user} | cut -d":" -f1)
	echo "${USERNAME}:$(wbinfo -n "netid\\${USERNAME}" | awk -e '{ print $1 }')"
done
