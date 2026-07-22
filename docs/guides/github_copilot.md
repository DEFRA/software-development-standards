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

### Choose the right model

**If in doubt, use "Auto".** It automatically picks a suitable model for your task based on availability and complexity, and on paid plans it qualifies for a discount on model costs. It's a safe default for almost everything you do.

For times you want to pick deliberately, here's what each model is best at:

| Model | Best for | Avoid for (use instead) | Notes |
| --- | --- | --- | --- |
| **Auto** | Everyday tasks, or whenever you're unsure | Nothing, it's always a safe choice | Automatically balances quality, speed and cost; discounted credit usage on paid plans |
| **Claude Opus** | Deep reasoning, hard bugs, complex multi-file refactors, architecture decisions | Trivial edits and quick questions (use Haiku, GPT mini or MAI Code 1 Flash) | Anthropic's most capable model, but also the slowest and most expensive, so reserve it for genuinely hard problems |
| **Claude Sonnet** | General-purpose coding and agentic, multi-step tasks, balanced everyday work | Very complex architecture-level reasoning (use Opus), trivial one-liners (use Haiku) | A strong all-round default with a good balance of quality and cost |
| **GPT Codex** | Agentic software engineering: features, tests, debugging and refactors, especially work with heavy tool use | Casual questions and documentation-only tasks | Purpose-built for coding agent workflows |
| **Claude Haiku** | Fast, lightweight tasks: small functions, syntax questions, quick explanations, prototyping | Complex reasoning and large refactors (use Opus or Sonnet) | The fastest and cheapest Claude model, good for high-frequency small requests |
| **GPT mini** | A reliable default for everyday coding and writing, and lighter debugging or reasoning | Deep architecture-level reasoning (use Opus or Sonnet), heavy multi-tool agent work (use Codex) | Good cost and quality balance, works well across languages |
| **MAI Code 1 Flash** | Fast, adaptive everyday coding, strong instruction-following, multi-turn development workflows | Long, complex reasoning chains and large-scale refactors (use Opus or Sonnet) | Fast and concise, and continuously improving |

