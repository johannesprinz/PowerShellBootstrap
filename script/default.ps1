properties {
	$dir = @{
		base =(Get-Item -Path $psake.build_script_dir).FullName;
		src = (Get-Item -Path '..\').FullName;
	}
	$file = @{
		tasks = Get-ChildItem -Path (Join-Path -Path $dir.base -ChildPath "tasks") -Filter *.ps1;
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
		Invoke-psake -buildFile $_.FullName -docs -nologo;
	}
}

Task Clean {
	$file.tasks | Foreach-Object {
		Invoke-psake -buildFile $_.FullName -taskList Clean -nologo -notr;
	}
}

Task Setup {
	Invoke-psake -buildFile .\tasks\Setup.ps1 -nologo -notr
}

Task Build -Depends Clean {
	Invoke-psake -buildFile .\tasks\Build.ps1 -nologo -notr
}

Task Test -Depends Build {
	Invoke-psake -buildFile .\tasks\Test.ps1 -nologo -notr
}

Task Package -Depends Test {
	Invoke-psake -buildFile .\tasks\Package.ps1 -nologo -notr
}

Task Publish -Depends Package {
	Invoke-psake -buildFile .\tasks\Publish.ps1 -nologo -notr
}

Task Deploy -Depends Publish {
	Invoke-psake -buildFile .\tasks\Deploy.ps1 -nologo -notr
}