# PL/SQL Auto-format with TOAD

[Toad](https://en.wikipedia.org/wiki/Toad_(software)) is a

> [..] database management toolset from Quest Software that database developers, database administrators, and data analysts use to manage both relational and non-relational databases using SQL.

Some teams in Defra have licenses for Toad, and use it when working with our Oracle databases.

We have a [standard for PL/SQL](/standards/plsql_standards.md) which can be applied automatically using the auto-format tool in Toad.

## The format file

In these guides is an auto-format `.opt` file that can be used called [defra_plsql_toad_fmt.opt](defra_plsql_toad_fmt.opt).

## Importing the file

In Toad, open an Editor window. Right click on the editor pane and select `Formatting Tools > Formatting Options`.

Select the file open icon at the top left of the screen ("Load options from file" is the tool tip) and then browse to where you have located a copy of the file. Select the file then hit "Apply". Then hit "OK" to close the formatter options window.

## Applying the format

To apply the formatter options to any SQL or PL/SQL code open the code in the Editor Window, right click and then select `Formatting Tools > Format`.
