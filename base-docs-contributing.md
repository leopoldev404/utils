# Contributing to Service

## Table of Contents
1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Code Style Guidelines](#code-style-guidelines)
4. [Commit Message Guidelines](#commit-message-guidelines)
5. [Branching and Pull Requests](#branching-and-pull-requests)
6. [Testing](#testing)
7. [Issue Reporting](#issue-reporting)

---

## Code of Conduct

## Getting Started
1. Fork the repository.
2. Clone your fork.
    ```sh
    git clone https://github.com/your-username/email-processor-service.git
    ```
3. Navigate to the project directory.
    ```sh
    cd email-processor-service
    ```
4. Install dependencies.
    ```sh
    dotnet restore
    ```
5. Create a new branch for your feature or bugfix.
    ```sh
    git checkout -b feature/your-feature-name
    ```

## Code Style Guidelines
### General Guidelines
- Write clean, readable, and maintainable code.
- Follow the [Microsoft C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions).
- Use meaningful names for variables, methods, and classes.
- Always prefer readability and simplicity over syntactic sugar

### C# 12 and .NET 8 Specific Guidelines
- Leverage new features in C# 12 and .NET 8 when appropriate, but ensure they are used appropriately and consistently.
- Ensure all public methods and classes have XML documentation comments.
- Use expression-bodied members for single-line methods and properties.
- Prefer pattern matching and switch expressions where applicable.

### Naming Conventions
- **Classes and Interfaces**: PascalCase
    ```csharp
    public class EmailProcessorService
    {
    }
    ```
- **Methods**: PascalCase
    ```csharp
    public void ProcessEmails()
    {
    }
    ```
- **Variables and Parameters**: camelCase
    ```csharp
    private string emailAddress;
    ```
- **Constants**: PascalCase
    ```csharp
    private const int DefaultInterval = 2;
    ```

### Code Formatting
- Use 4 spaces for indentation.
- Place curly braces on a new line.
    ```csharp
    if (condition)
    {
        // code
    }
    ```
- Keep lines under 120 characters.

### Commenting
- Use XML documentation comments for all public members.
    ```csharp
    /// <summary>
    /// Processes the emails in the specified folder.
    /// </summary>
    /// <param name="folderId">The ID of the folder.</param>
    public void ProcessEmails(string folderId)
    {
    }
    ```
- Use regular comments for explaining complex logic and non-obvious code.
    ```csharp
    // This is a workaround for issue #123
    ```

## Commit Message Guidelines
- Use the format `type(scope): message`.
    - **type**: The kind of change (e.g., `feat`, `fix`, `refac`).
    - **scope**: The module or component that has been changed.
    - **message**: A short, clear description of the change.
- Example commit messages:
    ```plaintext
    feat(email-reader): add support for reading emails from multiple folders
    fix(blob-storage): resolve issue with file upload timeout
    refac(attachment-processor): improve file processing efficiency
    ```

## Branching and Pull Requests
1. Create a new branch for each feature or bugfix.
    ```sh
    git checkout -b feature/your-feature-name
    ```
2. Make your changes.
3. Ensure all tests pass.
4. Commit your changes using the specified commit message format.
5. Push your branch to your fork.
    ```sh
    git push origin feature/your-feature-name
    ```
6. Open a pull request to the `main` branch of the original repository.
7. Provide a clear description of your changes and any relevant issue numbers.

## Testing
- Write unit tests for all new features and bugfixes.
- Use xUnit for testing.
- Place unit tests in the `Unit` folder and integration tests in the `Integration` folder.
- Run all tests before submitting a pull request.
    ```sh
    dotnet test
    ```

## Issue Reporting
- Check if the issue has already been reported.
- Provide a clear and descriptive title.
- Include steps to reproduce the issue.
- Describe the expected and actual behavior.
- Provide any relevant screenshots or logs.
