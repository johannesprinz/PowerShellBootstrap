Include ".\references.ps1"

properties {
	$dir = @{
		base =(Get-Item -Path $psake.build_script_dir).FullName;
		src = (Get-Item -Path '..\').FullName;
	}
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
	$message = @{
		setup = "Please refere to $(Join-Path -Path $dir.src -ChildPath README.md)";
	}
}

Task Default -Depends Setup

Task Clean { }

Task Setup -Description "Sets up your environment ready for development" {
	Write-Warning -Message $message.setup;
}