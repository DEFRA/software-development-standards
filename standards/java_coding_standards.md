# Java Coding Standards

## Rationale

This document is intended to present the standards to which all Java
code produced by, or on behalf of, DEFRA should adhere. Java coding
standards are intended to:

  - Make the produced code more easily read and understood.

  - Make the code more easily maintainable.

  - Make the code more reliable.

## The Derivation of these Standards

These standards are a slightly updated version of the standards used in
practice for many years in the Environment Agency during the period when
Java was defined as the strategic programming language. As such they are
comprehensive, mature and follow standard industry practice.

# General Conventions

## Naming, Structure and Declarations

### English descriptors should be used for all variables and classes such that they define the purpose of the object they describe.

The only allowable exceptions to this rule are firstly where local
variables are used as iteration counters where i is the accepted
standard. Where multiple counters are required they should start
alphabetically at i then j etc. Secondly exceptions may be abbreviated
for example in the catch clause of a programmatic block and exception
may be called e.

### All variables should start with a lower case letter and the initialof any non-leading word should be capitalised.

For example fishingLicense, dataElement. This rule should ensure that
variable names do not differ only in case. One exception to this rule is
where a name includes a word which is commonly capitalised such as an
acronym. An example of this would be userID or serialUID.

### Do not use leading or trailing underscores.

### Local variables should not share the same name as a variable with greater scope.
 The only exception to this is in a setter, where the
    passed in parameter name should match the name of the instance
    variable.

### Class and interface names should begin with a capital letter and the initial of any non-leading word should be capitalised.

For example FishingLicenceComparator, ValueObjectEngineer.

### Static final variables should be named with capitalised names and should have words separated by an underscore.

For example
```JAVA
SALMON_LICENCE_TYPE
```
###  Arrays should be declared using the bracket notation after the datatype not the variable.

For example
```JAVA
byte[] fileBytes
```
### Where methods are overloaded they should appear next to each other in the class.

### Objects should be initialised to null at declaration time.

### Accessor and Mutator methods (gets and sets) should follow the Javabeans naming conventions.

For example the variable licenceCount would be accessed by the method
getLicenceCount().

### All classes and interfaces should belong to an explicit package.

### All packages should be prefixed by uk.gov.defra. Package identifiers should all be singular i.e. should not contain plurals.

### Packages should not be imported in their entirety by using the wildcard notation.
 (If using an IDE such as Eclipse this, plus
    removing any unwanted imports, ought to be the default behaviour of
    the IDE).

### Where possible methods and variables should be referenced without using full name qualification.

For example reference IOException rather than java.util.IOException.

### Constructors should appear as the first methods in any class, followed by the finalize() method if overridden, followed by static methods and then any other methods and finally any inner classes.

# Formatting Code

## Important Recommendation: Do This Automatically

Well formatted code greatly facilitates readability, maintainability and
reliability. However, formatting code is also a chore: difficult and
tedious to remember, time consuming to manually apply and difficult to
police. Many code formatting rules, taken individually rather than as an
entirety, will not individually add sufficiently to code readability,
maintainability and reliability for their adoption to offset that cost.

The way out of this to dilemma is to adopt tools that automatically
format code. Indeed, unless the benefits of adopting any individual code
formatting rule are very significant, or the costs and risks of not
adopting such a rule are equally significant, a reasonable rule of thumb
is that the only code formatting rules that should be adopted are those
that can be applied automatically.

In this spirit, all the code formatting rules described in this section
are those that can be applied automatically (indeed merely on code
“save”) in the Eclipse IDE. See “APPENDIX: An Example of Automatic
Java Code Formatting” for an example of how to do this.

## Statements and Expressions

### A single line should not contain multiple statements.

### When using unary operators no space should be left between the variable and the operator.

For example:
```JAVA
Licences++;
```
### For readability, equality operator must always be wrapped in spaces.

For example:
```JAVA
licenceType == 2
```
### For readability assignment operators must be wrapped in spaces.

For example:
```JAVA
LicenceType = 3;
```
### For readability, arrow (lambda) operators must be wrapped in spaces.

For example:
```JAVA
interface NumericTest
{
  boolean computeTest(int n);
}

NumericTest isNegative = (n) -> (n < 0);
```

### Logic and binary operators should be wrapped in spaces.

For example:
```JAVA
payAward += 4;

(payAward >= 1000);
```
### The semicolon closing a statement should immediately follow the statement and should not be preceded by a space.

### A single blank line should appear between a method end and the next method's leading comments.

### Indents should be 2 characters wide

### Opening and closing braces should be aligned and not appear on the same line. For example:
```JAVA
try
{
  // some actions
}
catch (Exception e)
{
  // handle exception
}
```

