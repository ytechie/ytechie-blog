Rest API: http://msdn.microsoft.com/en-us/library/windowsazure/ee460799.aspx
PowerShell: http://msdn.microsoft.com/en-us/library/windowsazure/jj156055.aspx
- Look at the Windows Azure Management Cmdlets section

#open "powershell ise"

cd "C:\Users\jayoung\SkyDrive @ Microsoft 1\2013-11-22 Avocet PowerShell"
./runme.ps1

#run this as administrator to allow script execution
set-executionpolicy remotesigned

#install azure powershell cmdlets
http://go.microsoft.com/fwlink/p/?linkid=320376&clcid=0x409

#set up PoserShell ISE
Import-Module 'C:\Program Files (x86)\Microsoft SDKs\Windows Azure\PowerShell\Azure\Azure.psd1'

#download your publish setting file:
https://windows.azure.com/download/publishprofile.aspx

import-azurepublishsettingsfile *whatever*

help azure

help get-azureaccount

get-azuresubscription -current
get-azuresubscription

#powershell ISE trick:
get-azuresubscription | Out-GridView

new-azureaffinitygroup Avocet -Location "East US"

#case matters with storage, but the error is not useful
#these commands are synchronous (blocking)
new-azurestorageaccount -storageaccountname "avocetstorage01" -AffinityGroup "Avocet"

Select-AzureSubscription -SubscriptionName "ShareshiftSubscription"
set-azuresubscription -subscriptionname "ShareshiftSubscription" -currentstorageaccount "avocetstorage01"

#list all vm's
get-azurevmimage
get-azurevmimage | select label
get-azurevmimage | where label -eq "Windows Server 2012 R2 Datacenter"

#only specify an affinity group for the first VM in the cloud service
New-AzureQuickVM -Windows -AdminUsername testadmin -ImageName "a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201310.01-en.us-127GB.vhd" -Password password123! -ServiceName Avocet -Name "Avocet1" -AffinityGroup "Avocet"

#cheaters way to get remoting working (for the cert)
http://fabriccontroller.net/blog/posts/using-remote-powershell-with-windows-azure-virtual-machines/

#Powershell Remoting Instructions for scripting
michaelwasham.com/2013/04/16/windows-azure-powershell-updates-for-iaas-ga/

Get-AzureWinRMUri -ServiceName Avocet -Name Avocet1
InstallWinRMCert Avocet Avocet1

Enter-PSSession -ComputerName avocet.cloudapp.net -Port 61888 -Credential testadmin -UseSSL