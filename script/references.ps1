Get-ChildItem .\Modules -Recurse -Filter *.psm1 | 
	ForEach-Object { 
		If($null -eq (Get-Module -Name $_.BaseName)) {
			Import-Module -Name $_.FullName -Force 
		}
	}