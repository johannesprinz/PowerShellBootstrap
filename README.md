# PowerShell Bootstrap
Solution template I use to launch any project with some basic PowerShell automation 
and psake orchestration

## About
This project has been created in an effort to standardize and localize the platform 
delivery mechanism for all the platforms in the IGMS solution space. This solution 
holds the PSake bootstrap code. It should be maintained here and copied down to 
all consuming platforms.

## Getting started
To get started run `README.cmd` in administrator mode and explore all the tasks 
available. The first execution may prompt you to install some prerequisite PowerShell 
tools and modules to ensure all other tasks are runnable. To exercise the automation 
pipeline in it's entirety run `Invoke-paske Deploy`

## To use this
1. Launch `README.cmd`
2. Run >`Invoke-psake Clean`
3. Copy the entire content to a new location
4. Rename the PSBoilerplate solution folder 
5. Rename PSBoilerplate.sln file 
5. Rename the script\Module\PSBoilerplate\PSBoilerplate.psm1 module file
5. Rename the script\Module\PSBoilerplate module folder
7. Launch the copied `README.cmd`
8. Run >`Invoke-psake Deploy`
9. And you should be all set.

Once set you should only have to modify the `task*.ps1` files and add/remove 
.ps1 files to and from the `Functions` folder.

## Link to further documentation
- [Deep dive](./docs/deepdive.md) into how this project is wired up.
- [Core orchestrations](./docs/coreOrchestration.md) explained.

## Useful links
- [psake git](https://github.com/psake) PowerShell task orchestration framework
- [pester](https://github.com/pester/Pester) PowerShell testing framework
- [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) PowerShell linting tool