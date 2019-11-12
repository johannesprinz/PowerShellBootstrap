# http://ramblingcookiemonster.github.io/Building-PowerShell-Functions-Best-Practices/
# https://technet.microsoft.com/en-us/library/hh847806.aspx about_Functions_Advanced
# https://technet.microsoft.com/en-us/library/dd819489.aspx ApprovedVerbs
# function Verb-Noun {
function Format-HelloWorld {
	<#
	https://technet.microsoft.com/en-us/library/dd819489.aspx HelpKeyWords
    .SYNOPSIS
		What this does

    .FUNCTIONALITY
		What this does against

    .DESCRIPTION
		Full description

    .PARAMETER Param1
        What's this input

    .PARAMETER Param2
	    What's this input

        Default value is $True

    .EXAMPLE
        #Description of example
	    Comandline version of example

    .EXAMPLE
        #Description of example
	    Comandline version of example

    #>
	[OutputType([String])]
    [CmdletBinding(
        #DefaultParameterSetName=<String>,
        #HelpURI=<URI>,
        #SupportsPaging=<Boolean>,
        #PositionalBinding=<Boolean> <# If true you wont need the Position parameter binding #>,
        SupportsShouldProcess,
		ConfirmImpact="None"
		# High		This action is potentially highly "destructive" and should be confirmed by default unless otherwise specified.
		# Medium	This action should be confirmed in most scenarios where confirmation is requested.
		# Low		This action only needs to be confirmed when the user has requested that low-impact changes must be confirmed.
		# None		There is never any need to confirm this action.
    )]
    param (
        #[parameter(
		#	#https://technet.microsoft.com/en-us/library/hh847743.aspx
		#	Mandatory=$true,
		#	Position=0,
		#	ParameterSetName="Set1",
		#	ValueFromPipeline=$true,
		#	HelpMessage="Enter one or more values separated by commas.")]
		#[type] $Param1,
		#[parameter(
		#	Mandatory=$false,
		#	Position=1,
		#	ParameterSetName="Set2",
		#	ValueFromPipelineByPropertyName=$true)]
		#[type[]] $Param2,
		#[parameter()]
		#[parameter(Mandatory=$false, ParameterSetName="Set1")]
		#[parameter(Mandatory=$true, ParameterSetName="Set2")]
        #[switch] $Switch,
		[Parameter(Position=1, Mandatory=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )
    Begin{
		$formats = @{
			"Begin" = "Begin {0}...";
			"Process" = "...processing {0}...";
			"End" = "...ending {0}";
		};
    	Write-Verbose -Message ($formats.Begin -f $MyInvocation.MyCommand);
    	$date = Get-Date;
    } Process {
    	Write-Verbose -Message ($formats.Process -f $MyInvocation.MyCommand);
    	if ($pscmdlet.ShouldProcess($Name)) {
			return "Welcome to Hello World $Name on $date";
		}
    } End {
    	Write-Verbose -Message ($formats.End -f $MyInvocation.MyCommand);
    }
}