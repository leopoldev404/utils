# Contributing to Project Name

## Table of Contents
1. [Getting Started](#getting-started)
2. [Code Style Guidelines](#code-style-guidelines)
3. [Commit Message Guidelines](#commit-message-guidelines)
4. [Branching and Pull Requests](#branching-and-pull-requests)
5. [Testing](#testing)
6. [Issue Reporting](#issue-reporting)

---

## Getting Started
1. Fork the repository.
2. Clone your fork.
    ```sh
    git clone https://github.com/your-username/project-name.git
    ```
3. Navigate to the project directory.
    ```sh
    cd project-name
    ```
4. Install dependencies.
    ```sh
    [command to install dependencies]
    ```

## Code Style Guidelines
- Write clean, readable, and maintainable code.
- Prefer readability and simplicity over syntactic sugar.
- Follow the [Microsoft C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions).
- Use meaningful names for variables, methods, and classes.
- Always use curly braces syntax.

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
    git switch -b feat/your-feature-name
    ```
2. Make your changes.
3. Ensure all tests pass.
4. Commit your changes using the specified commit message format.
5. Push your branch to your fork.
    ```sh
    git push origin feat/your-feature-name
    ```
6. Open a pull request to the `main` branch of the original repository.
7. Provide a clear description of your changes and any relevant issue numbers.

## Testing
- Write unit tests for all new features and bugfixes.
- Use xUnit for testing.
- Place unit tests in the `Unit` folder and integration tests in the `Integration` folder.
- Run all tests before submitting a pull request.
    ```sh
    [command to run tests]
    ```

## Issue Reporting
- Check if the issue has already been reported.
- Provide a clear and descriptive title.
- Include steps to reproduce the issue.
- Describe the expected and actual behavior.
- Provide any relevant screenshots or logs.
