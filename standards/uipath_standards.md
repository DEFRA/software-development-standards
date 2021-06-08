# Uipath Best Practices



## General

- Use simulate click/type where possible.
- Never hardcode values especially credentials, use a config where possible
- The only value that can be hardcoded is the file path to the Config File.
- Ensure you enter the network path when adding file paths.
- Update the Common Components document with any new applications automated.
- Unit testing is more valuable than you think.
- Variable scope should be the minimum it can be.
- Avoid selector attributes becoming just wildcards (E.g. “*”).
- Avoid relying on id attributes.
- Image based automaton should be your last resort.
- Don’t publish your workflows with development-specific activities still in it.
- Validate that all screen changes have behaved as expected.
- Logging level should be left as the default.
- If it’s set to verbose, the files will build up over time in the client’s machine causing storage issues
- Only compare clean data; ensure the same cleansing is done to all variables for comparison.
- Don’t reinvent the wheel, we might have already solved the problem you’re about to tackle.



## Workflow

- Choose the correct layout type for the scope of your work.
   - Templates are there for a reason.
- Start applications needed for the process before you need them.
- Break workflows down, if it takes more than a sentence to define a container then there’s too much in it.
- Avoid nesting activities.
- Don’t allow lines to cross in flow charts.
- When using logic, make sure True=True and the positive outcome follows the True path.

## Error Handling

- Catch errors explicitly when you can.
- Catch them generically when you can’t.
- Don’t let errors disappear without being logged.
- Retrying is the default error-handling.
- Don’t retry forever.
- Keep in mind that error messages are for the end-user.


## File Storage and Access

- All scripts and related technical documentation to be stored on Github.
- Each project/workpackage should have its own repository. Naming convention – [Agency][Workpackage Name] i.e. EA-Waste-Tonnage-Returns
- All generic files need to be stored under the DRACoE repository.
- When working on a new application, please ensure that you get the same level of access to all team members.
- Use the development SharePoint or any other internal method of sharing files only. External file sharing platforms are not permitted unless prior approval has been obtained by the Service Owner. i.e. Dropbox
- Since all the work on Github is public, please ensure that no sensitive data has been stored i.e. credentials, sensitive data on informative screenshots
- Before committing a change to an existing activity in DRACoE repository, check the reusable components for dependencies and then communicate with relevant colleagues to ensure other processes aren’t impacted negatively.


## Notes and Naming Convention

- Add the below annotations to every workflow you create:
   - Description of process
   - Your name
   - Live Version number and when it was last updated
   - Date of last code review
- Name variables using Camel case with the variable type as the prefix i.e. strVariableName
- Name all activities in a meaningful way
- Name all containers (sequences, flowcharts, loops etc) to describe what they do
   - Where that’s not possible use an annotation
   - If your annotation is an essay, consider breaking up that container into smaller parts.
- Prefix all arguments with IN, OUT or IO

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
