# Coding principles

These are common principles that apply to coding.

## Rationale

- Ensure consistency across coding standards for different languages
- Provide a reference point to justify coding standards

## Principles

### Main is always shippable

> The main branch(s) of a project is always in a state of 'shippable to production'

We always maintain a golden copy of our code that is considered complete and production ready.
It has sufficient tests, matches agreed styles, doesn't break the build, has documentation, and is our best solution at the time of committing.

- This allows us to iterate safely ('Start small')
- It minimises problems during delivery
- It prevents overload of work due to mixing of production issues and feature development ('Minimise work in progress')

### The code is not yours

> We write and commit code thinking of someone else, not ourselves

When writing code you should be thinking of the next developer who has to work with it, who may be your future self, another member of the team, or someone completely new.

They will not have the understanding and context you do at the time of writing it, so when they're amending or refactoring your work later it is important they can derive the intent of what your code is doing.

### Work in the open

> Our code is open as early as possible. We only go private if we really, really, **really** have to!

- Encourages good discipline
- Increased sharing and collaboration
- It makes things better
- It improves the overall security of code

### Code securely

> We incorporate good security practice in all our code

### We test our code

> We are always able to prove that our code works and functions correctly with an automated test suite

- It is usually self documenting
- Increases quality
- Provides confidence in the implementation
- Enables safe refactoring and code improvements
- Catches bugs early when they're cheaper to fix
