# Uipath Best Practices



## General

 - Use Simulate Clicks where possible when interacting with web pages to help processes run in the background
 - Never hardcode values especially credentials, use a config where possible
 - The only value that will be hardcoded is the file path to the Config File
 - Update the Common Components document with any new applications automated
 - Analyse and run your automation frequently while you are designing it to ensure robust unit testing
 - Setting variables scope to have general visibility should be avoided as much as possible
 - If an attribute’s value is all wildcard on a selector (e.g. name=’*’), then the attribute should be removed
 - Avoid using the idx attribute unless its value is a very small number like 1 or 2.
 - Use image automation as the last possible approach
 - Cleanup workflow before publishing to remove any activities added for development purposes i.e. Message Boxes not relevant to the
   process
 - Validate all screen changes including text that has been added/removed from fields
 - Logging level should be left as the default. i.e.if it’s set to verbose, the files will build up over time in the client’s machine
   causing storage issues
 - Ensure that you .ToLower or .ToUpper when comparing text
 - Consult with the wider team before creating time consuming complex solutions to ensure that there isn’t another, more efficient way to
   achieve the same result

 
## Workflow

 - Choose the layout type wisely (flowcharts and sequences). Normally the logic of the process stays in flowcharts while the navigation and
   data processing is in sequences.
 - ‘Main’ Workflow only runs the Config Reader and Proxy Main
 - Main handles the overall result of the process whether it is successful, or an exception has been thrown
 - Default layout for all workflows:
     - Log start of workflow
     -  Get IN Args
     - Run the main logic of the workflow, either in another workflow or a sequence (does not always need to be another workflow, can just be steps within the existing workflow
     -Set OUT Args
     -Log end of workflow
 - Start up applications needed for the process at the start of Proxy Main
 - Break workflows down into small reusable chunks
 - Avoid nesting activities where possible
 - Don’t allow lines to cross in flow charts

## Error Handling

 - Pin annotations to try catches to describe what is in them
 - Set result of workflow in the try catch to be used in the flow switch (i.e. Continue, System Exception, Business Exception)
 - Run workflow for opening each application inside separate try catches
 - This allows individual retries to be attempted without reopening every application
 - Kill application before retrying opening it
 - Add to error messages while throwing them up to the highest level
 - This allows for traceability of where the error originated from
 - Error handle and retry within invoked workflows instead of Proxy Main where possible
 - Reset retry counter every time after successfully running a step which could be retried
 - Enough details should be provided in the exception message for a human to understand it and take the necessary actions

## File Storage and Access

 - All scripts and related technical documentation is to be stored on Github to ensure that all other developers in the team have access to
   your work
 - Each project/workpackage should have its own repository
 - All generic files need to be stored under the DRACoE repository
 - When working on a new application, please ensure that you get the same level of access to all team members (if possible) to ensure that
   we are all able to support each other when required
 - Use the development SharePoint or any other internal method of sharing files only. External file sharing platforms are not permitted
   unless prior approval has been obtained by the Service Owner. i.e.
   Dropbox
 - Since all the work on Github is public, please ensure that no sensitive data has been stored i.e. credentials, sensitive data on
   informative screenshots

## Notes and Naming Convention

 - Add annotation to every workflow describing what it does:
   - Description of process
   - Who created the process
   - Version number and when it was last updated
   - Date of last code review for workflow
 - Name variables using Camel case with the variable type as the prefix i.e. strVariableName
 - Name all activities in a meaningful manner

Prefix all arguments with IN, OUT or IO
## Sources

*Some of the practices set on this document were set by DEFRA’s development standards whilst others were contributed by individuals based on experience. Below are some of the resources from where some of these practices originated:*

 - [https://github.com/DEFRA/software-development-standards](https://github.com/DEFRA/software-development-standards)

 - [https://www.gov.uk/service-manual/technology/making-source-code-open-and-reusable](https://www.gov.uk/service-manual/technology/making-source-code-open-and-reusable)

 - [https://www.gov.uk/government/publications/open-source-guidance/when-code-should-be-open-or-closed](https://www.gov.uk/government/publications/open-source-guidance/when-code-should-be-open-or-closed)

 - [https://docs.uipath.com/studiox/docs/automation-best-practices](https://docs.uipath.com/studiox/docs/automation-best-practices)
[https://docs.uipath.com/studio/docs/workflow-design](https://docs.uipath.com/studio/docs/workflow-design)

 - [https://docs.uipath.com/studio/docs/ui-automation](https://docs.uipath.com/studio/docs/ui-automation)

 - [https://docs.uipath.com/studio/docs/project-organization](https://docs.uipath.com/studio/docs/project-organization)

 - [https://forum.uipath.com/t/uipath-best-practices-wiki/139278](https://forum.uipath.com/t/uipath-best-practices-wiki/139278)