Model names and their exact strengths change often. See [GitHub's AI model comparison](https://docs.github.com/en/copilot/reference/ai-models/model-comparison) for the current, detailed picture.

### Other settings

- **Match Thinking Effort to the task.** Lower it for simple edits, raise it for hard reasoning problems.
- **Reduce Context Size for simple tasks.** A large context window is rarely needed for a small, local change.
- **Attach only relevant files.** More context is not better. It costs more and can dilute the answer.
- **Use instructions and skills** (see below) so you do not have to re-explain your standards every time.

> **Sustainability note.** Picking a lighter model, lowering Thinking Effort and trimming context are the most effective ways to cut token use. Using Opus for a one-line change wastes shared credits and delivers no better result than Haiku, GPT mini or MAI Code 1 Flash.

## Using Plan mode

Plan mode gets Copilot to research the problem, ask clarifying questions and agree an approach with you *before* it writes any code.

Use it for anything non-trivial:

1. Describe the goal and point Copilot at the relevant code.
2. Let it produce a plan and ask questions.
3. Review and correct the plan.
4. Only then let it implement.

Agreeing the approach up front avoids Copilot confidently building the wrong thing and having to redo it.

### What to use it for

Plan mode earns its keep on work that spans several steps or files, or where the right approach is not obvious. Good candidates include:

- Building a feature that touches several files or layers.
- Refactoring that is more than a rename, for example changing a pattern across a module.
- Investigating a bug where the cause is not yet clear.
- Making a change in an unfamiliar part of the codebase.
- Integrating a new library or external service.
- Designing an API, schema or data-model change before you commit to it.
- Breaking an epic or large ticket into smaller, deliverable tasks.

For a trivial, local edit you do not need Plan mode. Just make the change.

### Getting a better plan

The quality of the plan depends on what you give Copilot. A few habits produce a stronger plan that needs less correction later:

- **State the goal, constraints and definition of done** in your first message, so the plan aims at the right target. See [reducing repeated back-and-forth](#reducing-repeated-back-and-forth) for more on front-loading context.
- **Say what is out of scope.** Naming non-goals stops the plan sprawling into changes you did not want.
- **Name the files and areas involved**, so Copilot researches the right code rather than guessing.
- **Ask it to research first and to ask questions** before proposing anything. A plan built on questions answered is better than one built on assumptions.
- **Ask for edge cases, risks and a verification approach**, not just the happy path. This surfaces gaps while they are still cheap to fix.
- **Iterate on the plan, not the code.** Correct the approach while it is still a plan. Adjusting a few bullet points is far cheaper than reworking a finished change.
- **Let instructions and skills carry your standards.** If your repository has a `copilot-instructions.md` or scoped instruction files, they apply automatically during planning, so you do not need to repeat conventions in every prompt. See [writing effective instructions](#writing-effective-instructions).

### Reference context, do not paste it

Copilot can read your workspace directly, so point it at context instead of pasting large blocks of code into the chat. Referencing is cheaper, stays current and keeps links intact.

- **Reference files, folders and symbols** using the editor's attach and mention features, or ask Copilot to search the workspace or codebase for the relevant code.
- **Point at existing code that models the pattern to follow**, so the plan matches your conventions.
- **Link issues, pull requests and documentation URLs** rather than copying their contents.
- **Avoid pasting large blobs.** They cost tokens, go stale as the code changes, and lose the links back to the real files.
- **Never paste secrets, credentials or personal data**, in line with [your responsibilities](#your-responsibilities).

### Giving it a spec

If you have a specification, use it to anchor the plan:

- **Point Copilot at a spec, ticket or architecture decision record** already in the repository, so the plan is grounded in an agreed source.
- **Link the acceptance criteria and any design docs**, and ask the plan to address each criterion.
- **Ask Copilot to restate the spec back to you** before it plans, so you can catch any misreading early.
- **Keep the spec in the repository** where it is versioned and easy to reference again, rather than living only in a chat message.

> **Sustainability note.** A short planning step is cheap. Rewriting a large change that went the wrong way is not. Planning first, on referenced context rather than pasted blocks, usually means fewer total tokens.

## Reducing repeated back-and-forth

Long chains of "no, not like that" corrections waste your time and shared credits. Most back-and-forth traces back to one of three causes: a prompt that left too much to guesswork, a convention that should have been encoded in configuration rather than repeated in every prompt, or a thread that accumulated stale context from earlier in the conversation.

### Write a prompt that leaves less to guesswork

The more a prompt leaves open, the more Copilot has to infer, and the more likely it is to infer something different from what you wanted.

- **Front-load context.** Give the goal, constraints, relevant files and the definition of done in your first message. Copilot cannot ask clarifying questions unless you ask it to, so put the information up front.
- **Be specific.** "Add validation" invites guesswork. "Reject requests where `email` is missing or malformed, returning a 400 with the standard error shape from `src/errors.js`" does not.
- **Avoid ambiguity.** Say `the createUser function`, not "this". Name the library or pattern you want; do not assume Copilot will infer it from context.
- **Give examples.** For anything non-obvious, include a sample input and expected output, or point to an existing function that shows the pattern to follow.
- **Break large asks into steps.** Asking for an entire feature in one prompt almost always produces something that needs substantial correction. Ask for one layer or concern at a time.
- **Refine the prompt, do not just retry.** If the first answer misses, improve the instruction rather than sending "try again". A better prompt is cheaper than several rounds of correction.

### Encode recurring corrections in configuration

If you find yourself correcting the same things repeatedly, the right fix is to encode those rules so Copilot applies them automatically, not to repeat them in every prompt.

[Writing effective instructions](#writing-effective-instructions) explains how to create instruction files that carry your project's conventions into every session. [Custom agents, skills and prompts](#custom-agents-skills-and-prompts) goes further, covering reusable prompt templates and specialised agents that already know the right approach. These are the most sustainable fixes: a few lines of configuration, applied once, prevents corrections across the whole team.

### Keep conversation history clean

Chat history shapes what Copilot does next. A long thread full of dead ends and failed attempts is noise that inflates cost and can steer the model in the wrong direction.

- **Delete stale or dead-end messages** within a session. If a response went in completely the wrong direction, remove it so it does not pollute subsequent turns.
- **Start a fresh session for a new task.** Long threads carry context from earlier work that has no relevance to your current ask.

### Agree the approach before writing code

The most expensive back-and-forth is whole-approach rework: Copilot builds something substantial and you realise it went the wrong way. [Using Plan mode](#using-plan-mode) explains how to get Copilot to research, ask questions and agree an approach with you before it writes anything. Correcting a plan costs far less than rewriting finished code.

> **Sustainability note.** Each correction round re-sends the entire conversation to the model. Five rounds of "not quite, try again" can cost several times more than a single well-formed prompt. Instructions and skills prevent those corrections team-wide, making them one of the highest-value investments you can make in sustainable credit use.

## Using Copilot code review

Copilot can review changes and flag bugs, style issues and risks, both in your editor and on pull requests in GitHub.

Use it to:

- Sanity-check your own diff before you request a human review.
- Catch obvious issues early so human reviewers can focus on design and intent.

### Requesting a review on a pull request

On the pull request page, find the "Reviewers" section in the right sidebar. Next to "Copilot", click "Request". The review is usually ready within 30 seconds.

Copilot leaves a "Comment" review, not an "Approve" or "Request Changes" review, so its feedback does not count toward required approvals and will not block merging. It flags issues inline and, where possible, includes a one-click suggested fix you can apply directly.

You can also request a review through the GitHub CLI: `gh pr create --reviewer @copilot` when opening a new pull request, or `gh pr edit PR-NUMBER --add-reviewer @copilot` on an existing one.

### Automatically including Copilot as a reviewer

To add Copilot automatically to every pull request in a repository, set up a branch ruleset:

1. Go to the repository's **Settings > Rules > Rulesets** and click **New branch ruleset**.
2. Choose your target branches, for example "Include default branch".
3. Under "Branch rules", enable **Automatically request Copilot code review**.
4. Optionally enable **Review new pushes** so Copilot re-reviews on each subsequent commit, or **Review draft pull requests** to catch issues before a human reviewer is involved.
5. Click **Create**.

The Copilot code review feature must be enabled in the organisation's Copilot policy settings before it appears as a reviewer option. Contact a GitHub organisation admin if it is not visible.

### Credits

Copilot code reviews draw from the shared organisational AI credits pool. Attribution follows a simple rule: for automatic reviews, the credits are charged to the pull request author; for manually requested reviews, they are charged to whoever clicked "Request". Each review consumes a meaningful number of credits, so enabling automatic re-review on every push should be a deliberate choice.

### Instructions help the reviewer

Your repository's instruction files apply automatically during code review, so Copilot checks your changes against your project's own conventions rather than generic defaults. A `copilot-instructions.md` file can direct it to apply your security checklist, enforce specific patterns, or focus on the areas that matter most to your team. Path-specific `*.instructions.md` files apply only when reviewing files that match their scope.

See [Writing effective instructions](#writing-effective-instructions) for guidance on creating and structuring them.

During a pull request review, Copilot reads instructions from the head branch (your feature branch), not the base branch. This means you can test changes to your instruction files in the same pull request without merging them first.

Copilot review supplements human review, it does not replace it. A person is still accountable for approving and merging, in line with the [pull requests process](../processes/pull_requests.md).

> **Sustainability note.** Run automated review on focused diffs rather than re-reviewing an entire codebase. Smaller, well-scoped changes are cheaper to review and easier for humans to approve.

## Writing effective instructions

Instruction files let Copilot follow your project's standards automatically, so you do not repeat them in every prompt. They are committed to the repository, apply to everyone on the team, and take effect the moment you save them. Good instructions mean Copilot produces compliant code first time, which reduces corrective prompting.

### The kinds of instruction file

There are three kinds, and you can use them together:

- **Repository-wide instructions.** A single `.github/copilot-instructions.md` file, written in Markdown, that applies to every request in the repository. Use it for standards that hold everywhere: language, formatting, security expectations and how to build and test.
- **Path-specific instructions.** One or more `NAME.instructions.md` files under `.github/instructions/`. Each starts with a frontmatter block containing an `applyTo` glob so it only loads for matching files. Separate multiple patterns with commas. Use these for rules that apply to one language, folder or layer.
- **Agent instructions.** One or more `AGENTS.md` files, placed anywhere in the tree, where the nearest file takes precedence. These are read by coding agents and are a good home for build, test and repository-layout facts.

```markdown
---
applyTo: "**/*.ts,**/*.tsx"
---
```

When more than one file applies, all of them are provided to Copilot. Personal instructions take priority, then repository instructions, then organisation instructions. Avoid writing rules that contradict each other, because conflicting instructions produce unpredictable results.

> On GitHub.com, path-specific instructions currently apply only to Copilot code review and the Copilot coding agent. In your editor they apply across chat and agent sessions.

### What to put in them

Encode the things you would otherwise explain in every prompt, or correct in every review:

- **How to build, test and lint**, including the exact commands and any required setup steps.
- **Conventions** for naming, structure, error handling and logging.
- **Patterns to follow**, ideally by pointing at an existing file that models the approach rather than describing it in prose.
- **Security expectations**, such as parameterised queries, input validation and the checks from your security standards.
- **Non-negotiables**, the rules you never want broken, stated plainly.

Leave out anything Copilot can already infer from the code, and anything that changes often enough to go stale.

### How to write and format them

Instructions work best when they read like a good standard: short, specific and testable. Follow the same principles as our [style guide for standards](style_guide_for_standards.md):

- **Write one rule per line** in plain Markdown. Whitespace between rules is ignored, so short, separate statements are easy to scan.
- **Be specific and testable.** "Validate input at the boundary and return the standard error shape from `src/errors.js`" is enforceable; "write good code" is not.
- **Give an example** for anything non-obvious, or reference a function that shows the pattern.
- **Keep the file lean.** A long instruction file dilutes the important rules and costs more tokens on every request. Cut anything that is not pulling its weight.

A compact repository-wide file might look like this:

```markdown
# Project instructions

- Use British English spelling in code comments and documentation.
- Format with the project's Prettier config; do not hand-format.
- Validate all external input at the boundary and reject with a 400 and the
  error shape in `src/errors.js`.
- Use parameterised queries only; never build SQL by string concatenation.
- Add or update tests for every behaviour change; run `npm test` before finishing.
```

A scoped file that applies only to test files:

```markdown
---
applyTo: "**/*.test.js"
---

- Use the existing `describe`/`it` structure; do not introduce new test frameworks.
- Assert on behaviour, not implementation detail.
- Cover the failure path, not just the happy path.
```

### Referencing organisation and industry standards

Instructions are a natural place to anchor Copilot to agreed standards rather than restating them:

- **Link to standards already in the repository or across Defra**, so Copilot applies the agreed rule and you maintain it in one place. For example, point at our [common coding standards](../standards/common_coding_standards.md) or [security standards](../standards/security_standards.md).
- **Reference industry standards** such as the [OWASP Top 10](https://owasp.org/www-project-top-ten/) where they apply, so reviews and generated code are checked against them.
- **Prefer a link over a paste.** A reference stays current as the standard evolves; a pasted copy goes stale.

Because your instruction files apply automatically, this is what makes Copilot's plans, implementations and reviews follow your standards without being told each time. During planning they steer the approach, during implementation they shape the code, and during code review Copilot checks the diff against them. See [Using Plan mode](#using-plan-mode) and [Instructions help the reviewer](#instructions-help-the-reviewer).

### Generating them

You do not have to start from a blank file:

- In your editor, run `/init` in chat to generate a `.github/copilot-instructions.md` file tailored to your codebase, or `/create-instruction` to scaffold a scoped instructions file.
- On GitHub, you can ask the Copilot coding agent to onboard a repository and open a pull request that adds a `copilot-instructions.md` file for you.
- Start from the Defra examples, which already encode our standards. See [Custom agents, skills and prompts](#custom-agents-skills-and-prompts).

Always review generated instructions. They are a starting point, not a finished standard, and you own what lands in the repository.

### Maintaining them

Instructions are living configuration, so treat them like code:

- **Encode recurring corrections.** When you find yourself fixing the same thing repeatedly, add a rule instead of repeating the correction.
- **Prune as you go.** Remove rules that are obsolete, unused or contradicted by newer ones. A lean file is more likely to be followed.
- **Test changes in the pull request that makes them.** During a review, Copilot reads instructions from the head branch, so you can change an instruction file and see the effect in the same pull request without merging first.
- **Check they are being applied.** In chat, expand the references on a response to confirm the instructions file was used.

> **Sustainability note.** A few lines of good instructions, loaded once, prevent many rounds of correction across the whole team. Each avoided correction is an entire conversation not re-sent to the model, so well-maintained instructions are one of the highest-value ways to reduce shared credit use. Keep them lean: an oversized instruction file adds tokens to every single request.

## Custom agents, skills and prompts

Instructions carry your standards into every session. Agents, skills and prompts go further: they package a role, a body of knowledge or a repeatable task into a file you commit once and reuse across the team. All three are plain Markdown with a small frontmatter block, they live in your repository under `.github/`, and they apply to everyone who clones it.

Use this table to pick the right one:

| | What it is | Where it lives | When it loads | How you invoke it |
| --- | --- | --- | --- | --- |
| **Agent** | A persona with a defined role, workflow and boundaries | `.github/agents/*.agent.md` | When you select it | Choose it in the chat agent picker |
| **Skill** | A capability package of focused knowledge | `.github/skills/{name}/SKILL.md` | Automatically, when its description matches your work | No action; Copilot loads it for you |
| **Prompt** | A reusable template for a repeated task | `.github/prompts/*.prompt.md` | When you run it | Type `/prompt-name` in chat |

They complement instructions rather than replace them. Instructions are always-on rules; an agent sets a mindset for a task; a skill supplies knowledge on demand; a prompt runs a task the same way every time.

### Custom agents

An agent is a persona you select in Copilot Chat to give it a specific role and workflow, for example a code reviewer, a tester or an accessibility advisor. Once selected, the agent shapes every reply in that session until you switch away.

An agent file has a frontmatter block and a body. The frontmatter sets the description and the tools the agent may use; the body defines the role, a numbered workflow, boundaries and the output format. A compact Defra code-reviewer agent looks like this:

```markdown
---
description: Systematic code reviewer using Defra quality criteria
tools: [read, search, usages, changes, findTestFiles, githubRepo]
---

# Code Reviewer

You are an experienced reviewer on a Defra digital service. Review changes
against our standards. Do not change code; report findings only.

## Workflow
1. Read the diff and the PR description.
2. Work through each category: correctness, tests, security, readability.
3. Flag anything that leaks PII in logs (names, addresses, NI numbers).

## Output
For each finding give the file and line, a severity (Blocking, Recommended,
Nit) and a suggested fix. End with a summary and a merge recommendation.

## References
- [Security standards](https://github.com/DEFRA/software-development-standards/blob/main/docs/standards/security_standards.md)
```

**Creating and using them.** Add a `*.agent.md` file under `.github/agents/`, or generate a scaffold with `/create-agent` in chat. To use it, open Copilot Chat, pick the agent from the agent picker, and give it the change or task to work on.

Best practice:

- **Give the agent one clear role and explicit boundaries.** A reviewer that also rewrites code does neither job well. State what it must *not* do.
- **Reference instruction files and standards, do not restate them.** Link to the standard so there is a single source of truth and the agent stays lean.
- **Define the workflow as a numbered sequence**, so the agent is repeatable rather than improvising each time.
- **Limit the tools to what the role needs.** A reviewer needs to read and search, not to run or edit.
- **Specify the output format**, so findings are consistent and easy to act on.

> **Sustainability note.** Scoping an agent's tools and role keeps each turn focused, which uses fewer tokens than an open-ended session. Because the agent is committed once and reused by everyone, that saving repeats across the whole team.

### Skills

A skill is a package of focused knowledge that Copilot discovers and loads automatically, without you naming it. It reads the `description` in each skill's frontmatter and pulls the skill in only when your work matches. This is progressive disclosure: the knowledge is there when relevant and out of the way when it is not.

Each skill is a folder under `.github/skills/` containing a `SKILL.md` file. The `description` is the most important line, because it decides when the skill activates. A compact Defra standards skill looks like this:

```markdown
---
name: defra-standards
description: Defra coding standards for Node.js and .NET government services. Use when writing, reviewing or refactoring code in a Defra service, especially Hapi or CDP platform projects.
license: OGL-UK-3.0
metadata:
  author: defra-digital
  version: "1.0"
---

# Defra Standards

Apply these when generating or reviewing code in a Defra service.

- Use Node.js Active LTS and vanilla JavaScript; TypeScript needs an approved exception.
- Use Hapi for HTTP servers, not Express, Fastify or Koa.
- Use parameterised queries only; never build SQL by string concatenation.
- Keep controllers thin: validate input, call a service, render a view.
```

A skill is not limited to prose knowledge. It can also package procedural know-how, such as the non-obvious steps to run a test suite, and bundle a script alongside `SKILL.md` in the same folder. For example, `.github/skills/integration-test-runner/SKILL.md` might look like this:

```markdown
---
name: integration-test-runner
description: Run this service's integration tests correctly. Use when asked to run, debug or fix integration tests, or when tests fail with connection errors.
license: OGL-UK-3.0
metadata:
  author: defra-digital
  version: "1.0"
---

# Integration test runner

`npm test` only runs the unit tests. The integration tests need Postgres and
Redis running and the test database seeded first, or every test fails with a
connection error that looks unrelated to the actual change.

## Steps
1. Start dependencies: `docker compose -f docker-compose.test.yml up -d`
2. Wait for Postgres to accept connections, then seed the test database
   using `run-tests.sh` in this folder: `./run-tests.sh --seed-only`
3. Run the suite: `npm run test:integration`
4. Tear down: `docker compose -f docker-compose.test.yml down`

## Common failures
- `ECONNREFUSED` on port 5432: dependencies are not up yet, or step 2 was skipped.
- Tests pass locally but fail in CI: the seed script did not run; check step 2.
```

The folder's `run-tests.sh` holds the seed-and-run logic so `SKILL.md` can stay short:

```bash
#!/usr/bin/env bash
set -euo pipefail

until docker compose -f docker-compose.test.yml exec -T db pg_isready -q; do
  sleep 1
done

npm run db:seed:test

if [[ "${1:-}" != "--seed-only" ]]; then
  npm run test:integration
fi
```

Skills need to be enabled once in VS Code by adding `"chat.agent.skills": true` to your user settings.

**Creating and using them.** Add a `.github/skills/{name}/SKILL.md` file with a precise description. You do not invoke it: once enabled, Copilot loads it whenever your request matches the description, in both chat and agent sessions.

Best practice:

- **Write the description as the trigger.** Say plainly when the skill applies, because that text is what Copilot matches against. A vague description will not load when you need it.
- **Keep each skill lean and single-topic.** One skill for standards, one for accessibility, one for security. Aim to stay under about 200 lines.
- **Scope activation to reduce noise.** A skill that activates only for Defra services will not clutter unrelated projects that share the same configuration.
- **Point at the canonical standard** rather than copying it, so the skill does not drift out of date.
- **Bundle scripts and resources for procedural tasks.** Where a skill's value is a repeatable sequence of commands, put the logic in a script in the same folder and keep `SKILL.md` to the trigger, the steps and the failure modes.

> **Sustainability note.** A skill is loaded only when its description matches, so its content does not sit in the context of every unrelated request. For large bodies of knowledge this is cheaper than an always-on instruction file, which adds tokens to every prompt whether relevant or not.

### Prompts

A prompt is a saved template for a task you do repeatedly, such as writing an architecture decision record, drafting a pull request description or running a security review. Instead of retyping the instructions each time, you run the prompt and provide the specifics.

Each prompt is a `*.prompt.md` file under `.github/prompts/`, with a description and a body that says what to produce, in what format and where to save it. A compact Defra ADR prompt looks like this:

```markdown
---
description: Generate an Architecture Decision Record from a design discussion
---

# Write ADR

Generate an ADR for the decision described in the chat. Save it as
`docs/ADRs/NNNN-title-in-kebab-case.md`, using the next sequence number.

Include: Context, Decision (one clear sentence), Consequences (positive and
negative), and at least two Alternatives considered.

## Rules
- Write in plain English and active voice.
- Be honest about trade-offs; do not list only the benefits.
- Reference a Defra standard where the decision relates to one, and note if an
  exception is needed.
```

**Creating and using them.** Add a `.prompt.md` file under `.github/prompts/`, then run it in chat by typing `/` followed by the file name, for example `/write-adr`. Attach or describe the specific context, such as the decision or the code, when you run it.

Best practice:

- **State the output up front:** what to produce, the format, and where to save it.
- **Reference instruction files and standards** so the output is compliant without repeating the rules in the prompt.
- **Use variables for the parts that change**, so the template stays reusable across tasks.
- **Keep the prompt to one task.** A prompt that tries to do everything is harder to run and reason about than several focused ones.

> **Sustainability note.** A saved prompt captures a well-formed instruction once, so you avoid re-explaining the task, and the corrective rounds that vague asks cause, every time you need it.

### Choosing between them

- Reach for **instructions** for always-on rules that should apply to every request. See [writing effective instructions](#writing-effective-instructions).
- Reach for an **agent** when you want Copilot to adopt a role and workflow for a task.
- Reach for a **skill** when you want a body of knowledge available on demand, loaded only when relevant.
- Reach for a **prompt** when you repeat the same task and want a consistent result each time.

They work together. An agent can draw on skills and follow your instructions, and you can run a prompt within an agent session.

### Defra examples and contributing back

Defra maintains ready-to-use agents, skills and prompts that encode our software development standards, so you do not start from a blank file:

- Browse them on the [Defra AI config examples site](https://defra.github.io/defra-ai-config-examples/).
- Get the source from the [defra-ai-config-examples repository](https://github.com/DEFRA/defra-ai-config-examples).

Copy the files that fit your project into the matching `.github/` directory and adapt them to your context.

**Please contribute back.** This resource is still growing, and it becomes more useful as teams add and refine examples. If you build an agent, skill or prompt that others would benefit from, or you improve an existing one, raise a pull request on the [defra-ai-config-examples repository](https://github.com/DEFRA/defra-ai-config-examples) so the whole community gains.

## Creating tickets, backlog items and tasks

Copilot can turn a rough idea, a conversation, a set of logs or a diff into well-formed delivery artefacts. A good ticket is not only a brief for the person who picks it up, it is also the brief you hand to the Copilot coding agent. The clearer the ticket, the better the result, whoever or whatever acts on it.

### What Copilot can draft

- **User stories with clear acceptance criteria**, from a short description or a conversation.
- **An epic broken into smaller, deliverable tasks.** This overlaps with [Plan mode](#using-plan-mode), which is well suited to decomposing large or unclear work before you commit to it.
- **A reproducible bug ticket** from logs, a stack trace or a diff, including steps to reproduce and expected versus actual behaviour.

### Writing a ticket worth acting on

The same habits that produce a good prompt produce a good ticket. Leave less to guesswork and the ticket needs less rework later.

- **Front-load the context.** State the goal, the constraints and the definition of done, so the ticket aims at the right target. See [reducing repeated back-and-forth](#reducing-repeated-back-and-forth).
- **Make the acceptance criteria explicit and testable.** "Reject requests where `email` is missing or malformed, returning a 400 with the standard error shape" is actionable; "improve validation" is not.
- **Say what is out of scope**, so the work does not sprawl beyond what you intended.
- **Reference files, issues and documentation rather than paste them.** Linking stays current and keeps the trail back to the real code. See [reference context, do not paste it](#reference-context-do-not-paste-it).
- **Never paste secrets, credentials or personal data** into a prompt to generate a ticket.

### A ticket is a brief for the coding agent

On GitHub you can assign a well-formed issue to Copilot, and the coding agent will plan the work, implement it and open a pull request for review. The quality of that pull request depends almost entirely on the quality of the ticket:

- **Clear acceptance criteria** tell the agent when it is done.
- **Referenced files and areas** point it at the right code instead of leaving it to guess.
- **A stated definition of done** stops it stopping short or over-reaching.
- **Your instruction files apply automatically** while the agent works, so your standards carry through without being restated. See [writing effective instructions](#writing-effective-instructions).

Review the resulting pull request as you would any other, using [Copilot code review](#using-copilot-code-review) as a first pass and a human review before merge, in line with the [pull requests process](../processes/pull_requests.md). A person remains accountable for what merges.

### Keeping tickets consistent

If your team writes tickets to a set shape, encode that shape once rather than re-describing it each time:

- **Use a prompt template** so every ticket comes out in the same format. See [Prompts](#prompts) for how to create a `*.prompt.md` file and run it with `/`.
- **Point at your repository's issue template** so generated tickets match the fields your board expects.
- **Let instructions carry the conventions**, such as the wording of acceptance criteria or the labels you use, so you do not repeat them per ticket.

### Your responsibilities

Always review the output. You are responsible for the accuracy, priority and scope of what lands in the backlog, and for what merges if you hand a ticket to the coding agent.

> **Sustainability note.** Draft a ticket for a specific change with the context to hand, rather than asking Copilot to "generate all the tickets for this project". Focused requests use fewer tokens and produce sharper, more useful tickets. A well-formed ticket also means fewer corrective rounds later, whether a person or the coding agent picks it up.

## Supporting testing

Copilot is well suited to testing work across the whole lifecycle of a test suite:

- **Create** unit and integration tests for existing code.
- **Extend** a suite with edge cases and failure modes you may have missed.
- **Update** tests when behaviour changes, so they keep pace with the code.

Used well, this speeds up the parts of testing that are mechanical and frees you to think about risk and coverage. Used carelessly, it produces a suite that looks thorough but proves little. The difference is almost entirely in how you direct it.

Copilot is an aid, not an assurance. You remain accountable for the test strategy, and Copilot does not change the shape of it: keep following the testing pyramid from our [quality assurance and test standards](../standards/quality_assurance_standards.md), aiming to catch most defects cheaply at the unit and API level rather than through slower user-interface tests.

### Instruct it to write meaningful tests

A vague request produces vague tests. Give Copilot the behaviour you want proven, not just the code to point at.

- **Front-load the behaviour and the acceptance criteria**, not only the function name. "Write tests for `calculateFee`" invites guesswork; "test that `calculateFee` applies the reduced rate below the threshold, the standard rate above it, and rejects a negative amount" does not.
- **Point at the acceptance criteria or ticket** for the code under test, so the tests check the behaviour the story actually promised.
- **Give a worked example.** For anything non-obvious, provide a sample input and the expected output, or point at an existing test that models the pattern to follow.
- **Ask for one unit or module at a time.** A focused request produces better tests than "write all the tests for this repo", and avoids the corrective rounds covered in [reducing repeated back-and-forth](#reducing-repeated-back-and-forth).

### Test behaviour, not implementation

The most useful tests describe what the code should do for a user, so they still pass after a safe refactor and fail only when real behaviour breaks.

- **Assert on observable behaviour and outputs**, not on internal calls or private state. Tests coupled to implementation detail break on every refactor and slow you down.
- **Ask for the negative and edge cases explicitly.** Our QA standards treat negative scenarios as being as important as positive ones: if "an admin can export data" then "a standard user cannot" is just as worth testing.
- **Tie tests back to user needs and acceptance criteria**, so each one maps to behaviour someone actually cares about rather than to a line of code that happened to exist.

### Avoid low-value tests that reduce agility

Copilot can generate a large volume of tests quickly. Volume is not the goal, and a bloated suite is a liability: it is slow to run, noisy to read, and expensive to maintain when requirements change.

- **Do not chase a coverage percentage.** A test written only to raise a number rarely proves anything and still has to be maintained forever.
- **Reject tests that restate the framework or library.** You do not need a test that proves the language assigns a variable or that a well-known library does its job.
- **Watch for near-duplicate tests.** Copilot may produce several cases that exercise the same path with trivially different data. Keep the ones that add a distinct scenario and prune the rest.
- **Avoid brittle tests tied to internals.** A test that must be rewritten every time the code is tidied discourages refactoring and makes the codebase harder to change.

### Name tests around business context

A good test name is documentation. Our QA standards expect the automated suite to be readable by non-technical colleagues, and the test names carry most of that meaning.

- **Name by scenario and expected behaviour**, for example "rejects an application with no email address", not "test 3" or "testValidate".
- **Use the language of the domain**, so the name reads as a statement about the service rather than about the code.
- **Ask Copilot to follow the suite's existing naming convention**, ideally by encoding it in instructions (see below) so you do not restate it each time.

### Updating tests as behaviour changes

When you change behaviour, the tests must move with it, and this is where careless prompting does the most damage.

- **Update the tests alongside the change**, so the suite always describes the current behaviour.
- **Never let Copilot weaken or delete an assertion just to make a failing test pass.** A red test is often reporting a real regression. Understand why it failed before changing it.
- **Use [Plan mode](#using-plan-mode) for larger test changes**, such as reworking a suite after a design change, so you agree the approach before any tests are rewritten.

### Let instructions and skills carry your test conventions

The most reliable way to get consistent, meaningful tests is to encode your testing conventions once rather than repeat them in every prompt.

- Put naming, structure, framework and coverage expectations in an instruction file, so they apply automatically to generated and reviewed tests. See [writing effective instructions](#writing-effective-instructions).
- Package deeper testing knowledge, for example how your team approaches contract or integration tests, in a skill that loads only when relevant. See [skills](#custom-agents-skills-and-prompts).

Treat generated tests critically. A test that passes but asserts the wrong thing is worse than no test. Check that each test proves the behaviour you actually care about, in line with our [quality assurance and test standards](../standards/quality_assurance_standards.md).

> **Sustainability note.** Ask for tests on a specific function or module rather than "write all the tests for this repo". Focused requests use fewer tokens, produce better and more relevant tests, and avoid a bloated suite that costs time and credits to run and maintain.

## Using Copilot for security

Copilot can help you find, understand and fix security issues across the lifecycle, from design through to remediating an assessment finding. It is an aid, not an assurance. It does not replace [GitHub Advanced Security](github_advanced_security.md), your review gates, or a professional security assessment, and it does not change who is accountable: you still own every line you ship. Used well, it shortens the distance between a weakness and its fix; used carelessly, it produces plausible-looking code that is quietly insecure.

Security is everyone's concern and works best woven into everyday practice, in line with our [security principles](../principles/security_principles.md). The most reliable way to make Copilot apply that thinking is to encode your security expectations once, so they steer every generation and review rather than being restated in each prompt. See [carrying security standards through instructions, agents and skills](#carrying-security-standards-through-instructions-agents-and-skills) below.

### Assessing code for vulnerabilities and weaknesses

Copilot can review code for security weaknesses and explain what it finds in context, which is often faster to act on than a raw scanner alert.

- **Review against agreed standards, not generic advice.** Ask it to check a change against the [OWASP Top 10](https://owasp.org/www-project-top-ten/), the [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/) that our [security standards](../standards/security_standards.md) adopt, and any rules in your own instruction files. Naming the standard grounds the review in our rules rather than the model's assumptions.
- **Focus on the common weakness classes.** Injection, broken access control, weak authentication, insecure deserialisation, secrets in code, missing input validation and unsafe output handling are all things Copilot can spot and explain in a diff.
- **Ask it to explain, not just flag.** Have it describe why something is exploitable and what the impact would be, so you can judge severity rather than taking the finding on trust.
- **Use it to draft the fix and the secure default.** Parameterised queries instead of string-built SQL, validation at the boundary, output encoding, and least-privilege authorisation checks are all good candidates. Verify the fix; do not assume it is correct because Copilot suggested it.
- **Run it as a first pass, on a focused diff.** [Copilot code review](#using-copilot-code-review) applies your instruction files automatically, so it can check changes against your security checklist before a human reviewer looks. For a larger remediation, agree the approach in [Plan mode](#using-plan-mode) first.

Copilot complements [GitHub Advanced Security](github_advanced_security.md), it does not replace it. Code scanning, Dependabot and secret scanning remain the automated backbone; Copilot is most useful for triaging those alerts, explaining a vulnerable dependency or code path, and drafting the fix. If Copilot ever surfaces a real secret in the code, treat it as exposed and follow the [credential exposure process](../processes/credential_exposure.md).

### Identifying threat vectors and threat modelling

Beyond reading code line by line, Copilot can help you reason about how a feature could be attacked, which is most valuable early, while the design is still cheap to change.

- **Map the attack surface.** Ask Copilot to enumerate entry points, trust boundaries and data flows for a feature, so you can see where untrusted input crosses into trusted code.
- **Run a lightweight threat model.** Point it at a design or the relevant code and ask for a STRIDE-style pass (spoofing, tampering, repudiation, information disclosure, denial of service, elevation of privilege), then draft a short threat model you keep in the repository.
- **Do it at design time.** [Plan mode](#using-plan-mode) is a natural place to surface threats and mitigations before any code is written, in the spirit of the "plan for security flaws" [security principle](../principles/security_principles.md).
- **Prioritise by realistic risk.** Ask for likelihood and impact so you spend effort on the vectors that matter, not a flat list of theoretical ones.

Treat the output as a prompt for your own analysis, not a complete or authoritative threat assessment. Copilot will miss context it cannot see, and can assert risks that do not apply. A person validates the model and decides what to mitigate.

### Supporting an IT Health Check (ITHC)

Copilot can help both before and after a formal IT Health Check, the independent assessment many Defra services must pass. It does not replace the assessment, and the assessors' report remains authoritative.

- **Prepare before assessors arrive.** Ask Copilot to review code and configuration against common ITHC finding categories, for example missing security headers, weak TLS or cookie settings, verbose error messages, outdated dependencies and unauthenticated endpoints, so you fix the obvious issues first. Combine this with the full [GitHub Advanced Security](github_advanced_security.md) checks.
- **Understand a finding.** Paste a finding's description (never any live credential or exploit detail that is sensitive) and ask Copilot to explain the weakness and where in your codebase it is likely to apply.
- **Draft prioritised remediation.** Have it propose fixes ordered by the report's severity ratings, and turn them into well-formed tickets. See [creating tickets, backlog items and tasks](#creating-tickets-backlog-items-and-tasks).
- **Re-check before retest.** After remediating, use [Copilot code review](#using-copilot-code-review) and GitHub Advanced Security to confirm the fixes hold and no regression was introduced, before you go back for the retest.

### Carrying security standards through instructions, agents and skills

The techniques in this guide are what make security consistent rather than ad hoc. Encoding your expectations once means Copilot applies them to every generation and review, not only when someone remembers to ask.

- **Instruction files carry your security rules.** Put non-negotiables such as parameterised queries only, validate all external input at the boundary, and check against the [OWASP Top 10](https://owasp.org/www-project-top-ten/) into your instruction files, so they shape generated code and are enforced during [Copilot code review](#using-copilot-code-review). See [writing effective instructions](#writing-effective-instructions).
- **A security-review agent gives a consistent role.** A read-only reviewer agent that references our [security standards](../standards/security_standards.md) and reports findings by severity produces repeatable reviews without rewriting your code. See [custom agents](#custom-agents).
- **A security skill supplies knowledge on demand.** Package OWASP checks or your team's threat patterns in a skill that loads only when relevant, pointing at the canonical standard rather than copying it. See [skills](#skills).
- **Start from the Defra examples.** The [Defra AI config examples](https://defra.github.io/defra-ai-config-examples/) include security-focused configuration you can adopt and contribute back to.

### Important cautions

- **Never paste secrets, credentials, keys or personal data into a prompt**, in line with [your responsibilities](#your-responsibilities).
- **Do not assume generated code is secure.** Verify it, and keep using [GitHub Advanced Security](github_advanced_security.md) and your normal review gates.
- **Copilot can produce insecure or outdated patterns.** Your [security standards](../standards/security_standards.md) and the OWASP references remain the source of truth.
- **Copilot supplements, it does not certify.** It does not replace a professional security assessment, penetration test or ITHC.

> **Sustainability note.** Point security reviews at a focused diff or feature rather than asking Copilot to "audit the whole codebase". Focused requests use fewer tokens and give sharper findings, and encoding your security rules in instructions prevents the same weaknesses recurring, which is cheaper than catching them again in every review.

## Learning with Copilot

Copilot is a powerful learning aid, not just a code generator. Directed well, it can explain as it works, so you finish a task understanding it rather than just having completed it. Treat it as an augmented mentor: one that is always available, never impatient, and often, but not always, right.

The risk is the opposite habit. If you let Copilot do the thinking and simply accept what it produces, you ship code you do not understand and your own skill stops growing. The goal is to use it to build your understanding, not to bypass it.

### Not just for juniors

Learning is continuous, so this applies to anyone stretching beyond what they already know, not only to developers early in their careers. Copilot is a useful mentor when you are:

- **Working with unfamiliar technology**, such as a new framework, tool or cloud service.
- **Joining a new team and codebase**, and finding your way around conventions and history you did not write.
- **Picking up a new language**, and learning its idioms rather than translating from one you already know.
- **Tackling a genuinely complicated task**, where you want to understand the approach before you commit to it.

### Let Copilot teach while it delivers

The most valuable learning workflow is to have Copilot educate as well as do, so understanding is a by-product of the work rather than a separate exercise:

- **Ask it to explain its reasoning as it works**, not just to hand you the result. For example: "Explain the approach and the trade-offs before you change anything, then walk me through the change."
- **Ask it to narrate the concepts behind the code**, so you learn the pattern and not only this instance of it.
- **Turn a delivery ticket into a guided tutorial.** Ask Copilot to break the ticket into steps, explain the concept behind each one, and let you attempt a step yourself before it shows you its version. You get the delivery and the learning from the same piece of work.
- **Use [Plan mode](#using-plan-mode) to learn the shape of a task** before any code is written, so you understand the approach while it is still cheap to question.

### Ask the questions you would hesitate to ask

Copilot is a judgement-free place to ask the "obvious" question, explore a concept, or get unblocked when no colleague is free:

- **Ask the basic question** you might feel awkward raising in a review or a team channel. There is no wrong question to ask it.
- **Get unblocked when no one is available**, for example out of hours or when your team is heads-down, instead of staying stuck.
- **Use it to prepare**, for example to understand a concept well enough to then have a sharper conversation with a human mentor.

It complements human mentoring and code review, it does not replace them. Some questions are still best answered by a colleague who knows your service, your users and your history.

### Getting accurate mentoring

Copilot can be confidently wrong, so how you ask shapes how much you can trust the answer:

- **Ask "why" and "what are the trade-offs"**, not just "how", so you learn the reasoning and can judge it.
- **Ask it to cite official documentation or point at the code** it is basing an answer on, so you can check the source yourself.
- **Ask for the explanation before the change**, so you understand what is coming rather than reverse-engineering it afterwards.
- **Work in small steps you can follow**, rather than accepting a large change you would have to unpick to understand.
- **Cross-check against official documentation and our [standards](../standards/README.md)**, which remain the source of truth when Copilot and a standard disagree.
- **Treat a confident tone as no guarantee of accuracy.** Verify anything you intend to rely on.

### Stay in charge of your own growth

Use Copilot to build your skill, not to skip building it:

- **Understand every change before you accept it**, so you could have written it yourself.
- **Notice when you are leaning on it instead of learning from it**, and switch back to asking it to explain.
- **You own the output**, so you are accountable for code you commit whether you wrote it or Copilot did. See [your responsibilities](#your-responsibilities).

> **Sustainability note.** Asking Copilot to explain as it works adds little cost over asking it to just do the task, and it saves the far larger cost of reworking code no one understood. Learning from focused questions on the task in front of you is cheaper, and more effective, than long open-ended exploration.

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
