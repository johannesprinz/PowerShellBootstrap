# PowerShell Bootstrap
Solution template I use to launch any project with some basic PowerShell automation and Psake orchestration

## About
This project has been created in an effort to standardise and localize the platform delievery mechanism for all the 
platforms in the IGMS solution space. This solution holds the PSake bootstrap code. It should be maintained here and 
copied down to all consuming platforms.

## Getting started
To get started run `README.cmd` in admin mode and explore all the tasks available. The first execution may 
prompt you to install some pre-requisit powershell tools and modules to ensure all other tasks are runnable.
To excersise the automation pieline in it's entirety run `Invoke-paske Deploy`

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

Once set you should only have to modify the `task*.ps1` files and add/remove .ps1 files to and from the `Functions` folder.

## Link to further documentation
- [More to read](./docs/moreToRead.md)

## Useful links
- [psake](https://github.com/psake) PowerShell task orchastration framework
- [pester](https://github.com/pester/Pester) PowerShell testing framework
- [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) PowerShell linting tool