# Testing

Tests exist to catch regressions that matter, not to produce a coverage
number (CORE-ESS-027). Before writing a test, name the behavior it protects
and how the test would fail if that behavior broke. If you cannot, do not
write it.


- **IOS-TEST-001 (MUST)** New tests use Swift Testing (`import Testing`,
  `@Test`, `#expect`, `#require`). XCTest stays only for UI tests and
  performance tests.
- **IOS-TEST-002 (MUST)** New logic ships with the tests that protect it
  (IOS-TEST-009). Where tests usually earn their place:
  - Use cases: delegation, business rules, and errors.
  - View models: state transitions, errors, and duplicate-load prevention.
  - Repositories: request construction, persistence or SDK interaction,
    decoding, mapping, caching, and error translation.
  - Mappers: complete data, optional data, alternate formats, and failures.
  - Shared clients: their reusable behavior.
- **IOS-TEST-003 (MUST)** Tests do not hit the network, real iCloud, HealthKit,
  or shared simulator state. Use stubs, in-memory stores, and `URLProtocol`
  fakes.
- **IOS-TEST-004 (SHOULD)** Use parameterized tests (`@Test(arguments:)`) for
  input tables instead of copy-pasted tests.
- **IOS-TEST-005 (SHOULD)** Test doubles are hand-written (`Stub`, `Spy`,
  `Fake`) and live in the test target next to the tests that use them, or in
  a shared `TestDoubles` folder.
- **IOS-TEST-006 (SHOULD)** Declarative UI, previews, and the composition root
  are excluded from coverage reports; validate them with UI or snapshot tests
  when the risk justifies it. Coverage is a map, never a target
  (CORE-VER-006).
- **IOS-TEST-007 (MUST)** Tests are deterministic: inject clocks, calendars,
  locales, and UUID generators instead of using `Date()` or `Locale.current`
  directly in tested code.
- **IOS-TEST-008 (MUST)** The project wiki names the scheme and test plan used
  for validation (local and CI).
- **IOS-TEST-009 (MUST)** Each test protects real behavior and fails when that
  behavior breaks. Assert on outcomes (returned values, state, errors, calls
  that matter), not on implementation details. Do not write:
  - tests that only check a mock returns what it was told to return;
  - tests of trivial getters, memberwise initializers, constants, or
    `Codable`/`Equatable` conformances the compiler synthesizes;
  - tests that call code without a meaningful `#expect`;
  - snapshot-of-everything tests nobody reviews;
  - copies of a test that differ only in input (use IOS-TEST-004).
  When a bug is fixed, add the test that would have caught it.
- **IOS-TEST-010 (SHOULD)** Delete or merge tests that no longer protect
  anything (dead features, duplicated assertions, mock-only checks). A shorter
  suite that fails for real reasons beats a longer one.
