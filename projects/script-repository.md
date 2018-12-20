---
title: Script Repository
permalink: /work/dailyscripts
---
This [github][github-repo] repository contains the scripts that I find very useful in day to day work.
Below are a few of them. Checkout the entire [repository][github-repo] to find more such scripts.

<br>
#### 1. Checking the disk space remotely
The below code snippet can quickly monitor the disk space utilization of your server and watchout for any space issues before it causes major impact.

```posh
$computers = @("VM1","VM2")
$cred = $cred
$computers | foreach {
$computer = $_
    Try {  
        Get-WMIObject Win32_Logicaldisk -ComputerName $computer -Credential $cred
    }
    Catch {
        Write-Warning $_.Exception.Message
    }
} | Select PSComputername,
@{Name="SizeGB";Expression={$_.Size/1GB -as [int]}},
@{Name="FreeGB";Expression={[math]::Round($_.Freespace/1GB,2)}},
@{Name="%Free";Expression={($_.Freespace/$_.size).ToString("P")}} |
Sort FreeGB | 
Format-Table –AutoSize
```

<br>
#### 2. Pull Azure Key vault secrets
This script can pull all the accounts and secrets that are stored in your Azure keyvault into an Excel spread sheet. It requires the module `ImportExcel` as a pre-requisite. You can install it by running the command `Install-module ImportExcel`
```posh
Function pullSecretId
{
    $VaultName = Read-Host "Enter the Key Vault Name"  
    #Get-AzureKeyVaultSecret -VaultName $VaultName | select -Property Name, Id, Enabled | Export-Csv C:\Temp\keyVaultSecret.csv -NoTypeInformation
    Get-AzureKeyVaultSecret -VaultName $VaultName | select * | Export-Excel C:\Temp\keyVaultSecret_$VaultName.xlsx -BoldTopRow -FreezeTopRow -WorkSheetname "SecretId"
}

Function Main 
{

    $SubscriptionsList = @()
    $SubscriptionsList = ("<subId>") 

    $SubscriptionsList | foreach     {
        Try 
        {
            Select-AzureRmSubscription -SubscriptionId $_ -ErrorAction Stop
            pullSecretId
        }
        catch 
        {
            Write-Warning $_.Exception.Message
        }

    }

}
Login-AzureRmAccount
Main
``` 

<br>
#### 3. Get a list of Azure Application Insights Web tests and their status
Pre-requisite: `Install-module ImportExcel`

```posh
#Get list of all subscriptions associated with the account.
Function GetSubscription {
    $SubscriptionsList = @()
    Write-Host ("Getting the subscriptions for the account {0}..." -f $account.Context.Account.Id) -ForegroundColor Green
    $SubscriptionsList = Get-AzureRmSubscription | select -Property Name -ExpandProperty Name | sort    
    for ($i = 1; $i -le $SubscriptionsList.Count; $i++) {Write-Host ("$i. {0}" -f $SubscriptionsList[$i - 1]) -ForegroundColor Yellow}
    return $SubscriptionsList
    #SelectSubscription $SubscriptionsList
}

#Enter the subscription numbers
Function SelectSubscription ($SubscriptionsList) {   
    $value = $null    
    $value = @()    
    $value = Read-host ("`nType the Subscription line Number(s) separated by comma ',' OR type 'ALL' to select all subsciptions")
    $values = $value.split(",",[StringSplitOptions]::RemoveEmptyEntries).trim() | sort -Unique        
    return $values   
    #checkValues $values $SubscriptionsList
}

#Check if values entered are correct. Return the correct values back
Function checkValues ($values , $SubscriptionsList) {
 
    $wrongValues = $values | where {$_ -notin 1..$SubscriptionsList.Count}
    $indexOutofRange = $wrongValues.Length -ne 0
    $selectedSubscriptionsList = @()

    if ($values -eq 'All' -and $values.Count -eq 1) {
        Write-Host "Selected all Subscriptions" -ForegroundColor Green
        $selectedSubscriptionsList = $SubscriptionsList
        #getWebTest $selectedSubscriptionsList
    }      
    
    elseif ($indexOutofRange -eq $true) {
        Write-Warning "Index Out of range for one or more items. Select correct Numbers"
        Break
        #selectSubscription $SubscriptionsList
    }
    
    else {
        Try {            
            foreach ($i in $values) {$selectedSubscriptionsList += $SubscriptionsList[$i - 1]}
            Write-Host ("Selected following Subs:") -ForegroundColor Green
            $toDisplay = $selectedSubscriptionsList -join "`n"            
            Write-Host $toDisplay
            #getWebTest $selectedSubscriptionsList
        }
        Catch {
            Write-Warning $_
            Break
            #selectSubscription $SubscriptionsList
        }
    }
    return $selectedSubscriptionsList
}

#Fetch WebTest details for selected Subscriptions
Function getWebTest ($selectedSubscriptionsList) {
    Write-Host "Getting webtest details..." -ForegroundColor Green
    $webTestList = $selectedSubscriptionsList| foreach {Select-AzureRmSubscription -SubscriptionName $_ > $null; 
        Get-AzureRmResource | select -Property resourcetype, resourceid | where -property resourcetype -like "*webtest*" | select -property resourceid -ExpandProperty resourceid}

    $testStatusList = Foreach ($_ in $webTestList) {Get-AzureRmResource -ResourceId $_ }
    $testStatusList | select @{Name = "TestName"; Expression = {$_.Name}},
    @{Name = "SubscriptionId"; Expression = {$_.SubscriptionId}}, 
    @{Name = "ResourceGroupName"; Expression = {$_.ResourceGroupName}},
    @{Name = "Enabled?"; Expression = {$_.Properties.Enabled}} | Export-Excel C:/Temp/WebtestList.xlsx -BoldTopRow -FreezeTopRow
}

function Main {
    Login-AzureRmAccount
    $SubscriptionsList = GetSubscription
    $values = SelectSubscription $SubscriptionsList
    $selectedSubscriptionsList = checkValues $values $SubscriptionsList
    Write-Host $selectedSubscriptionsList -BackgroundColor DarkBlue
    getWebTest $selectedSubscriptionsList
}

Main
```

<br>
#### 4. Resolving Active Directory SID
Sometimes we just need to resolve an Active Directory SID to check who is the underlying user/group.
For example, to check the unresolved SIDs in the server administrators group, or even in a scenario where you need to validate if the user still exists in the organization.
```posh
function Resolve-SID {
    Param(
        [Parameter(Mandatory = $true,
            Position = 0)]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern("^S-\d-\d+-(\d+-){1,14}\d+$")]
        [string[]]$SID
    )

    $localObject = @()
    Foreach ($item in $SID) {
        Try {
            $objSID = New-Object System.Security.Principal.SecurityIdentifier($item) -ErrorAction stop
        }
        Catch {
            $exception = $_.Exception.Message
        }
        $objUser = $objSID.Translate([System.Security.Principal.NTAccount])
        if ($objUser.Value.Length -ne 0) {
            $FullName = $objUser.Value
        }
        else {
            $FullName = $exception
        }
        
        $localObject += New-Object PSObject -Property @{
            "Name" = $FullName;
            "SID"  = $item
        }
    }
    return $localObject
}
```

Usage: `Resolve-SID <SID Value1,SID value2,...>`

[github-repo]: https://github.com/moizhussain92/powershellscripts