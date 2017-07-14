Include ".\..\references.ps1"

properties { }

Task Default -Depends Build-PowerShell

Task Clean { }

Task Build-PowerShell {
	Invoke-ScriptAnalyzer -Path . -Recurse;
}