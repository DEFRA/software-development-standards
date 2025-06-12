# Python Standards

This document defines the internal development standards for building backend services in Python ([FastAPI](https://fastapi.tiangolo.com/tutorial/)) within Defra. It adheres strictly to the [UK Government Digital Service (GDS) Python style guide](https://gds-way.digital.cabinet-office.gov.uk/manuals/programming-languages/python/python.html) and [PEP 8](https://peps.python.org/pep-0008/), ensuring code is clear, consistent, and maintainable across all AI services (using tools like [LangChain](https://python.langchain.com/docs/introduction/), [LangGraph](https://langchain-ai.github.io/langgraph/tutorials/introduction/), etc.). All engineers must follow these conventions when writing Python code for backend services.

**Note:** Python should **ONLY** be used for creating backend services related to AI or data science. For frontend services, use Node.js using the following [Node.js](https://defra.github.io/software-development-standards/standards/node_standards/) and [Javascript](https://defra.github.io/software-development-standards/standards/javascript_standards/) Defra standards.

## Environments
These standards advises the use of uv to manage different versions of Python you have installed.

To create virtual environments call `uv venv -p python3.13` from your project root directory. This will create a virtual environment with that specific python version in a folder called `.venv`. This folder should be excluded in your `.gitignore` file. For more information see [Python virtual environment primer](https://realpython.com/python-virtual-environments-a-primer/)

## Linting

### Ruff
These standards advises the use of the [Ruff](https://docs.astral.sh/ruff/) command line checker as an all in one formatter, linter, codestyle and complexity checker.


## Function Annotations and Typing

- All public functions must include type annotations for parameters and return types.
- Use standard [PEP 484](https://peps.python.org/pep-0484/) typing syntax.
- Function definitions should format parameters and return types as follows:

    ```python
    def get_item(item_id: int, detail: bool = False) -> dict[str, str]:
        ...
    ```
- Annotate variables where the type is not immediately clear:

    ```python
    items: list[str] = []
    ```
- Optional types should be annotated with | None or Optional from typing:
    ```python
    def get_user(user_id: int | None = None) -> dict[str, str] | None:
        ...
    ```

- There should be no spaces before the colon and exactly one space after.

    ```python
    def greet(name: str) -> str:
        return f"Hello {name}"
    ```

## Naming Conventions

- Variables and functions: Use snake_case.
- Classes: Use PascalCase.
- Constants: Use UPPER_CASE.

    Example:
    ```python
    MAX_RETRIES = 3

    def calculate_total(items: list[int]) -> int:
        return sum(items)

    class DataProcessor:
        pass
- Private members should start with a single underscore (_).
- Exception class names should end in Error.

    ```python
    class ValidationError(Exception):
        pass
    ```

## Import Style

- Imports must be grouped in the following order:

    1. Standard library imports

    2. Third-party imports

    3. Local application imports

- Each group must be separated by one blank line.

    Example:
    ```python
    import os
    import sys

    from fastapi import FastAPI
    import requests

    from app.models import User
    from app.services import user_service
    ```

- Imports should be one per line.

- Absolute imports should be used.

- Wildcard imports (`from module import *`) should not be used.

## Error Handling

- Specific exceptions should be caught rather than using a bare `except:`.

- When raising exceptions, include an informative error message.

- Exceptions that represent a domain-specific error should subclass `Exception` and be suffixed with `Error`.

    Example:
    ```python
    from fastapi import HTTPException

    def fetch_data(url: str) -> str:
        try:
            response = requests.get(url)
            response.raise_for_status()
        except requests.RequestException as exc:
            raise HTTPException(status_code=500, detail=str(exc))
        return response.text
    ```

## File and Module Structure

- Modules and packages must use short, all-lowercase names. Underscores can be used if necessary.

- Each module must have a single, clear responsibility.

    Example project structure:
    ```

    app/
    ├── main.py
    ├── api/
    │   ├── users.py
    │   └── items.py
    ├── models/
    │   └── user.py
    ├── services/
    │   └── user_service.py
    ├── utils/
    │   └── helpers.py
    ├── config.py

    ```
## Constants and Configuration

- Constants must be defined using UPPER_CASE.

- Configuration values should be loaded from environment variables where possible.

    Example:
    ```python
    import os

    MAX_RETRIES = 5
    DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./test.db")
    ```

- Hard-coded configuration values should be avoided.