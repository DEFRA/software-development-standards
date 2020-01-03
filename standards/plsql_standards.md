# PL/SQL Coding Standards

## The Derivation of these Standards

These standards have been derived from hands-on experience at the
Environment Agency and Rural Payments Agency over many years. As such
they are mature, comprehensive while also being reasonably lightweight
and follow standard industry practice.

## Important Recommendation: Refer to these Standards by Version as well as Name.

These standards are likely to be updated on an ongoing basis. Anything
using these standards should therefore refer to these standards not only
be name (“PL/SQL Coding Standards”) but also by version (“1.0”). It
should not be assumed that established products will be continually
retrospectively updated to always reflect the very latest iteration of
these standards: therefore recording which specific version of these
standards has been adopted (and keeping all the preceding versions of
these standards) is essential.

# General Conventions

## Structure

### Use Block and Label coding for loops and anonymous blocks within procedures.

For example:
```PLSQL
 CREATE OR REPLACE PROCEDURE my\_proc
 
 IS
 
 BEGIN
 
    <<Block1>>
 
    DECLARE
 
       ………….
 
       <<yearly_analysis>
 
       FOR y_count IN yearly_analysis LOOP
 
          <<monthly_analysis>>
 
          FOR m_count IN monthly_analysis LOOP
 
             …………statements….
 
          END LOOP monthly_analysis;
 
          …………statements…………
 
       END LOOP yearly_analysis;
 
    END Block1

 END my_proc;
```

### Use a single EXIT point for loops.

### Use a single RETURN point for Functions.

## Declarations and Types

### Anchor variables to Database data types. 

That way if table/column changes are made, the code does not to be
updated to reflect the changes: Variables should never be designated as
a standard data type (e.g. VARCHAR2 (200), NUMBER (10), etc.

### Use SUBTYPE to standardise application-specific data types.

This allows creation of aliases for existing data types that cannot be
anchored to the database. These should be declared in a separate
package, for example:

```PLSQL
 CREATE OR REPLACE PACKAGE my_vars

 IS

    SUBTYPE counter IS INTEGER (10);**

Then in the DECLARATION section of the code:

 DECLARE

    v_counter my_vars.counter;
```

** This is the only place in the code where a hard-coded value is
used.

### Use CONSTANT declaration for variables that do not change, and declare these in a CONSTANTS package. For example:

```PLSQL
 DECLARE OR REPLACE PACKAGE my_constants

 IS

    C_max_hours_per_day CONSTANT NUMBER (2) := 24;
```

Then in the declaration section of a procedure

```PLSQL
 DECLARE

    V_full_day my_constants.c_max_hoursper_day;
```

### Global variables should never be more than “package-wide”.

## Error Handling

### All Anonymous blocks within a procedure should have their own exception handler in addition to the exception handler in the parent block.

For example:

```PLSQL
 CREATE OR REPLACE PROCEDURE my_proc
 
 IS
 
 BEGIN
 
    BEGIN
 
       DECLARE
 
       BEGIN
 
       EXCEPTION
 
       END;
 
    EXCEPTION
 
    END;

 EXCEPTION

 END my_proc;
```

### When performing bulk data operations (usually as some form of “batch” job) all tables should have a corresponding error table and all bulk update/insert/delete/merge statements should be suffixed with a LOG ERRORS statement referencing the errors table to prevent simple data errors terminating program execution.

### A standard error procedure should be used that records, in addition to user-defined information such as table name, DBMS\_UTILITY.FORMAT\_CALL\_STACK, DBMS\_UTILITY.FORMAT\_ERROR\_STACK and DBMS\_UTILITY.FORMAT\_ERROR\_BACKTRACE.

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
are those that can be applied automatically in TOAD. See “APPENDIX: An
Example of Automatically Formatting PL/SQL Code Using TOAD (the “Tool
for Oracle Application Developers”)” for an example of how to do this.

## Layout

### Indents should be 3 characters wide. All code within loops and if statements should be so indented with one such indent for each level of nesting within if statements or loops.

### THEN should be positioned on the next line, in-line with the related IF.

### LOOP should be positioned on the next line, in-line with the associated DO or WHILE.

### AS or IS should be positioned on the next line, in-line with the associated statement (such as with an associated CREATE).

### Layout examples:

```PLSQL
 BEGIN

    a := 1;

    d := 1;

    b := 2;

    WHILE TRUE

    LOOP

       a := 1;

       b := 2;

       IF a > b

       THEN

          c := d;

       END IF;

    END LOOP;

    x := 1;

    c := d;

 END;

 CREATE PROCEDURE myproc

 AS

 BEGIN

    NULL;

 END;
```

## Case and Lists

### Oracle key words should be in uppercase.

For example:

```PLSQL
 SELECT aaa

 , bbb

 , cccc

 , SIN (x)

 FROM mytab;
```

### Where you have lists, e.g. a list of column names or values, place each item on its own line, with commas, where needed, placed at the start of the line with a following space.

This makes it far easier to make changes, such as inserting new items
into the list, without losing track of the commas. For example:

```PLSQL
 CREATE TABLE my\_table1

 (

 my\_num1 NUMBER

 , my\_num2 NUMBER

 );

 INSERT INTO building\_blocks (aaaaaaaaaaaaaaaa

 , bbbbbbbbbbbbbb

 , cccccccccccccccc

 , ddddddddddddddddd

 , eeeeeeeeeeeee)

 SELECT aaaaaaaaaaaaaaaa

 , bbbbbbbbbbbbbbbbbbb

 , cccccccccccccccccc

 , dddddddddddddddd

 , eeeeeeeeeeeeeee

 , fffffffffffffffff

 FROM mytab, histab, hertab

 WHERE histab.col1 = hertab.col2;
```

# APPENDIX: An Example of Automatically Formatting PL/SQL Code Using TOAD (the “Tool for Oracle Application Developers”)

## Software Used in this Example

TOAD version 11.6.1.6 was used to “prove” these instructions.

## The Formatter Options File

These instructions use a formatter options file called
defra\_plsql\_toad\_fmt\_v1\_0.opt that should be co-located with these
standards.

Note that the version number of these standards has been included in
that file-name. As these standards are updated it is recommended that
updated versions of the formatter options file are created similarly
named after later versions of these standards.

The tool used (“toad”) has also been included in the file name, as this
file is specific to TOAD. Should similar code style files be created for
other tools, it is recommended that the name of the target tool is also
included in those file names.

## Setting up Automatic Code Formatting

### To import these formatting preferences within TOAD, open an Editor window. Right click on the editor pane and select Formatting Tools \> Formatting Options. Select the file open icon at the top left of the screen (“Load options from file” is the tool tip) and then browse to where you have located a copy of the defra\_plsql\_toad\_fmt\_v1\_0.opt file. Select the file. Then hit “Apply”. Then hit “OK” to close the formatter options window.

### To apply the formatter options to any SQL or PL/SQL code open the code in the Editor Window, right click and then select Formatting Tools\>Format.
