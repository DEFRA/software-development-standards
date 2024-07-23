# Uipath Best Practices


## Developer Best Practices

### Do

#### Check if a library component already exists for your need before you start development. If you find a component that almost meets the requirement amend the component as required.
This helps save time, prevents duplication of components, and helps keep the components library up to date.

#### If your code has a loop ensure there is an infinite loop failsafe within it.
E.g. you can build in a counter in your loop to keep track of how many loops have taken place. You can then throw an exception or escape the loop at this point. This will prevent the automation from getting stuck.

#### If users will have sight of exception messages then try catch specific errors and reword them to be more user friendly.
This may reduce the number of MyIT tickets raised for our team. If possible add in a solution to the error message. E.g. “The Excel file is already open. Please close the file then restart the robot.”

#### Please follow the 3/4 letter prefix and Hungarian case naming conventions.
E.g. strStringVariable, boolBooleanVariable, arrArrayVariable, dictDictionaryVariable. Give variables descriptive names. This ensures the code is easier to navigate and read.

#### Prefix all arguments with in, out, or io.
E.g. io_dictConfig

#### Use the 64-bit Template with modern design experience.
Some applications may not be compatible with 64-bit framework – in which case there is a 32-bit template available.

#### Annotate complicated code or any code requiring additional information.
Comment activity is also available to add text to.

#### Ensure activities have descriptive names.
E.g. Assign – Initialise Dictionary

### Documentation

#### When working on a new application please ensure that you grant the same level of access to all team members.
This helps reallocate work in case additional support work is required or there is unplanned leave.

#### Each project/work package should have its own repository. Naming convention to be used – [Agency][Workpackage Name] i.e. EA-Waste-Tonnage-Returns
Email Ben Sagar to create the repository.

#### Upon completion of a project – please book a technical video handover with 2 Developers.
Please upload this to our SharePoint Handover Videos. Remember to add the link URL into the Technical Developer document.

#### Convert useful code into library components.
You may create some useful reusable code for a new project. Please try to convert it into a library and book a share and learn with the team.

#### Create guides and add them to Guides.
You may have to do some configuration or set up a new application as part of a project or be given some RnD to complete. Please create a step-by-step guide with screenshots for anything that will be useful for the development team.

#### Work from the OneDrive folder and provide the development team with access to that folder.
Where a developer is on leave and may not have Git pushed this helps the development team save time by retrieving code unavailable in GitHub.

#### Use Orchestrator Assets for configurable input data.
The exception being if there is a project specific reason e.g. sensitive data requiring you to use a custom approach.

#### Complete the Developer technical document as and when you can.
Filling in the document throughout the development process will ensure nothing is forgotten or missed.

### Try

#### Try using simulate click/background activities over foreground versions.
For attended mode it allows users to use mouse & keyboard while a robot is running. This approach is faster and more stable than foreground counterparts.

#### Consider when you should use a sequence, flowchart, or a state machine.
Sometimes switching your code to a different format can improve readability. E.g. the ‘if activity’ and ‘flow decision’ activity are both if statements. However swapping ‘flow decisions’ with ‘if statements’ or vice versa can make an impactful change.

#### Using a template for your project.
Templates are available and kept up to date by the development team. There may be a rare scenario requiring you to create custom code. Please check with a Lead developer if the template is not fit for purpose before you create custom code.

#### If you must use foreground activities on an unstable selector ensure there is confirmation of code execution.
Wrap the foreground activity with a retry scope and some verification. Alternatively use the modern design mode built-in verification.

#### For message boxes addressed to the user please make use of the popup’s library components.
This is to ensure consistency in our department branding. Where you create your own try and keep the theme consistent with our branding.

#### Use the latest dependency.
Latest dependencies “usually” are faster and more stable.

#### Git push at the end of the day or after a meaningful change.
This helps to version control or checkpoint allowing you to return to a previous position. It further allows others to download and distinguish between completed code and partially built code.

#### Maintain consistency in your coding/readability.
If you discover an improved method as you are developing a project please ensure your entire code is in line with it for a consistent approach.

#### Asynchronous approach. Parallel coding style. Check outcomes simultaneously if possible.
Try using pick branches when you review multiple outcomes this is faster than having a chain of if activities. The state machine also has a built-in pick machine in the transition lines. *Please note this is not truly asynchronous to achieve asynchronous code you can make use of invoke process.* The pick branch executes the triggers in sequence but doesn’t wait for the activities to finish before executing the next trigger (making it seem like parallel or asynchronous).

#### Stay up to date with UiPath software.
This can be done by reading the latest release notes and watching the latest UiPath training academy videos. Share findings with the development team through share and learns.

### Avoid

#### Hardcoding values especially usernames/passwords
This is required as you may upload usernames/passwords to a public GitHub repository. It will be easier to change the values of any configurable from outside the code. E.g. Assets

#### Image based automation
Keep this as a last resort - image based activities are slow and unstable.

#### Nesting activities
E.g. an if within an if within … Nesting activities within each other makes the code difficult to read. Try to change your approach to reduce the level of nesting. E.g. use a switch case instead of a nest of ifs.

#### Spaghetti code
Spaghetti code refers to a difficult to follow coding style. Your code should be easy to follow in a flowchart. E.g. Having crossed lines in a flow chart will make it difficult to follow. E.g. Splitting a function written in several different invokes.

#### Storing passwords/sensitive information in Orchestrator
Some of our stakeholders do not authorise the use of cloud services. Please check with stakeholders for the preferred method of handling data.

#### Leaving developer code in final product main files
It is acceptable to leave separate testing xaml’s however avoid leaving commented out code in the main code or temporary write-lines etc…

#### Exception swallowing
If you use a try catch ensure exceptions are logged as a minimum because an empty catch makes it difficult to pinpoint the root cause during debugging.

#### Complicated/complex coding techniques
Avoid using complex coding techniques that could be done with simpler methods. If complex code is required please include an explanation within the annotation of the code. E.g. Using invoke code with vb.net instead of using predefined activities.

#### Complicated variables
E.g. Use a datatable/json object instead of dictionary within a dictionary variable.

#### Lasagne code
It is good practice to break up a flow into smaller flows however if this is done frequently the code becomes too layered. Try to keep how deep invokes within invoke layers reach. In addition don’t use one xaml file for everything! Avoid the use of single activity invokes or single activity components.

#### High number of variables
Try to reduce the number of variables used. It is difficult to track information being transferred during debugging if it’s passed from variable to variable. Try to keep arguments and variables that connect to each other in different xamls similarly named. You could make use of global variables if possible. Add into config variable if you need to use variable everywhere.

#### Using delay activity
Try to keep the delay activity as a last resort. You should be able to use find element as a wait which will stop waiting as soon as confirmation is received e.g. click followed by a find element. Consider also reducing the delays in the activities to speed up your code.

## Status

This standard was formally adopted on 23 July 2024.

## Significant changes

Re-write of UiPath best practices based upon the ways of working implemented 2021 onwards.