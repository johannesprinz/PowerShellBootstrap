#Requires -PSEdition Core
#Requires -Modules @{ ModuleName="psake"; ModuleVersion="4.9.0"; }, @{ ModuleName="pester"; ModuleVersion="4.9.0"; }, @{ ModuleName="PSScriptAnalyzer"; ModuleVersion="1.18.3"; }
Write-Host "I can run!";
Push-Location -Path (Join-Path -Path $PSScriptRoot -ChildPath script);
Invoke-psake -docs -nologo;