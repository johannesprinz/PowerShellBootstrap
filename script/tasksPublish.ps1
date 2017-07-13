Include ".\references.ps1"

properties { 
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
	$message = @{
		notImplemented = 'This task has not been implemented yet'
	}
}

Task Default -Depends Publish

Task Clean { }

Task Publish {
	Write-Verbose -Message $message.notImplemented;
}