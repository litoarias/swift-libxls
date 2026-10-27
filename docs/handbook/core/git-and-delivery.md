# Git And Delivery

- **CORE-GIT-001 (MUST)** Commit author email in personal projects is the
  personal address configured for the repository. A work email never appears
  in a personal commit.
- **CORE-GIT-002 (MUST)** No AI attribution lines (`Co-Authored-By`, "Generated
  with") in commits or PRs.
- **CORE-GIT-003 (SHOULD)** Commit subject: `<Area>: <imperative summary>`,
  under 72 characters, in English. Example: `Home: show the start card first`.
  The body explains *why* when the diff does not.
- **CORE-GIT-004 (SHOULD)** One logical change per commit. Do not mix
  formatting, refactors, and behavior changes.
- **CORE-GIT-005 (MUST)** Do not commit directly to `main` for feature work;
  use a branch (`feature/…`, `fix/…`, `release/x.y.z`).
- **CORE-GIT-006 (MUST)** When several sessions or people work in the same
  checkout, commit only the files you changed. Never `git add -A` over someone
  else's work in progress.
- **CORE-GIT-007 (MUST)** Never force-push, rewrite published history, or
  delete branches without explicit approval.
- **CORE-GIT-008 (SHOULD)** Releases are tagged `vX.Y.Z` from the release
  branch. App version numbers follow semantic versioning.
- **CORE-GIT-009 (MUST)** Do not leave stray copies or worktrees of a project
  next to it. Temporary worktrees live inside `.claude/worktrees/` and are
  removed when done.
