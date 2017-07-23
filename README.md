# PowerShell Bootstrap
Solution template I use to launch any project with some basic [PowerShell](https://github.com/PowerShell/PowerShell) automation 
and [Psake](https://github.com/psake) orchestration

## About
This project has been created in an effort to standardize and localize the platform 
delivery mechanism for all my solutions. This solution holds the PSake bootstrap 
code.

## Getting started
To get started run 
- [README.cmd](./README.cmd) for windows.

and explore all the tasks available. The first execution may prompt you to install 
some prerequisite PowerShell tools and modules to ensure all other tasks are runnable. 
To exercise the automation pipeline in it's entirety run `Invoke-psake Deploy`

## To use this
1. Launch `README.cmd`
2. Run >`Invoke-psake Clean`
3. Copy the entire content to a new location
4. Rename the script\Module\PSBoilerplate\PSBoilerplate.psm1 module file
5. Rename the script\Module\PSBoilerplate module folder
6. Launch the copied `README.cmd`
7. Run >`Invoke-psake Deploy`
8. And you should be all set.

Once set you should only have to modify the `tasks*.ps1` files and add/remove 
.ps1 files to and from the `Functions` folder.

## Link to further documentation
- [Deep dive](./docs/deepdive.md) into how this project is wired up.
- [Core orchestrations](./docs/coreOrchestration.md) explained.

## Useful links
- [pester](https://github.com/pester/Pester) PowerShell testing framework
- [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) PowerShell linting tool