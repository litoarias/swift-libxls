# Verification

- **CORE-VER-001 (MUST)** After changing code, run the closest check: build
  the affected scheme or target, run the affected tests, or run the site's
  build script.
- **CORE-VER-002 (MUST)** Report the result honestly. If a check could not run
  (no simulator, missing secrets, another build in progress), say so and say
  what remains unverified.
- **CORE-VER-003 (MUST)** When several agent sessions work on the same
  project, only one builds and runs tests at a time. The others wait or ask it
  to verify. *Why:* parallel builds of one project corrupt DerivedData and
  waste minutes.
- **CORE-VER-004 (SHOULD)** For UI changes, check the result visually
  (simulator screenshot or browser) in light and dark mode and at the
  smallest supported size.
- **CORE-VER-005 (SHOULD)** Prefer the IDE integration (Xcode MCP) when
  available; otherwise use the command line with the project's scheme.
- **CORE-VER-006 (MUST)** Coverage is a map of what is untested, never a
  target. Do not set or chase coverage percentages; use the report to find
  important behavior without tests (CORE-ESS-027).
- **CORE-VER-007 (MUST)** Coverage counts only logic: presentation logic
  (view models, presenters, state holders) and everything below it (domain
  and data). Views, previews, styles, assets, generated code, debug screens,
  and the composition root are left out of the number and the report. The
  project wiki states how the report is filtered. *Why:* UI declarations
  dilute the report until it no longer shows which logic lacks tests.
