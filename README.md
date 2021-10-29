# README

## Windows Domain Join

### Rename Windows Desktops to NETID Compliant Names

NETID requires machine names to have our delegated prefix "DEOHS".

Create a list of non-compliant systems, and place it in C:\temp\rename_computers.txt.

Using Powershell, run: Rename_Windows_to_NETID_Compliant_Name.ps1

Review the log at c:\temp\rename_computers_log.txt. Create any needed A records for the systems.

### Migrate Windows to NETID

Machines must already have NETID compliant names, see above.

Create a list of machines to migrate, c:\temp\netid_computers.txt

Using Powershell, run: Migrate_Windows_to_NETID_v2.ps1

## Group Map

The group map, maps the DEOHS domain group name to the NETID compatible version.

  ./create_group_map.sh > group_map.DATE

In order to use the group map with the group membership sync tool, the map needs to include the NETID group prefix.

  ./reformat_group_map.sh GROUPMAP > formatted_group_map.DATE

### Creating Groups in NETID

  ./create_groups.sh

As the script runs, it'll output the HTTP status code returned from the Groups Service. In the event of a crash, or need to recover, the script maints a checkpoint file "create_groups.processed", allowing it to recover from where it left off.

### Syncing Group Members

Integrate the formatted group map, with the config file uw_groups_domain_sync/conf/groups_sync.yml.

  source /root/.venv/uwgroups/bin/activate
  cd uw_groups_domain_sync
  python3 groups_sync.py

The sync process will take a long time to run. The script has to query both the local domain, and UW Groups to determine what membership changes are needed.

As the script runs, it'll output the status of each change transaction. Large groups may be broken into multiple transactions, to improve overall reliability. 

## Changing Profile SIDs

### Dump DEOHS SIDs

Run this from a DEOHS domain controller.

  ./dump_deohs_sids.sh > deohs_sids.txt

### Get NETID SIDs

Copy the DEOHS SID dump to NETID joined Linux host.

  ./dump_netid_sids.sh > netid_sids_raw.txt
  
  ./clean_netid_sids.sh netid_sids_raw.txt > netid_sids.txt

### Update Profiles

Update the user profile SIDs.

  ./update_profile_sid.sh