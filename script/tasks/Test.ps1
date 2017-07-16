Include ".\..\references.ps1"

properties {
	$dir = @{		
		base =(Get-Item -Path (Join-Path -Path $psake.build_script_dir -ChildPath "..")).FullName;
		bin = Join-Path -Path (Join-Path -Path $psake.build_script_dir -ChildPath "..") -ChildPath "bin";
	}
}

Task Default -Depends Test-PowerShell

Task Clean { 
	Remove-Item -Path $dir.bin -Recurse -Force -ErrorAction SilentlyContinue
}

Task Test-PowerShell {
	$resultXml = Join-Path -Path $dir.bin -ChildPath 'PStestResult.xml';
	New-Item -Path (Split-Path -Path $resultXml -Parent) -ItemType Directory -Force | Out-Null;
	Invoke-Pester -Script $dir.base -OutputFile $resultXml -OutputFormat NUnitXml -Show Failed, Summary;
}