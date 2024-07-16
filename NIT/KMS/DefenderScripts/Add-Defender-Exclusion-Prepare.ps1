<#
.SYNOPSIS
    This Script will Prepare KMS Activation Tool
    for Windows 10/11 and Windows Server 2012+
    with Activated Microsoft Windows Defender Antivirus
    The Script must be Run with Elevated Privileges.
.DESCRIPTION
    This Script will Prepare KMS Activation Tool
.NOTES
    File name: Add-Defender-Exclusion-Prepare.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-02-21
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-02-21) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

### Set a Variables
#
$BINDIR="C:\.BIN"
$PUB1DIR="C:\pub1"
$UTIL = "C:\Util"
$DownloadPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$MyDocumentsPath = [System.Environment]::GetFolderPath(5)
$MyDesktopPath = (New-Object -ComObject Shell.Application).namespace(0x10).Self.Path

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Hidden -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

#### Add Antivirus Exclusions
#
Add-MpPreference -ExclusionPath $BINDIR -Force
Add-MpPreference -ExclusionPath $PUB1DIR -Force
Add-MpPreference -ExclusionPath $UTIL -Force
Add-MpPreference -ExclusionPath $DownloadPath -Force
Add-MpPreference -ExclusionPath $MyDocumentsPath -Force
Add-MpPreference -ExclusionPath $MyDesktopPath -Force

Exit 0


