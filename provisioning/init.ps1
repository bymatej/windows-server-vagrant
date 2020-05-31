### PROVISIONING SCRIPT


## SET NETWORK LOCATION TO PRIVATE

# Skip network location setting if local machine is joined to a domain.
if(1,3,4,5 -contains (Get-WmiObject win32_computersystem).DomainRole) { return }

# Get network connections
$networkListManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))
$connections = $networkListManager.GetNetworkConnections()

# Set network location to Private for all networks
$connections | % {$_.GetNetwork().SetCategory(1)}

## Source: https://devblogs.microsoft.com/powershell/setting-network-location-to-private/


## ENABLE REMOTE DESKTOP

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1

## Source: https://theitbros.com/how-to-remotely-enable-remote-desktop-using-powershell/
