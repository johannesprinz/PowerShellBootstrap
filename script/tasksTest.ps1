Include ".\references.ps1"

properties {
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
	$dir = @{
		bin = Join-Path -Path $psake.build_script_dir -ChildPath "bin";
	}
}

Task Default -Depends Test-PowerShell

Task Clean { 
	Remove-Item -Path $dir.bin -Recurse -Force -ErrorAction SilentlyContinue
}

Task Test-PowerShell {
	$resultXml = Join-Path -Path $dir.bin -ChildPath 'PStestResult.xml';
	New-Item -Path (Split-Path -Path $resultXml -Parent) -ItemType Directory -Force | Out-Null;
	Invoke-Pester -OutputFile $resultXml -OutputFormat NUnitXml -Show Summary;
}