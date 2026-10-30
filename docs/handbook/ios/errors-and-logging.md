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
  reported to the crash reporter (Crashlytics, IOS-LOG-004) with context,
  without personal data.
- **IOS-LOG-004 (MUST)** Every app published in the App Store ships a crash
  reporter, and it is Firebase Crashlytics (free, no event cap). It starts at
  launch with `FirebaseApp.configure()`, its collection is off in Debug
  builds, Release builds upload their dSYMs, the App Store privacy label
  declares Crash Data, and the privacy policy names Crashlytics (IOS-ADS-004,
  CORE-PRIV-004). Steps: [Recipe: Add Crashlytics](recipes/add-crashlytics.md).
  *Why:* without it, crashes only reach the Xcode Organizer from users who
  share analytics with developers, days later and without context. An app
  with no crash reporter ships blind.
