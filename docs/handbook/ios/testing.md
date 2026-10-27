# Testing

- **IOS-TEST-001 (MUST)** New tests use Swift Testing (`import Testing`,
  `@Test`, `#expect`, `#require`). XCTest stays only for UI tests and
  performance tests.
- **IOS-TEST-002 (MUST)** New logic ships with tests. Expected coverage:
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
  are excluded from coverage numbers; validate them with UI or snapshot tests
  when the risk justifies it.
- **IOS-TEST-007 (MUST)** Tests are deterministic: inject clocks, calendars,
  locales, and UUID generators instead of using `Date()` or `Locale.current`
  directly in tested code.
- **IOS-TEST-008 (MUST)** The project wiki names the scheme and test plan used
  for validation (local and CI).
