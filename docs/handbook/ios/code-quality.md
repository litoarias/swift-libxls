# Code Quality

- **IOS-QUAL-001 (MUST)** Projects use SwiftLint with a project
  `.swiftlint.yml` that inherits the shared base synced with this layer
  (`parent_config: docs/handbook/ios/tooling/swiftlint.base.yml`) and only
  adds `included` paths and project-specific rules. Base rules change in the
  handbook, never in the project; deviations go in `overrides.md`.
- **IOS-QUAL-002 (MUST)** New and changed files lint clean. Check them with
  `swiftlint lint --no-cache <files>`; the whole project with
  `swiftlint lint --no-cache`. Existing findings are tracked as known debt in
  the project's `overrides.md`.
- **IOS-QUAL-003 (MUST)** No new compiler warnings. Treat warnings as errors in
  CI when the project is clean enough.
- **IOS-QUAL-004 (MUST)** Intentional lint exceptions are narrow
  (`// swiftlint:disable:next <rule>`) and carry a reason in the same comment.
- **IOS-QUAL-005 (SHOULD)** Architecture rules that need semantic knowledge
  stay in the PR checklist; do not add brittle regex rules that create noise.
- **IOS-QUAL-006 (SHOULD)** Functions over ~50 lines and types over ~400 lines
  are a signal to split, not a hard limit.
