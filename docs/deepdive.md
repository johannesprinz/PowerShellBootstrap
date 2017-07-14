# Deep dive
Here is a quick deep dive into how all the components in this project are wired
up and what the thoughts behind then are. Overall when dealing with scripting and
automation you two general areas. One is the reusable script files and the other 
is the sequenced orchestration and input configurations. The one missing component
at this stage is a good pattern for a configuration provider.

## The Components
In order they are invoked.
1. [README.cmd](#README.cmd)
2. [psake.ps1](#psake.ps1)
3. [default.ps1](#default.ps1)
4. [refrences.ps1](#refrences.ps1)
5. [tasks\\\*.ps1](#tasks)
6. [moduleFile.psm1](#moduleFile.psm1)
7. [functions.ps1](#functions.ps1)
8. [function.tests.ps1](#function.tests.ps1)

### README.cmd
This is the double click launch pad into all available tasks and their documentation.
As the name implies all it does is list the high level options with the ability 
to dive deeper as you need. This calls the [psake.ps1](#psake.ps1) script file in
Administrator mode with no profile and the version specified.

### psake.ps1
This is the PSAKE bootstrap, it ensures you have all required modules to run 
such as [PowerShellGet](https://www.powershellgallery.com/), [Psake](https://github.com/psake), 
[Pester](https://github.com/pester/Pester) and 
[PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) as well as sets 
the default trusted PowerShellGet repository. In a security conscious environment 
I suggest making this an internally controlled endpoint.

### default.ps1
This defines the basic [top level orchestration](./coreOrchestration.md) tasks, these are used as a local 
implementation and most continues integration/deployment tools will exerciser these. 
All bar the `Invoke-psake Get-Help` and `Invoke-psake Clean` orchestration 
will call into their respective sub-orchestration.

### refrences.ps1
This is like the c# references folder in c# projects, in this case it loads all 
modules found in the modules directory but this can be split out into several 
references and include only required modules. This is mainly used to load and 
test all the modules like a compile-time check.

### tasks
All the tasks[Specific].ps1 files describe all the sub orchestrations, some come 
with a basic implementation and others are just not implemented yet. Either way 
they should all be considered when putting together a 
[CI](https://www.thoughtworks.com/continuous-integration)/
[CD](https://en.wikipedia.org/wiki/Continuous_delivery) orchestration.

### moduleFile.psm1
To group together a common group of functions PowerShell uses modules. This module file
by default exposes all functions found in the functions folder that do not contain 
the string '.tests.' in it's path. This can be modified to hide private functions as well
by coming up with a private function naming convention.

### functions.ps1
This sample function encompass many of the best practices I've stumbled across while
authoring many PowerShell functions. The `Invoke-psake Build` task will run a 
[PowerShell linting tool](https://github.com/PowerShell/PSScriptAnalyzer) across 
all PowerShell files in the **script** folder.

### function.tests.ps1
This is a sample Pester test testing the sample function above. Pester is so far the
best PowerShell testing framework I've come across. I highly advise any function 
written is tested, as the tests also document intended usages. To run the tests
from root orchestration run:
```
Invoke-psake Test 
``` 
and to run just the tests without the surrounding orchestrations run:
```
Invoke-psake -buildFile .\tasksTest.ps1
```