### Lambda expressions should ideally be single line, in which case the entire expression should where-ever possible be kept to the same line (i.e. unless forced to wrap as the line exceeds the maximum specified line length).

For example, assuming this functional interface:
```JAVA
interface NumericTest
{
  boolean computeTest(int n);
}
```
A correctly formatted lambda expression could look like:

```JAVA
NumericTest isNegative = (n) -> (n < 0);
```

### Where a lambda expression spans many lines, the braces surrounding those lines should follow the same rules as all other braces.

For example, assuming this functional interface:

```JAVA
interface NumericTest
{
  boolean computeTest(int n);
}
```

A correctly formatted lambda expression could look like:

```JAVA
NumericTest isNotEven = (n) ->
{
  n++;
  return n % 2 == 0;
};
```

## Loops and Conditionals

### Loops and conditionals should be blocked out in the following manner unless the content is a single line statement.

Examples:

```JAVA
for (int i=0; i<maxValue; i++)
{
  // loop body goes in here
}

if (licenceType == 1)
{
  // conditional body goes in here
}

switch (licenceCode)
{
  case F172:
    // do actions
    break;

  default:
    // do actions
    break;
}
```

For single line statements either the above approach or the following is
permissible:

```JAVA
for (i = 0; i <= 12; i++)

j = j + i;
```

The important thing is that the content of the loop is clearly
distinguished, either by the braces or, in the case of a single line and
only a single line, that line being separately indented.

### Indentation should be used to indicate enclosed statements in loops and conditionals.

## Class, Interface and Method Declaration

### Classes and interfaces should be declared, if possible, on a single line. Where this is not possible indentation should be used to aid the reading of the class declaration as follows.

```JAVA
public class MySpecialisedClass extends MyGenericClass
 implements Serializable
{
  // class body goes in here
}
```

### Methods should be declared, if possible, on a single line.

Where this is not possible indentation should be used to aid the reading
of the method declaration as follows.

```JAVA
public myIOMethod(String param1, Integer param2) throws IOException,
  FileNotFoundException
{
  // method body goes in here
}
```

# Commenting and Documentation

See the Coding Standards for the general standards and guidance on
commenting code.

## JavaDoc

### All classes and interfaces should include JavaDocs comments as a header.

The comments should explain in plain English what the purpose of the
class or interface is, where that purpose is not obvious from the name.
The JavaDoc header should be placed below the package name and import
list and above the class definition.

### The following header format should be used:

```JAVA
/**
*  Original Author: @author
*/

/**
*     Brief description of what MyClass does.
*
*/
```

(Note that any information about the class history, beyond the
identity of the original author, is not included here, as such
information should be included in the version control system.
Attempting to maintain such information in the class comments
themselves is not only duplicate effort but is likely to result in the
two sources of information becoming confusingly inconsistent).

### All methods should be preceded by JavaDoc comments.

Comments must state in plain English what the purpose of the method is,
what effect it has on any referenced objects and any pre or post
conditions that apply to the method's use. The comment should also
indicate if the method overrides an inherited method. The javadoc should
include entries for @param, @return and @exception, where-ever those are
appropriate. For example:

```JAVA
/** Method To return a count of the outstations associated with the location
*    @param locID, the locationID to search on
*    @return Integer, number of outstations, null if none are found
*    @exception DataAccessException, thrown when outstations can't be counted
*/
```

Other javadocs tags can be used as required.

## Other Comments

### Both multi-line (/\* \*/) and single line (//) comments may be used.

### Comments within the method body should, wherever possible, be restricted to single line comments.

# APPENDIX: An Example of Automatic Java Code Formatting

## Software Used in this Example

Java 11 and Eclipse version 2018-12, the latest versions at the time of
writing, were used to “prove” the following instructions. However, these
instructions have remained consistent for many versions of Eclipse, and
so hopefully are likely to remain largely valid in the future. Also, the
Eclipse checkstyle integration has evolved into an unofficial standard
and many IDE's can support it (sometimes using plugins), including
Microsoft’s Visual Studio Code.

## The Code Style File

These instructions use a code style file called
defra\_java\_eclipse\_code\_style\_v1\_1.xml, that should be co-located
with these standards.

Note that the version number of these standards has been included in
that file-name. As these standards are updated it is recommended that
updated versions of the code style file are created similarly named
after later versions of these standards.

## Setting up Automatic Code Formatting

To import these formatting preferences within Eclipse: Windows\> Preferences \> Java \> Code Style \> Formatter \> Import.

To allow Eclipse to automatically apply these preferences on Save: Windows \> Preferences \> Java \> Editor \> Save Actions then check “perform the selected actions on save” and “format source code”.
