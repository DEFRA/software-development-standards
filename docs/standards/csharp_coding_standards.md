# C# coding standards

These are common standards that apply to coding when using C# and are designed to be used in conjunction with the overall common coding standards.

## Rationale

 - Ensure consistent C# code and styling across all projects

### Resource

[Microsoft's standard conventions](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions)

### Naming Conventions

- PascalCasing for class names and method names

```csharp
public class ClientActivity
{
    public void ClearStatistics()
    {
        // ...
    }

    public void CalculateStatistics()
    {
        // ...
    }
}
```

- camelCasing for method arguments and local variables

```csharp
public class UserLog
{
    public void Add(LogEvent logEvent)
    {
        int itemCount = logEvent.Items.Count;
        // ...
    }
}
```

- do not use underscores in identifiers (you can prefix private static variables with an underscore)
- use predefined type names instead of system type names for example

```csharp
// Correct
string firstName;
int lastIndex;

// Avoid
String firstName;
Int32 lastIndex;
```

- use noun or noun phrases

```csharp
public class Employee
{

}

public class BusinessLocation
{

}
```

- prefix interfaces with the letter `I`.

```csharp
public interface IShape
{

}
```

### Layout Conventions

[CodeMaid](http://www.codemaid.net/) is a free open source Visual Studio Extension which will cleanup and simplify your C# code. It can be downloaded as an extension to visual studio and can run automatically either on save or on demand on either a selection of code or a whole solution.

1.  Remove unused using statements
2.  Sort using statements
3.  Add unspecified access modifiers
4.  Remove empty regions
5.  Add blank line padding
6.  Remove blank lines next to braces
7.  Run Visual Studio formatting
8.  Remove consecutive blank lines
9.  Remove end of line whitespace
10.  Update endregion tags

The default settings for CodeMaid should remain in place to adhere to [DEFRA principles](/principles/README.md) (details at http://www.codemaid.net/documentation/)

### Testing

As per the general coding standards it is expected that 90% of code is covered with unit tests however given unit test coverage in some C# projects (i.e. MVC) will include coverage of default Microsoft template code this 90% figure can be misleading. It is not expected that unit tests should be written to cover code already written by Microsoft and therefore attributes can be added to this code to exclude them from the code coverage calculation.

For example in a typical MVC application exclusions can be applied to areas such as anything in `App_Start` folder, any migrations, `global.asax`, etc.

To exclude test code from the code coverage results and only include application code, add the `ExcludeFromCodeCoverageAttribute` attribute to your test class.

To customize code coverage, follow these steps:

1. Add a run settings file to your solution. In Solution Explorer, on the shortcut menu of your solution, choose Add > New Item, and select XML File. Save the file with a name such as `CodeCoverage.runsettings`.
2. Add the content from the [example file](https://docs.microsoft.com/en-us/visualstudio/test/customizing-code-coverage-analysis?view=vs-2017#sample-runsettings-file), and then customize it to your needs as described in the sections that follow.
3. To select the run settings file, on the Test menu, choose Test Settings > Select Test Settings File. To specify a run settings file for running tests from the command line or in a build workflow, see Configure unit tests by using a `.runsettings` file.

When you select Analyze Code Coverage, the configuration information is read from the run settings file.

To turn the custom settings off and on, deselect or select the file in the Test > Test Settings menu.

https://docs.microsoft.com/en-us/visualstudio/test/customizing-code-coverage-analysis?view=vs-2017
