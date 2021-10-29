#!/bin/bash

AD_DOM="netid.washington.edu"
LEAVE_USER="installboy"
JOIN_USER="sadm_jtyocum"
OU="OU=Workstations,OU=deohs,OU=Delegated,DC=netid,DC=washington,DC=edu"
HOST_SUFFIX="clients.uw.edu"

# Leave DEOHS Domain
dsconfigad -leave -username ${LEAVE_USER}

# Update Hostname
MAC_LAST6=$(ifconfig en0|grep ether|awk '{ print $2; }'|tr -d ':'|cut -c 7-12)
HOST_NAME="deohs-ap-${MAC_LAST6}"

scutil --set HostName ${HOST_NAME}.${HOST_SUFFIX}
scutil --set ComputerName ${HOST_NAME}.${HOST_SUFFIX}
scutil --set LocalHostName ${HOST_NAME}

# Join NETID
dsconfigad -add ${AD_DOM} -computer ${HOST_NAME} -username ${JOIN_USER} -ou ${OU} -packetencrypt ssl

# Fix Home Directories
for i in (ls /Users); do
	if [ ${i} = "Shared" ]; then
		continue
	fi
	
	if [ ${i} = "ehit" ]; then
		continue
	fi
	
	chown -R ${i}:"NETID\\Domain Users" /Users/${i}
done