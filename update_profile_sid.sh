#!/bin/bash

for user in $(cat netid_sids.txt); do
	USERNAME=$(echo ${user} | cut -d":" -f1)
	NEWSID=$(echo ${user} | cut -d":" -f2)
	OLDSID=$(grep "^${USERNAME}:" deohs_sids.txt | cut -d":" -f2)
	if [ -d /profiles/${USERNAME}.V6/]; then
		cd /profiles/${USERNAME}.V6/
		profiles -c ${OLDSID} -n ${NEWSID} NTUSER.DAT
		mv NTUSER.DAT.new NTUSER.DAT
		chown ${USERNAME} NTUSER.DAT
	fi
done
