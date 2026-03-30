#!/usr/bin/env pwsh

cd $env:TEMP

irm get.scoop.sh -outfile 'install.ps1'

.\install.ps1 -ScoopDir 'D:\tools\scoop' -ScoopGlobalDir 'D:\tools\scoop-global' -NoProxy
