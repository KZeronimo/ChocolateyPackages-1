﻿$ErrorActionPreference = 'Stop'
$packageName = 'choco-package-deprecater'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"
$script      = 'cdeprecate.ps1'

# Setup
# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$ENV:ChocolateyToolsLocation\BCURRAN3")) { New-Item -Path "$ENV:ChocolateyToolsLocation" -Name "BCURRAN3" -ItemType "directory" | Out-Null }

# Install
# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force
Install-ChocolateyPowershellCommand -PackageName 'cdeprecate' -PSFileFullPath "$scriptDir\$script"
if (!(Test-Path "$scriptDir\cdeprecate.config")) {Move-Item "$toolsDir\cdeprecate.config" "$scriptDir" -Force} else {Remove-Item "$toolsDir\cdeprecate.config" | Out-Null}

# Cleanup
if ($ENV:Path -NotMatch "BCURRAN3"){ Install-ChocolateyPath "$scriptDir" "Machine" ; refreshenv }
