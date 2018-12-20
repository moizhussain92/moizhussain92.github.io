---
layout: project
title: Remote Admins PowerShell Module
author: Moiz
permalink: /work/RemoteAdmins
---
This [PowerShell module][PowerShell-module] module can be installed by running the command `Install-Module RemoteAdmins` in PowerShell Administrator window. It pulls the module from the [PSGallery repository][PS-Gallery]. 

The main purpose of this module is to be able to manage the administrators on the servers remotely via command line.
For Example, many organizations need to clean up users from their servers once they have left the organization or when new user access policies are implemented or there may be ad-hoc requirements to grant few users access to a number of servers. These tasks can be easily performed via command line using this module.

Below is a demostration of one of the commands `Get-RemoteAdmins -ComputerName VM1` that can be run with multiple parameters.

```posh
PS C:\WINDOWS\system32> Get-RemoteAdmins -ComputerName VM1 -Credential $cred -GroupName Administrators
VERBOSE: Resolving the Computer Name...
VERBOSE: Getting Remote Admins...

Name                               Class GroupName      ComputerName
----                               ----- ---------      ------------
Administrator                      User  Administrators VM1
Domain\Domain Admins               Group Administrators VM1
Domain\Group1                      Group Administrators VM1
Domain\Group2                      Group Administrators VM1
Domain\user1                       User  Administrators VM1
```
For more help on the commads included in this module and how to run each of those commands, use `Get-command -Module RemoteAdmins` and `Get-Help <CommandName> -ShowWindow`
```posh
PS C:\WINDOWS\system32> Get-command -Module RemoteAdmins

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Add-RemoteAdmins                                   1.0.11     RemoteAdmins
Function        Get-RemoteAdmins                                   1.0.11     RemoteAdmins
Function        Remove-RemoteAdmins                                1.0.11     RemoteAdmins
Function        Rename-RemoteGroup                                 1.0.11     RemoteAdmins
```

[PowerShell-module]: https://github.com/moizhussain92/remote-admins
[PS-Gallery]: https://www.powershellgallery.com/packages/RemoteAdmins/1.0.11


