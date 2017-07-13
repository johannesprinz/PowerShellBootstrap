Include ".\references.ps1"

properties {
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
	$dir = @{
		base =(Get-Item -Path $psake.build_script_dir).FullName;
		src = (Get-Item -Path '..\').FullName;
	}
}

Task Default -Depends Get-Help

Task Get-Help {
	if(Test-Path -Path ..\README.md) {
		Write-Verbose -Message "README can be found here $($dir.src)\README.md" -Verbose
	}
	Invoke-psake -docs -nologo
	Get-ChildItem -Path $dir.base -Filter task*.ps1 | Foreach-Object {
		Write-Verbose -Message $_.FullName -Verbose;
		Invoke-psake -buildFile $_ -docs -nologo;
	}
}

Task Clean -Description "Cleans all build and packaging artifacts in the solution" {
	Get-ChildItem -Path $dir.base -Filter task*.ps1 | Foreach-Object {
		Invoke-psake -buildFile $_ -taskList Clean -nologo -notr;
	}
}

Task Setup {
	Invoke-psake -buildFile .\tasksSetup.ps1 -nologo -notr
}

Task Build -Depends Clean {
	Invoke-psake -buildFile .\tasksBuild.ps1 -nologo -notr
}

Task Test -Depends Build {
	Invoke-psake -buildFile .\tasksTest.ps1 -nologo -notr
}

Task Package -Depends Test {
	Invoke-psake -buildFile .\tasksPackage.ps1 -nologo -notr
}

Task Publish -Depends Package {
	Invoke-psake -buildFile .\tasksPublish.ps1 -nologo -notr
}

Task Deploy -Depends Publish {
	Invoke-psake -buildFile .\tasksDeploy.ps1 -nologo -notr
}