# Errors And Logging

- **IOS-ERR-001 (MUST)** Each Domain context defines its errors as an `enum`
  conforming to `Error` (and `Equatable` for tests). Use typed throws when the
  set of errors is closed.
- **IOS-ERR-002 (MUST)** Technical errors are translated at the Data boundary;
  view models map domain errors to localized, user-facing messages.
- **IOS-ERR-003 (MUST)** Never swallow errors silently. `try?` is allowed only
  when failure is an expected, harmless outcome; say why in a comment.
- **IOS-ERR-004 (MUST)** No force unwraps (`!`), `try!`, or `fatalError` in
  production paths except for programmer errors that cannot happen at runtime
  (and then with a message). `[lint]`
- **IOS-LOG-001 (MUST)** Use `os.Logger` with a subsystem (bundle ID) and a
  category per area. No `print` outside debug-only tooling. `[lint]`
- **IOS-LOG-002 (MUST)** Mark dynamic values with the right privacy
  (`\(value, privacy: .private)` by default for anything user-related).
- **IOS-LOG-003 (SHOULD)** Non-fatal errors that matter in production are
  reported to the crash reporter (Crashlytics) with context, without personal
  data.
