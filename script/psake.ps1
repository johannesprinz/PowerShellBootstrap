#Requires -RunAsAdministrator
#Requires -Version 4

function Test-Module($Name, $MinimumVersion){
	$null -ne (Get-Module -ListAvailable -Name $Name |
	Where-Object {
		 $null -eq $MinimumVersion -or
		 [System.Version]::Parse($MinimumVersion) -le $_.Version
	});
}

function Import-DependantModule(){
	$dependantModules = @{
		NuGet = @{Name="NuGet"; MinimumVersion="2.8.5.208";};
		PowerShellGet = @{Name="PowerShellGet"; MinimumVersion="1.1.3.1";};
		PackageManagement = @{Name="PackageManagement"; MinimumVersion="1.1.4.0";};
	}
	if(-not (Get-PackageProvider -Name $dependantModules.NuGet.Name)){
		Install-PackageProvider -Name $dependantModules.NuGet.Name -MinimumVersion $dependantModules.NuGet.MinimumVersion -Force
	}
	if(-not (Test-Module -Name $dependantModules.PackageManagement.Name -MinimumVersion $dependantModules.PackageManagement.MinimumVersion)){
			Install-Module -Name $dependantModules.PackageManagement.Name -MinimumVersion $dependantModules.PackageManagement.MinimumVersion -Scope CurrentUser -Force -SkipPublisherCheck -AllowClobber;
	}
	if(-not (Test-Module -Name $dependantModules.PowerShellGet.Name -MinimumVersion $dependantModules.PowerShellGet.MinimumVersion)){
			Install-Module -Name $dependantModules.PowerShellGet.Name -MinimumVersion $dependantModules.PowerShellGet.MinimumVersion -Scope CurrentUser -Force -AllowClobber;
			Remove-Module -Name $dependantModules.PowerShellGet.Name;
			Import-Module -Name  $dependantModules.PowerShellGet.Name;
	}
	if(-not (Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue)){
		Register-PSRepository -Name PSGallery -SourceLocation https://www.powershellgallery.com/api/v2;
	}
}
function Import-RequiredModule(){
	$requiredModules = @(
		@{Name="psake"; MinimumVersion="4.6.0";},
		@{Name="Pester"; MinimumVersion="4.0.3";},
		@{Name="PSScriptAnalyzer"; MinimumVersion="1.15.0";}
	)
	$requiredModules | ForEach-Object {
		if(-not (Test-Module -Name $_.Name -MinimumVersion $_.MinimumVersion)){
			Install-Module -Name $_.Name -MinimumVersion $_.MinimumVersion -Scope CurrentUser -Force -SkipPublisherCheck -AllowClobber;
		}
	}
	$requiredModules | ForEach-Object {
		if(-not (Get-Module -Name $_.Name -ErrorAction SilentlyContinue)){
			Import-Module -Name $_.Name;
		}
	}
}

if($null -ne [System.Net.WebRequest]){
	[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials;
}
if(-not(Test-Module -Name "PowerShellGet")) {
	Write-Error -Message "PowerShellGet module not found. You can get it from here: https://www.powershellgallery.com/" -Category NotInstalled;
} else {
	Import-DependantModule;
	Import-RequiredModule;
	"> Invoke-psake [Task Name]  #To execute task"
	"> Invoke-psake [Task Name] -verbose  #To execute task with verbose logging"
	"> Invoke-psake -docs  #To get this list of task"
	Push-Location -Path $PSScriptRoot;
	Invoke-psake -docs -nologo;
}
