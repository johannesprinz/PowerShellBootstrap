# Core Orchestrations
Having worked with many different [continuous integration](https://www.thoughtworks.com/continuous-integration) /
[continuous delivery](https://en.wikipedia.org/wiki/Continuous_delivery) 
system I have derived five core orchestration every system offers.

- [Build](#Build)
- [Test](#Test)
- [Package](#Package)
- [Publish](#Publish)
- [Deploy](#Deploy)

These are all the tasks machines need to deliver most technical solutions. But 
since these tasks are most often authored by real humans we add this additional task
- [Get-Help](#Get-Help)

... and because those humans are more often than not 'developers' we need two more 
tasks to get them going and wrapping up.
- [Clean](#Clean)
- [Setup](#Setup)

## Get-Help
This could redirect to further .md files but out of the box it invokes 
`Invoke-psake -docs` on all tasks*.ps1 files in the script folder.

## Clean
Like all good people, even scripts need to clean up after themselves. This task
invokes `Invoke-psake Clean` on all tasks*.ps1 files in the script folder.
This will fail if a tasks.ps1 file does not have a clean task. The 'Clean' task 
describes a basic interface for all orchestrations to play nice, IE. clean up 
after themselves especially if they create temporary files or files that can be 
re-created, as well as triggering the intent for orchestration creators to ensure 
they can roll back / undo anything they do.

## Setup
[tasksSetup.ps1](../script/tasksSetup.ps1)

The [psake.ps1](./deepdive.md#psake.ps1) file sets up some really basic dependencies,
but if the solution requires some more intense one-off setup dependencies then this
is the orchestration to work with. This can install tooling, other modules, certificates
ans anything else required to author and run the scripts and orchestrations. 

## Build
[tasksBuild.ps1](../script/tasksBuild.ps1)

This is used to perform any linting and compile activities. Out of the box it just 
runs the [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer).

## Test
[tasksTest.ps1](../script/tasksTest.ps1)

Ideally this task should appear multiple times in the orchestration pipleline as 
there are multiple stages of tests. The most basic being Unit Tests. Out of the 
box this invokes [pester](https://github.com/pester/Pester) which runs all the
PowerShell tests. Thats not to say you can't implement packing test, deployment 
test, integration tests etc. In fact you should.

## Package
[tasksPackage.ps1](../script/tasksPackage.ps1)

One solution may create 1 or more deployment packages. Such as an Phone APP, 
web API and database package. This is where you can orchestrate all the packages
being packed into their respective deployment assets, be it folders, zip files 
or other.

## Publish
[tasksPublish.ps1](../script/tasksPublish.ps1)

This should push the packages to either the deployment targets or some packaging 
store such as NuGet or any other packet manager.

## Deploy
[tasksDeploy.ps1](../script/tasksDeploy.ps1)

Deployment comes in many flavors. Here you can orchestrate the overall deployment.
**Note** You can split your deployment orchestration to manage each package 
independantly and each of these can be packaged with the respective package. Ensure
all deployment dependencies are packed into each package.