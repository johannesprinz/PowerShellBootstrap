Include ".\references.ps1"

properties { 
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
	$message = @{
		notImplemented = 'This task has not been implemented yet'
	}
}

Task Default -Depends Package

Task Clean { }

Task Package {
	Write-Verbose -Message $message.notImplemented;
}