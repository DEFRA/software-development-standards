# PL/SQL Coding Standards

## Structure

> Use `Block` and `Label` coding for loops and anonymous blocks within procedures

```sql
 CREATE OR REPLACE PROCEDURE my\_proc

 IS

 BEGIN

    <<Block1>>

    DECLARE

       -- statements

       <<yearly_analysis>

       FOR y_count IN yearly_analysis LOOP

          <<monthly_analysis>>

          FOR m_count IN monthly_analysis LOOP

             -- statements

          END LOOP monthly_analysis;

          -- statements

       END LOOP yearly_analysis;

    END Block1

 END my_proc;
```

- Use a single `EXIT` point for loops

- Use a single `RETURN` point for Functions

## Declarations and Types

- Anchor variables to Database data types

That way if table/column changes are made, the code does not to be
updated to reflect the changes: Variables should never be designated as
a standard data type (e.g. `VARCHAR2 (200)`, `NUMBER (10)`, etc.

- Use `SUBTYPE` to standardise application-specific data types

This allows creation of aliases for existing data types that cannot be
anchored to the database. These should be declared in a separate
package, for example:

```sql
 CREATE OR REPLACE PACKAGE my_vars

 IS

    SUBTYPE counter IS INTEGER (10);**
```

Then in the DECLARATION section of the code:

```sql
 DECLARE

    v_counter my_vars.counter;
```

**This is the only place in the code where a hard-coded value is
used.**

- Use CONSTANT declaration for variables that do not change, and declare these in a CONSTANTS package

```sql
 DECLARE OR REPLACE PACKAGE my_constants

 IS

    C_max_hours_per_day CONSTANT NUMBER (2) := 24;
```

Then in the declaration section of a procedure

```sql
 DECLARE

    V_full_day my_constants.c_max_hoursper_day;
```

- Global variables should never be more than "package-wide"

## Error Handling

- All Anonymous blocks within a procedure should have their own exception handler in addition to the exception handler in the parent block

```sql
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

- When performing bulk data operations (usually as some form of "batch" job) all tables should have a corresponding error table and all bulk update/insert/delete/merge statements should be suffixed with a LOG ERRORS statement referencing the errors table to prevent simple data errors terminating program execution

- A standard error procedure should be used that records, in addition to user-defined information such as table name, `DBMS\_UTILITY.FORMAT\_CALL\_STACK`, `DBMS\_UTILITY.FORMAT\_ERROR\_STACK` and `DBMS\_UTILITY.FORMAT\_ERROR\_BACKTRACE`

## Formatting Code

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

- Indents should be 3 characters wide. All code within loops and if statements should be so indented with one such indent for each level of nesting within if statements or loops

- `THEN` should be positioned on the next line, in-line with the related `IF`

- `LOOP` should be positioned on the next line, in-line with the associated `DO` or `WHILE`

- `AS` or `IS` should be positioned on the next line, in-line with the associated statement (such as with an associated `CREATE`)

Layout examples:

```sql
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

- Oracle key words should be in uppercase

```sql
 SELECT aaa

 , bbb

 , cccc

 , SIN (x)

 FROM mytab;
```

- Where you have lists, e.g. a list of column names or values, place each item on its own line, with commas, where needed, placed at the start of the line with a following space

This makes it far easier to make changes, such as inserting new items into the list, without losing track of the commas.

```sql
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
