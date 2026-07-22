# GitHub Copilot guide

This guide helps Defra developers get real value from [GitHub Copilot](https://github.com/features/copilot) while using it responsibly, efficiently and sustainably.

Copilot is an accelerator, not a replacement for your judgement. You remain accountable for every line you commit.

> **Sustainability note.** Copilot now runs on usage-based billing, with AI credits drawn from a shared organisational pool. Every prompt consumes energy and cost. Throughout this guide, blockquotes like this one highlight choices that reduce waste. Keep usage high where it adds value, but be deliberate.

The [Defra AI digital toolkit Copilot page](https://digital.defra.gov.uk/ai-toolkit/tools/github-copilot) provides additional organisational level guidance for GitHub Copilot, whereas this guide focuses on practical usage and best practices for developers.

## What is GitHub Copilot

GitHub Copilot is an AI pair programmer built into your editor and into GitHub. It uses large language models to suggest code, answer questions, and carry out multi-step tasks against your codebase.

You will mostly use it in three ways:

- **Inline completions.** Copilot suggests the next line or block as you type. This is the lightest-weight and lowest-cost way to use it.
- **Chat.** You ask questions or request changes in a chat panel, with your files as context. Good for explaining code, drafting changes and answering "how do I" questions.
- **Agent mode.** Copilot plans and carries out a multi-step task across several files, running tools on your behalf. The most powerful mode, and the most expensive, so reserve it for tasks that genuinely need it.

> **Sustainability note.** Prefer the lightest mode that will do the job. Completions cost far less than a long agent session. Reach for agent mode only when a task really spans multiple steps or files.

## Requesting a licence

### Defra developers

Licences are available to all permanent Defra developers and Resource Augmentation contractors. To request a licence raise a request with your Resource Manager or Principal Developer.

### Non-Defra developers

Licences are managed through the Cloud Centre of Excellence (CCoE) process, not by individual sign-up.

At a high level a delivery team needs to:

1. Request an Azure subscription service code.
2. Raise a CCoE Non-Production Service Request in MyPortal so a GitHub cost centre can be created and linked to the service code.
3. Include the Azure subscription service code and the GitHub handle of each person who needs a licence.

Follow the current, detailed steps on the [Defra AI digital toolkit Copilot page](https://digital.defra.gov.uk/ai-toolkit/tools/github-copilot), as the process and billing model change over time.

Copilot uses AI credits from a shared pool at organisation level. Unused credits from one person can be used by others, so efficient use directly benefits your colleagues.

> Organisations can use their own GitHub Copilot licence as long as they are not the free tier.

## Using Copilot across the SDLC

Copilot can support most stages of the software development lifecycle, for example:

- **Discovery and design:** exploring options, drafting architecture decision records, summarising unfamiliar code.
- **Coding:** completions, refactoring, boilerplate, and converting between patterns.
- **Testing:** generating and extending tests, and suggesting edge cases.
- **Review:** a first-pass review of your own changes before you raise a pull request.
- **Documentation:** READMEs, code comments where they add value, and runbooks.
- **Delivery:** drafting tickets, pull request descriptions and release notes.

Use it deliberately to support delivery. It is not an unlimited exploratory tool, and it does not remove the need to understand what you ship.

## Getting the most from the models

Model choice and settings have a large effect on quality, speed and cost. Tuning them is the single biggest thing you can do to work efficiently.

- **Choose the right model.** Use "Auto" if you are unsure. Reserve the most capable models (for example Opus-class models) for genuinely complex work. Simpler tasks run well, and far more cheaply, on lighter models.
- **Match Thinking Effort to the task.** Lower it for simple edits, raise it for hard reasoning problems.
- **Reduce Context Size for simple tasks.** A large context window is rarely needed for a small, local change.
- **Attach only relevant files.** More context is not better. It costs more and can dilute the answer.
- **Use instructions and skills** (see below) so you do not have to re-explain your standards every time.

> **Sustainability note.** Picking a lighter model, lowering Thinking Effort and trimming context are the most effective ways to cut token use. Using a top-tier model for a one-line change wastes shared credits and delivers no better result.

## Using Plan mode

Plan mode gets Copilot to research the problem, ask clarifying questions and agree an approach with you *before* it writes any code.

Use it for anything non-trivial:

1. Describe the goal and point Copilot at the relevant code.
2. Let it produce a plan and ask questions.
3. Review and correct the plan.
4. Only then let it implement.

Agreeing the approach up front avoids Copilot confidently building the wrong thing and having to redo it.

> **Sustainability note.** A short planning step is cheap. Rewriting a large change that went the wrong way is not. Planning first usually means fewer total tokens.

## Reducing repeated back-and-forth

Long chains of "no, not like that" corrections waste your time and shared credits. To reduce the ping-pong:

- **Front-load context.** Give the goal, constraints, relevant files and the definition of done in your first message.
- **Be specific.** "Add validation" invites guesswork. "Reject requests where `email` is missing or malformed, returning a 400 with the standard error shape" does not.
- **Refine the prompt, do not just retry.** If the first answer misses, improve the instruction rather than sending "try again".
- **Lean on instructions and skills** so recurring rules are always applied.
- **Start a fresh session for a new task.** Long threads carry stale context that confuses the model and inflates cost.

> **Sustainability note.** Each retry re-sends the whole conversation to the model. Fixing the prompt once is far cheaper than several rounds of trial and error.

## Using Copilot code review

Copilot can review changes and flag bugs, style issues and risks, both in your editor and on pull requests in GitHub.

Use it to:

- Sanity-check your own diff before you request a human review.
- Catch obvious issues early so human reviewers can focus on design and intent.

Copilot review supplements human review, it does not replace it. A person is still accountable for approving and merging, in line with the [pull requests process](../processes/pull_requests.md).

> **Sustainability note.** Run automated review on focused diffs rather than re-reviewing an entire codebase. Smaller, well-scoped changes are cheaper to review and easier for humans to approve.

## Writing effective instructions

Instruction files let Copilot follow your project's standards automatically, so you do not repeat them in every prompt.

- Put repository-wide rules in a `copilot-instructions.md` file.
- Use scoped `*.instructions.md` files with an `applyTo` pattern to target specific languages or folders.
- Keep rules short, specific and testable, in the same spirit as our [style guide for standards](style_guide_for_standards.md).
- Encode the things you find yourself correcting repeatedly.

Good instructions mean Copilot produces compliant code first time, which reduces corrective prompting.

> **Sustainability note.** A few lines of good instructions, loaded once, prevent many rounds of correction across the whole team. This is one of the highest-value efficiency investments you can make.

## Custom agents, skills and prompts

Beyond instructions, you can package reusable configuration:

- **Agents** are specialised personas with a defined role and workflow, for example a code reviewer or a tester.
- **Skills** are capability packages that agents load automatically based on what you are working on.
- **Prompts** are reusable templates for common tasks, such as writing an ADR or a security review.

Defra maintains ready-to-use examples that encode our software development standards:

- Browse them on the [Defra AI config examples site](https://defra.github.io/defra-ai-config-examples/).
- Get the source from the [defra-ai-config-examples repository](https://github.com/DEFRA/defra-ai-config-examples).

Copy the files that fit your project into your repository and adapt them to your context.

**Please contribute back.** This resource is still growing, and it becomes more useful as teams add and refine examples. If you build an agent, skill or prompt that others would benefit from, or you improve an existing one, raise a pull request on the [defra-ai-config-examples repository](https://github.com/DEFRA/defra-ai-config-examples) so the whole community gains.

## Creating tickets, backlog items and tasks

Copilot can turn a rough idea, a conversation or a diff into well-formed delivery artefacts:

- Draft user stories with clear acceptance criteria.
- Break an epic into smaller, deliverable tasks.
- Summarise a bug from logs or a stack trace into a reproducible ticket.

Always review the output. You are responsible for the accuracy, priority and scope of what lands in the backlog. Never paste sensitive or personal data into a prompt to generate a ticket.

## Supporting testing

Copilot is well suited to testing work:

- Generate unit and integration tests for existing code.
- Suggest edge cases and failure modes you may have missed.
- Follow project conventions for naming, structure and coverage when you provide them through instructions.

Treat generated tests critically. A test that passes but asserts the wrong thing is worse than no test. Check that each test proves the behaviour you actually care about, in line with our [quality assurance and test standards](../standards/quality_assurance_standards.md).

> **Sustainability note.** Ask for tests on a specific function or module rather than "write all the tests for this repo". Focused requests use fewer tokens and produce better, more relevant tests.

## Using Copilot for security

Copilot can help you find and fix security issues, but it is an aid, not an assurance:

- Ask it to review code against the [OWASP Top 10](https://owasp.org/www-project-top-ten/) and our [security standards](../standards/security_standards.md).
- Use it to explain a vulnerability and suggest a remediation.
- Use it to draft secure defaults, for example parameterised queries and input validation.

Important cautions:

- **Never** paste secrets, credentials, keys or personal data into a prompt.
- Do not assume generated code is secure. Verify it, and keep using [GitHub Advanced Security](github_advanced_security.md) and your normal review gates.
- Copilot can produce insecure or outdated patterns. Your security standards remain the source of truth.

## Learning with Copilot

Copilot is a powerful learning aid, particularly for developers who are new to a language, a framework or a codebase. Treat it as an augmented teacher, not just a code generator.

- Ask it to **explain** code, errors or concepts, not just to fix them.
- Ask "why" and "what are the trade-offs", so you build understanding rather than dependence.
- Use it to explore an unfamiliar part of the codebase before you change it.
- Cross-check what it tells you against official documentation and our standards, because it can be confidently wrong.

If you are early in your career, the goal is to grow your own skill. Understand every change before you accept it, so you could have written it yourself.

## Your responsibilities

- **You own the output.** Review and understand everything before you commit it.
- **Protect data.** Do not put secrets, credentials or personal or sensitive information into prompts. Follow the [AI tool guidance](https://defra.github.io/ai-sdlc-tool-guidance/) on privacy and data handling.
- **Verify claims and code.** Copilot can hallucinate APIs, facts and behaviour.
- **Use shared credits responsibly.** They come from a common pool that your colleagues also rely on.

## Getting help and sharing what you learn

- Contact the Defra AI Capability and Enablement team at [AICapabilityAndEnablement@defra.gov.uk](mailto:AICapabilityAndEnablement@defra.gov.uk).
- Share tips and patterns through the developer Community of Practice and the common Teams and Slack channels.
- We are all still learning how to use these tools well. Sharing what works, and what does not, helps everyone improve.

## Related resources

- [Defra AI digital toolkit: GitHub Copilot](https://digital.defra.gov.uk/ai-toolkit/tools/github-copilot)
- [Defra AI config examples](https://defra.github.io/defra-ai-config-examples/) and its [repository](https://github.com/DEFRA/defra-ai-config-examples)
- [Defra AI in the SDLC playbook](https://defra.github.io/defra-ai-sdlc/)
- [Defra AI tool guidance](https://defra.github.io/ai-sdlc-tool-guidance/)
- [GitHub Copilot customisation docs](https://docs.github.com/en/copilot/customizing-copilot)
- [Defra security standards](../standards/security_standards.md)

## Significant changes

Guide created 22 July 2026.
