# PL/SQL Coding Standards

These standards have been derived from hands-on experience at the	Environment Agency and Rural Payments Agency over many years. As such they are mature, comprehensive while also being reasonably lightweight	and follow standard industry practice.

## Structure

> Use `Block` and `Label` coding for loops and anonymous blocks within procedures

```sql
 CREATE OR REPLACE PROCEDURE my_proc

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

That way if table/column changes are made, the code does not to be updated to reflect the changes: Variables should never be designated as a standard data type (e.g. `VARCHAR2 (200)`, `NUMBER (10)`, etc.

- Use `SUBTYPE` to standardise application-specific data types

This allows creation of aliases for existing data types that cannot be anchored to the database. These should be declared in a separate package, for example:

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

**This is the only place in the code where a hard-coded value is used.**

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

- A standard error procedure should be used that records, in addition to user-defined information such as table name, `DBMS_UTILITY.FORMAT_CALL_STACK`, `DBMS_UTILITY.FORMAT_ERROR_STACK` and `DBMS_UTILITY.FORMAT_ERROR_BACKTRACE`

## Layout

PL/SQL is often written using a tool called [Toad](https://en.wikipedia.org/wiki/Toad_(software)) in Defra. It includes the ability to automatically format code using imported `.opt` files.

We have [guidance on how to do this](/guides/plsql_auto_format_toad.md), and [defra_plsql_toad_fmt.opt](/guides/defra_plsql_toad_fmt.opt) that applies the layout conventions described below.

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
