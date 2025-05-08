# C# Standards

This document outlines the standards for writing C# code at Defra. To ensure consistency and maintainability, we align with Microsoft's official C# standards and best practices.

## Key Principles

1. **Alignment with Microsoft Standards**:
   - Follow Microsoft's official C# coding conventions for:
     - Naming conventions
     - Indentation
     - Code formatting
     - Linting
   - Refer to the following resources:
     - [C# Coding Conventions](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions)
     - [Framework Design Guidelines](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/)

2. **Modern C# Practices**:
   - Use modern C# features such as:
     - `async`/`await` for asynchronous programming.
     - Nullable reference types (`string?`) to avoid null reference exceptions.
     - Pattern matching for cleaner and more readable code.
     - Records for immutable data models.
   - Avoid outdated practices and legacy patterns unless required for compatibility.

3. **SOLID Principles**:
   - Follow the **SOLID principles** to ensure your code is maintainable, scalable, and easy to understand. These principles are:
     - **S - Single Responsibility Principle (SRP)**:
       - A class should have only one reason to change. Each class should focus on a single responsibility or functionality.
     - **O - Open/Closed Principle (OCP)**:
       - Classes should be open for extension but closed for modification. This allows new functionality to be added without altering existing code.
     - **L - Liskov Substitution Principle (LSP)**:
       - Subtypes must be substitutable for their base types without altering the correctness of the program.
     - **I - Interface Segregation Principle (ISP)**:
       - A class should not be forced to implement interfaces it does not use. Large interfaces should be split into smaller, more specific ones.
     - **D - Dependency Inversion Principle (DIP)**:
       - High-level modules should not depend on low-level modules. Both should depend on abstractions, often achieved through dependency injection.

   For a detailed explanation of the issues with violating SOLID principles, refer to [Microsoft's overview](https://learn.microsoft.com/en-us/archive/msdn-magazine/2014/may/csharp-best-practices-dangers-of-violating-solid-principles-in-csharp).

4. **Testing**:
   - Write unit tests for all business logic.
   - Use mocking frameworks for dependency isolation.
   - Focus on meaningful code coverage rather than arbitrary metrics.

## Additional Resources

For further guidance, refer to the following Microsoft resources:
- [C# Language Reference](https://learn.microsoft.com/en-us/dotnet/csharp/)
- [Asynchronous Programming in C#](https://learn.microsoft.com/en-us/dotnet/csharp/async)
- [Secure Coding Guidelines for .NET](https://learn.microsoft.com/en-us/dotnet/standard/security/secure-coding-guidelines)
- [Common Web Application Architectures in .NET](https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/common-web-application-architectures) (for general C# architecture guidance)
