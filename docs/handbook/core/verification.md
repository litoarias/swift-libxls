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
