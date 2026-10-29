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
- **CORE-GIT-008 (MUST)** When a version goes live, tag the commit on `main`
  that shipped it as `vX.Y.Z`. In a repository with several apps the tag is
  `<app>-vX.Y.Z`, where `<app>` is the last part of the bundle id in lower
  case (`com.example.maps` → `maps-v1.2.0`). No other tag formats (`1.2.0`,
  `release-1.2`). *Why:* `app-status` reads the tag to know what shipped.
- **CORE-GIT-009 (MUST)** Do not leave stray copies or worktrees of a project
  next to it. Temporary worktrees live inside `.claude/worktrees/` and are
  removed when done.

## Releases

Every app uses the same release flow, so its state can be read from git and
App Store Connect instead of being written by hand. `app-status` in the
central repository checks each rule below and reports deviations as alerts.

- **CORE-GIT-010 (MUST)** The app version is `X.Y.Z` (three numbers, `1.2.0`
  not `1.2`) and is set in one place per app target. The build number is a
  separate integer.
- **CORE-GIT-011 (MUST)** Branches: `main` is what is live in the store,
  `develop` is the integration branch, `release/X.Y.Z` prepares the version
  `X.Y.Z` exactly (the same number as the app version), and work happens in
  `feature/…` or `fix/…`. A repository with several apps names it
  `release/<app>-X.Y.Z`.
- **CORE-GIT-012 (MUST)** At most one open release branch per app. Open means
  its version is above what is live.
- **CORE-GIT-013 (MUST)** A release closes only after the store publishes the
  version: merge `release/X.Y.Z` into `main`, tag it (CORE-GIT-008), merge
  `main` back into `develop`. Do not merge into `main` while the version is
  still in review. *Why:* `main` must always match the store.
- **CORE-GIT-014 (SHOULD)** Delete a release branch, local and remote, once
  it is closed (with approval, CORE-GIT-007). Old release branches stay
  reachable through their tag.
- **CORE-GIT-015 (MUST)** Each app is declared in the project's `.handbook`
  as `apps=<bundle-id>=<app-store-id>` (space-separated for several apps;
  leave out `=<app-store-id>` until the app exists in App Store Connect;
  `apps=-` for an internal app that never ships to the store). It is
  set when the project is onboarded and is the only place that links a
  repository to its store listing.
- **CORE-GIT-016 (MUST)** Release state (store version, version in review,
  release date, ratings, minimum OS) is never maintained by hand in a tracker.
  It is written by `app-status`. Trackers keep only decisions, notes, and
  tasks.
- **CORE-GIT-017 (MUST)** A commit that resolves a task of the project tracker
  cites its id in the body with a closing keyword: `Fixes TASK-12` (also
  `Closes`, `Resuelve`, `Cierra`). When it reaches the default branch, the
  daily `app-status` run marks the task done and links the commit. Mentioning
  an id without the keyword does not close it. *Why:* the tracker stays true
  without anyone remembering to update it.
