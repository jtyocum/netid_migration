#!/bin/bash

DOMGRPS=$(./get_formatted_groups.sh)

PROCESSED=create_groups.processed

source /root/.venv/uwgroups/bin/activate

touch ${PROCESSED}

for grp in ${DOMGRPS}; do
	if ! grep -F -x -q ${grp} ${PROCESSED}; then
		python3 ./uw_groups_create_group/groups_create_group.py uw_sph_deohs_netid_${grp} uw_sph_deohs_groupadmins
		echo ${grp} >> ${PROCESSED}
		sleep 2
	fi
done
