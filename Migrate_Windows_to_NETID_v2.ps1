#
# Script to migrate Windows Workstations from DEOHS to NETID domain
#

$computers = Get-Content c:\temp\netid_computers.txt

$old_dom_creds = Get-Credential -Message "Old Domain Credentials"
$new_dom_creds = Get-Credential -Message "New Domain Credentials"

foreach ($computer in $computers)
{
    $reboot_time = Get-Date((Get-Date).AddMinutes(30)) -UFormat '%R'
    Invoke-Command -ComputerName $computer -ScriptBlock { shutdown /r /t 300 }
    Invoke-Command -ComputerName $computer -ScriptBlock { param($reboot_time) schtasks /create /sc once /tn "reboot and domain join" /tr "shutdown /r /t 30" /ru system /st $reboot_time } -ArgumentList $reboot_time
    Invoke-Command -ComputerName $computer -ScriptBlock {
		param($old_dom_creds, $new_dom_creds)
		Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\" -Name Domain -Value clients.uw.edu
		Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\" -Name "NV Domain" -Value clients.uw.edu
		Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\" -Name SyncDomainWithMembership -Value 0
		Add-Computer –Domain netid.washington.edu –UnjoinDomainCredential $old_dom_creds –Credential $new_dom_creds
		} -ArgumentList $old_dom_creds,$new_dom_creds
}