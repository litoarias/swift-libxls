# Essentials

The short list that applies to every task in every project. Each rule has an
ID, so reviews and agents can cite it, and a level:

- **MUST**: required. A deviation needs an entry in the project's
  `docs/wiki/overrides.md`.
- **SHOULD**: the default. Deviate only with a reason stated in the PR or code.
- **MAY**: allowed, at the author's judgement.

## Precedence

- **CORE-ESS-001 (MUST)** Rule precedence, highest first: the project's
  `docs/wiki/overrides.md`, the project's own wiki and `AGENTS.md`, the
  company layer (if any), the platform layer (`ios`, `web`), then `core`.
  *Why:* global rules cannot know every project's constraints; overrides keep
  those exceptions explicit instead of silent.
- **CORE-ESS-002 (MUST)** Do not edit the synced handbook folder inside a
  project. Change the central `engineering-handbook` repository instead
  (`handbook propose`, see [How This Handbook Works](how-this-handbook-works.md)).
  *Why:* local edits are overwritten on the next sync and drift from every
  other project.

## Working on existing code

- **CORE-ESS-010 (MUST)** New and changed code follows the handbook. Existing
  code that does not comply is not refactored unless the task touches it or
  the user asks. *Why:* drive-by refactors make diffs hard to review and
  break unrelated features.
- **CORE-ESS-011 (SHOULD)** When you leave non-compliant code in place, say so
  in the PR description instead of hiding it.
- **CORE-ESS-012 (MUST)** Follow the conventions already present in the
  project when the handbook is silent. Do not introduce a second pattern for
  something the project already solves.

## Always

- **CORE-ESS-020 (MUST)** Code, identifiers, and code comments are in English.
  User-facing text is localized (see the platform layer).
- **CORE-ESS-021 (MUST)** Never commit secrets, tokens, or private keys
  ([Privacy And Secrets](privacy-and-secrets.md)).
- **CORE-ESS-022 (MUST)** Never write the owner's personal name, personal
  email, address, or phone number in code, metadata, public pages, or legal
  text. Use the app or brand name; legal pages say "the Developer".
- **CORE-ESS-023 (MUST)** No AI attribution anywhere: no `Co-Authored-By`
  lines for AI tools, no "generated with" signatures in commits, PRs, or code.
- **CORE-ESS-024 (MUST)** Commit and push only when asked. Never force-push a
  shared branch ([Git And Delivery](git-and-delivery.md)).
- **CORE-ESS-025 (MUST)** Run the closest available build or test check before
  declaring a change done, and report honestly if it could not be run
  ([Verification](verification.md)).
- **CORE-ESS-026 (SHOULD)** Keep changes scoped to the request. Note follow-ups
  instead of doing them silently.
