#!/bin/bash
samba-tool group list|grep -v " "|egrep -v "(Administrators|DnsAdmins|DnsUpdateProxy|Guests|IIS_IUSRS|Replicator|SophosDomainAdministrator|SophosDomainPowerUser|SophosDomainUser|Users)"
