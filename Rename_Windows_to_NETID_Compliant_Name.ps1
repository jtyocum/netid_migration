$computers = Get-Content c:\temp\rename_computers.txt

$old_dom_creds = Get-Credential -Message "Old Domain Credentials"

foreach ($computer in $computers)
{
	$mac = (Invoke-Command -ComputerName $computer -ScriptBlock { (Get-NetAdapter -Name Ethernet | select MacAddress).MacAddress.Remove(0, 9) -replace '[-]','' })
	$new_name = 'deohs-de-' + $mac
    Invoke-Command -ComputerName $computer -ScriptBlock { shutdown /r /t 300 }
    Rename-Computer -ComputerName $computer -NewName $new_name -DomainCredential $old_dom_creds
	$computer + ':' + $new_name | Add-Content c:\temp\rename_computers_log.txt
}