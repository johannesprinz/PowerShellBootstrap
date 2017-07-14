Include ".\..\references.ps1"

properties { 
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
	$message = @{
		notImplemented = 'This task has not been implemented yet'
	}
}

Task Default -Depends Deploy

Task Clean { }

Task Deploy {
	Write-Verbose -Message $message.notImplemented;
}