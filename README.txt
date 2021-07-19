# Group Map

The group map, maps the DEOHS domain group name to the NETID compatible version.

  ./create_group_map.sh > group_map.DATE

In order to use the group map with the group membership sync tool, the map needs to include the NETID group prefix.

  ./reformat_group_map.sh GROUPMAP > formatted_group_map.DATE

# Creating Groups in NETID

  ./create_groups.sh

As the script runs, it'll output the HTTP status code returned from the Groups Service. In the event of a crash, or need to recover, the script maints a checkpoint file "create_groups.processed", allowing it to recover from where it left off.

# Syncing Group Members

Integrate the formatted group map, with the config file uw_groups_domain_sync/conf/groups_sync.yml.

  source /root/.venv/uwgroups/bin/activate
  cd uw_groups_domain_sync
  python3 groups_sync.py

The sync process will take a long time to run. The script has to query both the local domain, and UW Groups to determine what membership changes are needed.

As the script runs, it'll output the status of each change transaction. Large groups may be broken into multiple transactions, to improve overall reliability. 
