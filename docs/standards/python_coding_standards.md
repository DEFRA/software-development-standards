# Python Standards

This document defines the internal development standards for building backend services in Python ([FastAPI](https://fastapi.tiangolo.com/tutorial/)) awithin Defra. It adheres strictly to the [UK Government Digital Service (GDS) Python style guide](https://gds-way.digital.cabinet-office.gov.uk/manuals/programming-languages/python/python.html) and [PEP 8](https://peps.python.org/pep-0008/), ensuring code is clear, consistent, and maintainable across all AI services (using tools like [LangChain](https://python.langchain.com/docs/introduction/), [LangGraph](https://langchain-ai.github.io/langgraph/tutorials/introduction/), etc.). All engineers must follow these conventions when writing Python code for backend services.

**Note:** Python should **ONLY** be used for creating backend services related to AI or data.

**Note:** Python should **NOT** be used for frontend development. The GDS Service Manual has information on using client-side JavaScript. For server-side JavaScript we use Node.js. The principles of [Progressive Enhancement](https://www.gov.uk/service-manual/technology/using-progressive-enhancement) should be used for the design and build of frontend digital services.

## Function Annotations and Typing Conventions
- Use Type Hints for All Functions: All function and method definitions should include Python type annotations for parameters and return values (PEP 484 style). This improves readability and helps static analysis.
 
    For example:

    ``` python
    def fetch_item(item_id: int, verbose: bool = False) -> dict[str, Any]:
        ...
    ```

    _In this example, `item_id` is an int, `verbose` is a bool with default False, and the function returns a dictionary mapping strings to any type._

- PEP 484 Syntax: Follow standard typing syntax for annotations:
    - Parameters: No space before the colon and one space after the colon in type annotations. Example: `def compute(score: float) -> None:`
    - Return Types: Use -> with a space on both sides of the arrow. If a function returns nothing (None), you can denote it as -> None (except for __init__, which implicitly returns None and need not be annotated).
    - Optional Types: Use `Optional[Type]` or `the Type | None` union syntax for parameters that can be null. For example: `def get_user(name: str, age: int | None = None) -> User | None:`.

- Typing Imports: If using complex types from the typing module (e.g. Dict, Tuple, List), prefer using built-in generic types available in Python 3.9+ (e.g. `dict[str, int]` instead of `Dict[str, int]`). Import typing constructs only if needed (and consider importing them under an `if TYPE_CHECKING:` block if they're only for type hints).

- Variable Annotations: For module-level or class variables that require a type without an immediate value, use variable annotations. 

    Example:
    ``` python
    from typing import List
    items: List[str] = []  # items is declared as a list of strings
    ```
    Follow the same spacing rules (no space before colon, one space after) for annotated variables.

- Avoid Redundant Annotations: Do not annotate `self` or `cls` in instance or class methods. It’s understood by convention.

    Example – using type hints in a FastAPI route function:
    ```python
        from fastapi import APIRouter, HTTPException
        from typing import Any

        router = APIRouter()

        @router.get("/items/{item_id}")
        def get_item(item_id: int, detail: bool = False) -> dict[str, Any]:
            """Retrieve an item by ID, with optional details."""
            item = {"id": item_id, "name": "Sample Item"}
            if detail:
                item["details"] = "This is a detailed description."
            return item
    ```

    _In this example, the function parameters and return type are clearly annotated. The FastAPI framework will use these annotations for data validation and documentation, and our linter will enforce their presence and correctness._

## Naming Conventions for Variables, Functions, and Classes

Consistent naming makes code more readable. We follow PEP 8/GDS naming conventions:

- Variables and Functions: Use snake_case (all lowercase with underscores). Names should be descriptive but concise. Examples: `response_data`, `calculate_score()`. Avoid single-character names except for trivial counters or indices in short loops.

- Classes: Use PascalCase (CapWords) for class names. Example: class `DataProcessor: ...`. Class names should typically be nouns or noun phrases. For classes representing exceptions, use PascalCase and end the name with “Error”. Example: `class DataLoadError(Exception): ...` (inherits from Exception). This makes it clear it's an error/exception.

- Constants: Constants (values meant to not change) are defined at module level and written in ALL_CAPS with underscores. Example: `MAX_RETRIES = 3`. Only define constants for truly fixed values (such as configuration defaults); use configuration files or environment variables for deploy-specific settings (see Constants and Configuration below).

- Private or Internal Names: To indicate a name is for internal use (non-public), begin it with a single leading underscore. This applies to variables, functions, or methods intended for internal module/class use only. Example: `_helper_function()` or `self._cache`. Avoid using double leading underscores (__name) unless necessary to avoid name conflicts in subclasses (double-underscore triggers name-mangling; use sparingly).

- Module and Package Names: Use short, all-lowercase names for modules (Python files) and packages (directories). You may use underscores in module names if it improves readability (e.g. `data_utils.py`), but avoid overly long names. Package names (directory names) should be lowercase and avoid underscores if possible. Each module should ideally contain a cohesive set of definitions (e.g. one module for database models, another for API routes).

    Example:
    ``` python
    # Constants (module-level)
    MAX_CONNECTIONS: int = 100
    DEFAULT_MODEL: str = "gpt-4"

    # Class name in CapWords
    class DataProcessor:
        """Processes input data and performs transformations."""
        def __init__(self, source: str):
            self.source = source          # instance variable (public)
            self._buffer = []             # internal variable (prefixed with _)

        def process(self) -> list[str]:
            # Function name in snake_case, with type hint for return
            ...
            return result_list

    # Exception class with 'Error' suffix
    class DataLoadError(Exception):
        """Exception raised when data loading fails."""
        pass

    # Function name in snake_case
    def load_data(file_path: str) -> str:
        """Load data from a file and return its contents as text."""
        ...
    ```
    _In this example, naming clearly indicates purpose: `DataProcessor` is a class, `DataLoadError` is an exception, `MAX_CONNECTIONS` is a constant, and load_data is a function. Variables like `source` and `result_list` use descriptive snake_case names._

## Import Styles and Structure
Organise imports in a consistent, readable manner. Our import guidelines (aligning with PEP 8 and GDS) are:

- Import Order: Group imports into three sections, each separated by a blank line:

    1. Standard library imports (e.g. os, sys, json).
    2. Third-party library imports (e.g. fastapi, sqlalchemy, langchain).
    3. Local application imports (your own modules/packages).
    This makes it easy to see which dependencies are standard vs external vs internal.

- One Import Per Line: Import one module per line. Avoid combining unrelated imports on the same line. 
    
    Example:
    ``` python
    import os  
    import sys  
    from datetime import datetime
    ```
    (Each import on its own line is clearer and makes diffs cleaner.)

- Absolute Imports: Prefer absolute imports (full path to modules) for clarity. For example, use `from myapp.utils import helpers` instead of relative imports like `from . import helpers`, unless the relative import greatly improves clarity in a complex package. (Standard library code always uses absolute imports.) In our projects, absolute imports are usually straightforward and preferred.

- Avoid Wildcard Imports: Do not use `from module import *`. Wildcard imports make it unclear which names are present and can lead to collisions. Instead, explicitly import what you need or import the module and use `module.name`. The only exception to this rule is if a module’s `__init__.py` uses wildcard import to expose its API (even then, that's handled within the package, not in application code).

- Import Aliases: Only alias imports if necessary to avoid name conflicts or for clarity. For example, if you import a module with a long name, you might do `import transformations_pipeline as pipeline` for convenience, but generally keep the original names for transparency.

- Ordering Within Sections: Within each import group, you can order alphabetically by module name to keep them sorted (our linter will do this automatically, minimising merge conflicts). For example, in third-party imports, `import numpy` should come before `import requests` (alphabetical).

    Import Ordering Example at top of a module:
    ``` python
    """Module for item routes and operations (routes/items.py)."""

    # Standard library imports
    import json
    import os
    from pathlib import Path

    # Third-party imports
    import requests
    from fastapi import APIRouter, HTTPException

    # Local application imports
    from app import config
    from app.models import Item
    from app.utils import calculate_score
    ```
    _In this example, imports are cleanly separated by category. The module docstring is at the top (as recommended), followed by imports. `os`, `json`, `Path` (stdlib) come first; FastAPI and requests (third-party) next; then local app imports._

## Handling Errors and Exceptions
Error handling in our services should be done using Python exceptions, following best practices:

- Use Exceptions for Errors: Do not use error codes or silent failures. If a function encounters an error condition it cannot handle, it should raise an exception. This allows the error to propagate and be handled by the caller or by FastAPI's global exception handlers (for HTTP requests).

- Catch Specific Exceptions: When catching exceptions, catch the specific exception types you expect. Avoid bare `except`: clauses, as they catch system-exiting exceptions (`SystemExit`, `KeyboardInterrupt`) and obscure the cause of errors. If you truly need to catch any exception, use `except Exception:` (which excludes `SystemExit` and `KeyboardInterrupt`). Even then, consider logging the exception and re-raising if not handling it meaningfully.

-Provide Informative Messages: When raising exceptions, include a clear message. For example: `raise ValueError("Threshold must be non-negative")` is more informative than just `raise ValueError`. In a FastAPI context, raising an `HTTPException(status_code, detail="...")` with a helpful message will return that info to API clients.

- Custom Exceptions: If you create custom exception classes (`subclassing` Exception), suffix their names with Error (e.g. `DataLoadError`) and use them to represent specific error situations in your domain. This makes it easy to distinguish them and catch them if needed.

- Finally and Cleanup: Use `try/except/finally` blocks to ensure resources are cleaned up (or use context managers, see below). If you catch an exception in order to perform cleanup or logging, you can re-raise the same exception with just `raise`, or `use raise new_exc from original_exc` to chain exceptions while preserving the traceback.

- Limit Scope of try Blocks: Only surround the code that might throw an exception with the try/except, not more. This avoids catching exceptions from code that wasn’t intended to be in the try. You can also use `try/except/else` – the `else` clause runs if no exception was raised, which can make the normal path clearer.

- Use Context Managers for Resources: Prefer the with statement to manage resources (files, locks, network connections) so that they are automatically closed or released, even if an error occurs. For example, use with open(filename) as f: instead of manually opening and closing with try/finally.

    Example – exception handling and raising:
    ``` python
    def process_file(path: str) -> str:
        """Read and process a file, returning its content as a string."""
        if not Path(path).exists():
            # Instead of returning an error code, raise an exception
            raise FileNotFoundError(f"File not found: {path}")
        try:
            with open(path, 'r') as file:  # ensures file closes on exit
                data = file.read()
            result = transform_data(data)
        except FileNotFoundError:
            # Catch a specific exception (file not found) if we want to handle it here
            logger.error(f"Unable to open the file at {path}")
            raise  # re-raise the exception after logging
        except Exception as err:
            # Catch any other unexpected exception, log it, and wrap in a custom error
            logger.exception("An unexpected error occurred during file processing")
            raise DataLoadError("Failed to process file") from err
        else:
            return result
    ```

## Use of Constants and Configuration
Managing constants and configuration in a consistent way is important for clarity and for separating code from environment-specific settings:

- Constants: As noted, define constants at the module level in uppercase. These might include things like default values, timeouts, or other parameters that are not expected to change at runtime. 

    For example:
    ``` python
    # In config.py or at top of module
    TIMEOUT_SECONDS = 30
    DEFAULT_MODEL = "gpt-4"
    ```
    Such constants should be grouped together for easy discovery. Do not redefine the same constant in multiple places; instead, import it from a single source (like a `config` module).

- Configuration Settings: Differentiate between constants and configuration:

    - Constants are fixed values for the program (e.g. an algorithm's default retry count).

    - Configuration settings are values that may change per environment or deployment (e.g. database URL, API keys, debug mode flag).

    Configuration should generally not be hard-coded in the source. Use environment variables, configuration files, or a dedicated config module to manage these. For example, you might use environment variables and load them in config.py:
    ``` python
    import os
    DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./app.db")
    DEBUG_MODE = os.getenv("DEBUG_MODE", "false").lower() == "true"

    ```
    In a FastAPI app, a common practice is to use Pydantic settings (BaseSettings) to define config classes that read from env variables. Either approach is fine, as long as sensitive info and environment-specific details are not hard-coded.

- No Magic Numbers/Strings: Avoid using unexplained literal numbers or strings in code. If a value has significance, give it a name as a constant. For instance, instead of using `if len(data) > 1024: ...`, define `MAX_PAYLOAD_SIZE = 1024` and use `if len(data) > MAX_PAYLOAD_SIZE:`. This makes the code self-documenting.

- Immutability: Treat constants as read-only. Do not modify constant values at runtime. If a configuration needs to change, it should be done via changing an environment variable or config file, not by reassigning an imported constant in code.

- Consistent Access: If using a config module or object, use it throughout the code. For example, if you have `config.py` with DATABASE_URL, always import and use `config.DATABASE_URL` rather than duplicating that logic in multiple modules.

    Example – config usage:

    ``` python
    # config.py
    import os

    # Constant values
    MAX_WORKERS = 5              # a constant for thread pool size, for example
    DEFAULT_TIMEOUT = 10.0       # seconds

    # Configuration from environment
    ENV = os.getenv("ENV", "development")
    DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://localhost:5432/mydb")
    API_KEY = os.getenv("API_KEY")  # (no default here; if not provided, it might result in an error elsewhere)
    ```

    ``` python
    # Using the config in another module
    from app import config

    def connect_to_db():
        url = config.DATABASE_URL  # use configuration from central config
        timeout = config.DEFAULT_TIMEOUT  # use constant
        ...
    ```

    _In these examples, `config.py` centralises constants and configuration. Other modules import from config instead of defining their own values. All constant names are uppercase, whereas configuration variables that might change (like `ENV`, `DATABASE_URL`) are also represented as variables in uppercase for consistency (since they act like constants within the running application)._

## File and Module Structure
Organise project files and modules to promote clarity and reusability:
- Module Responsibilities: Each Python file (module) should have a clear purpose. For example, in a FastAPI project, you might have separate modules for routing (`routes.py` or a package of route modules), database models (`models.py`), schema definitions, utility functions, etc. Avoid giant modules that handle many unrelated concerns – instead, create packages or sub-modules as needed to group functionality.

- Module Naming: As noted in naming conventions, module filenames should be lowercase (and use underscores if it improves readability). For example: `database.py`, `user_routes.py`, util_helpers.py. Module names should ideally be nouns or noun phrases reflecting their content.

- Package Structure: Lay out the package directory structure to mirror the logical structure of the application. A typical FastAPI service might look like:

    ```
    app/
    ├── main.py              # application entry point (creates FastAPI app, includes event handlers)
    ├── api/
    │   ├── __init__.py
    │   ├── users.py         # route definitions for user-related endpoints
    │   └── items.py         # route definitions for item-related endpoints
    ├── models/
    │   ├── __init__.py
    │   └── item.py          # data model or Pydantic model for Item
    ├── services/
    │   └── data_processing.py   # business logic, e.g., functions to process data
    ├── utils/
    │   └── helpers.py       # utility functions
    ├── config.py            # configuration settings and constants
    └── __init__.py
    ```
    In this structure:

    - main.py creates the FastAPI app and includes startup logic.

    - api/ package contains route modules (each grouping related endpoints).

    - models/ for data models (could be ORMs or Pydantic models).

    - services/ for business logic not tied to FastAPI specifics (e.g., functions to call AI models or process data).

    - utils/ for utility functions.

    - config.py for configuration and constants.

    This is just an example; the key point is to separate concerns into different files/directories so that each module is cohesive.

    - Module Content Order: Within a module, a common order is:

        1. Module docstring (if the module has overall documentation).
        2. Imports (grouped as described in Import Styles).
        3. Module-level constants and global variables (if any, e.g. configuration constants).
        4. Declarations: classes, then functions (public API first, internal helpers later). If a module serves as a script, the if `__name__ == "__main__":` block goes at the bottom.

    - Avoid Circular Imports: Organise modules to prevent circular 
    dependencies. If two modules need to reference each other, consider refactoring or using lazy imports within functions to break the cycle.

    - Init Files: Use `__init__.py` in packages to control what is exported (via `__all__`) and to maybe initialise package-level logic. Keep `__init__.py` simple (mostly import statements or simple constants) – heavy logic in `__init__.py` can cause import side-effects and confusion.

    By following a clear file structure, new engineers can navigate the codebase easily. It should be obvious where to find route definitions, data models, configs, etc., based on file and folder naming.