# SIG # Begin signature block
# MIIJdQYJKoZIhvcNAQcCoIIJZjCCCWICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUI8Rt7K7E5DTq7iYYsbMjYFFm
# dsOgggcSMIIDNTCCAqKgAwIBAgIQmRZ8sJ6WnpBM/gOYGjGCZjAJBgUrDgMCHQUA
# MIGfMSMwIQYDVQQDExpOSVQgQ2xhc3MgMyBFViBTU0wgQ0EgLSBHNDEwMC4GA1UE
# CxMnTmV3IEludGVybmV0IFRlY2hub2xvZ2llcyBUcnVzdCBOZXR3b3JrMScwJQYD
# VQQKEx5OZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIEluYy4xEDAOBgNVBAcTB1Nh
# cmF0b3YxCzAJBgNVBAYTAlJVMCAXDTIwMDcyMDA2Mjg0N1oYDzIxMjAwNzIwMDYy
# ODQ2WjApMScwJQYDVQQDEx5OZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIEluYy4w
# gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANDUnk8zGlTyF8GCxB1aULuNpIjq
# DKg5dT2UjOWrxOHgQiYlrqEjC1GPUCwjsS01OgVjv2Z9ukanCPm84m4vhw5AI3oA
# fWQVDV2y88VwicxqyQdBsjhtujZJ2Syw8RgEelGfGaW4KkCffdDaiYTh8Oo2Q/9h
# M4kGar3uvgrxYgBxAgMBAAGjgewwgekwDwYDVR0TAQH/BAUwAwIBBTAgBgNVHQQB
# Af8EFjAUMA4wDAYKKwYBBAGCNwIBFgMCB4AwMAYKKwYBBAGCNwIBCgQiMCCgHoAc
# aHR0cDovL2FudGljcmltaW5hbG9ubGluZS5ydTAdBgNVHSUEFjAUBggrBgEFBQcD
# AwYIKoUDBQEYAg8wYwYDVR0BBFwwWoAQZ+32JfGWOlxSybCD2PIbaaE0MDIxMDAu
# BgNVBAMTJ1ZlcmlTaWduIENsYXNzIDMgQ29kZSBTaWduaW5nIDIwMjAtMiBDQYIQ
# iC3lDQIjxYZJIDHHKQxk/jAJBgUrDgMCHQUAA4GBAKX+PIfzdDJQSsudzSjT/yBb
# MS/GVjrjGY176sQTsHbjf9ggNQIZkEg4pKBynOj20wKBjVobQW4wgGxv5UvgL/Xs
# hPKE58wDL1+9D1teEEtYntdn8z7WzZC2Rm77mZV+yd+ZabUXi9Ym7VezmHfWrned
# H2P0GNuIEpH6mkYUOUBDMIID1TCCAsGgAwIBAgIQiC3lDQIjxYZJIDHHKQxk/jAJ
# BgUrDgMCHQUAMDIxMDAuBgNVBAMTJ1ZlcmlTaWduIENsYXNzIDMgQ29kZSBTaWdu
# aW5nIDIwMjAtMiBDQTAgFw0yMDA3MjAwNjI3MzVaGA8yMTIwMDcyMDA2MjczNFow
# gZ8xIzAhBgNVBAMTGk5JVCBDbGFzcyAzIEVWIFNTTCBDQSAtIEc0MTAwLgYDVQQL
# EydOZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIFRydXN0IE5ldHdvcmsxJzAlBgNV
# BAoTHk5ldyBJbnRlcm5ldCBUZWNobm9sb2dpZXMgSW5jLjEQMA4GA1UEBxMHU2Fy
# YXRvdjELMAkGA1UEBhMCUlUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAKdX
# 5yJUtXxNKgy5yTse+hEHiWu1VgvRpWAiuoeS03A3Id7uwU/1evXXUSDkl293DkJ9
# 8TDUOl2tOSe9K6CyH62Ea0kRaAWloaO6wH60hjH1LIOR0Xu8v/gj/qTXQEShtZt7
# 2I4zMLC67u/yncy5ZtnTkKfljEYssOmiJIqiAx4dAgMBAAGjggEBMIH+MBIGA1Ud
# EwEB/wQIMAYBAf8CAQUwIAYDVR0EAQH/BBYwFDAOMAwGCisGAQQBgjcCARYDAgeA
# MDAGCisGAQQBgjcCAQoEIjAgoB6AHGh0dHA6Ly9hbnRpY3JpbWluYWxvbmxpbmUu
# cnUwOwYDVR0lBDQwMgYIKwYBBQUHAwEGCCsGAQUFBwMCBggrBgEFBQcDAwYIKwYB
# BQUHAwQGCCqFAwUBGAIPMFcGA1UdAQRQME6AEHiV66FUatLJmUqI8CyehfChNDAy
# MTAwLgYDVQQDEydWZXJpU2lnbiBDbGFzcyAzIENvZGUgU2lnbmluZyAyMDIwLTIg
# Q0GCBLIuGUUwCQYFKw4DAh0FAAOCAQEAAc2GsrnY7lhqifgBxWvKAo909Ag0CE+L
# hjqINvw+dd1krEmWgyGAsCGvYUYI5t5aQ/+6wYMQc5hV3az+c7f79z4Zqy+HBlFM
# F0cwB7kSiyJ5LL9vsN4krXku1GLWbtUINgcYGBkzZEDzm2F0hGjxILH6uD7skZ3p
# EIxJinJezmSZz9dkvkGMRGuy17TT1Mm4j+ggRrRWk24+bLJ2Q9zFJTIdoxeJ6iz7
# G6z+7g718x7rplcYMZaGejv1rT8te62ZHHPvIKaekZ69JX2Om8uFcjUAgzBO06RR
# 6ATm3W4X3QUXiy6hfOHZUVvSjQQ0XxYnyYS/IOaJUtAf6lj+ZnY5fzGCAc0wggHJ
# AgEBMIG0MIGfMSMwIQYDVQQDExpOSVQgQ2xhc3MgMyBFViBTU0wgQ0EgLSBHNDEw
# MC4GA1UECxMnTmV3IEludGVybmV0IFRlY2hub2xvZ2llcyBUcnVzdCBOZXR3b3Jr
# MScwJQYDVQQKEx5OZXcgSW50ZXJuZXQgVGVjaG5vbG9naWVzIEluYy4xEDAOBgNV
# BAcTB1NhcmF0b3YxCzAJBgNVBAYTAlJVAhCZFnywnpaekEz+A5gaMYJmMAkGBSsO
# AwIaBQCgcDAQBgorBgEEAYI3AgEMMQIwADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFjAjBgkqhkiG9w0BCQQx
# FgQU2S9cBlvjcSUf++XfBT7yBFj8EMwwDQYJKoZIhvcNAQEBBQAEgYB2k+I1YTlR
# 9gWHdLbEAMbZEnInRwI7/a6UouOdc+EVfRHzO0nJVc5fLWBrcxA+DOpz75UfnkVX
# ralsxTTlKSZ53TCux16V/GSuiFzeTbQpQM77iBburOrwXwUw1iSxr6dhl1Ps0hfT
# rG5Gbtw35xllgmtRDQUS/oBdTfy2IvA8sQ==
# SIG # End signature block
