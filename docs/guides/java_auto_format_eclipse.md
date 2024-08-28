# Java Auto-format with Eclipse

[Eclipse](https://en.wikipedia.org/wiki/Eclipse_(software)) is an

> integrated development environment (IDE) used in computer programming. It contains a base workspace and an extensible plug-in system for customizing the environment. Eclipse is written mostly in Java and its primary use is for developing Java applications, but it may also be used to develop applications in other programming languages via plug-ins.

We have a [standard for Java](../standards/java_coding_standards.md) which can be applied automatically when saving a file in Eclipse.

## The format file

In these guides is a 'code style' `.xml` that can be used called [defra_java_eclipse_code_style.xml](defra_java_eclipse_code_style.xml).

## Importing the file

In Eclipse, select `Windows > Preferences > Java > Code Style > Formatter > Import`.

Select the file and then apply the change.

## Applying the format on save

In Eclipse, select `Windows > Preferences > Java > Editor > Save Actions` and then check

- `Perform the selected actions on save`
- `Format source code`
