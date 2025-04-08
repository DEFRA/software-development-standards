# .NET Standards

At Defra, we use .NET as a secondary technology stack, with **Node.js** being our primary stack. The use of .NET must be justified with an **evidence-based decision**. This document outlines the standards for using .NET within Defra, ensuring alignment with modern practices and Microsoft's best practices.

## Key Principles

1. **Primary Stack Preference**:
   - **Node.js** is the preferred stack for all new projects.
   - The decision to use .NET must be supported by clear evidence, such as:
     - Integration with commodity products that require .NET.
     - Specific backend service requirements that are better suited to .NET.

2. **Backend Services Only**:
   - .NET is only used for **backend services** and **integration with commodity products**.
   - **Frontend applications** must not be developed using .NET.

3. **C# Language**:
   - All .NET development must use the **C# language**.
   - Refer to the [C# Standards](csharp_coding_standards.md) for language-specific guidelines.

4. **Long-Term Support (LTS)**:
   - Always strive to use the latest **LTS version** of .NET.
   - **.NET Framework** should only be used for maintaining legacy applications. New projects must use **.NET 8+**.

## When to Use .NET Over Node.js

While Node.js is the preferred stack, there are scenarios where .NET may be better suited:

1. **Integration with Microsoft Ecosystem**:
   - Some parts of the Microsoft ecosystem are easier to integrate with when using .NET. For example:
     - Dynamics 365, which has strong support for .NET libraries and SDKs.

2. **High-Performance Backend Services**:
   - .NET is well-suited for CPU-intensive operations, such as:
     - Complex mathematical computations.
     - Image or video processing.
     - Real-time data analysis.
   - The Just-In-Time (JIT) compilation and runtime optimizations in .NET can outperform Node.js in these scenarios.

3. **Need for a Strongly Typed Language**:
   - When the project requires a strongly typed language to reduce runtime errors and improve maintainability, .NET (with C#) is a better choice. The static typing system in C# helps catch errors at compile time, making it ideal for complex systems with strict type requirements.

4. **Large-Scale Multi-Layer Monolith**:
   - For large-scale, multi-layered monolithic applications that require:
     - Clear separation of concerns (e.g., presentation, business logic, and data access layers).
     - Advanced tooling for debugging and profiling.
   - .NET provides a robust framework and ecosystem to support such architectures effectively.

5. **Cross-Platform Desktop Applications**:
   - If backend services need to complement cross-platform desktop applications built with .NET technologies like:
     - WPF (Windows Presentation Foundation).
     - WinForms.
     - MAUI (Multi-platform App UI).
   - .NET ensures seamless integration between the desktop and backend.

## Best Practices

To ensure consistency and maintainability, follow Microsoft's official guidelines for .NET development:
- [Microsoft .NET Documentation](https://learn.microsoft.com/en-us/dotnet/)
- [Best Practices for .NET Applications](https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/)
- [Secure Coding Guidelines for .NET](https://learn.microsoft.com/en-us/dotnet/standard/security/secure-coding-guidelines)
