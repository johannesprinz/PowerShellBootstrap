Include ".\references.ps1"

properties {
	$dir = @{
		base =(Get-Item -Path $psake.build_script_dir).FullName;
		src = (Get-Item -Path '..\').FullName;
	}
	$file = @{
		tasks = Get-ChildItem -Path $dir.base -Filter tasks*.ps1 -Exclude tasksDeploy.ps1;
		readme = Join-Path -Path $dir.src -ChildPath "README.md"
	}
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
	$message = @{
		readme = "README can be found here $($file.readme)"		
	}
}

Task Default -Depends Get-Help

Task Get-Help {
	if(Test-Path -Path ..\README.md) {
		Write-Verbose -Message $message.readme -Verbose
	}
	Invoke-psake -docs -nologo
	$file.tasks | Foreach-Object {
		Write-Verbose -Message $_.FullName -Verbose;
		Invoke-psake -buildFile $_ -docs -nologo;
	}
}

Task Clean {
	$file.tasks | Foreach-Object {
		Write-Verbose -Message $_.FullName;
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