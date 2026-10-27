# Persistence

- **IOS-PERS-001 (MUST)** Persistence is behind Domain repository protocols.
  SwiftData `ModelContext`, `UserDefaults`, Keychain, and file APIs are used
  only in Data (or a shared client).
- **IOS-PERS-002 (MUST)** SwiftData `@Model` types do not leave Data; map them
  to Domain structs.
- **IOS-PERS-003 (MUST)** Tokens, credentials, and sensitive identifiers live
  in the Keychain, never in `UserDefaults` or files.
- **IOS-PERS-004 (SHOULD)** `UserDefaults` access goes through one typed
  preferences type per app (keys defined once), not string keys scattered
  across views. `@AppStorage` is acceptable for pure UI preferences.
- **IOS-PERS-005 (MUST)** Schema changes to persisted models ship with a
  migration plan (SwiftData `VersionedSchema`/`SchemaMigrationPlan`, or a
  documented lightweight migration) and a test that opens the old store.
- **IOS-PERS-006 (SHOULD)** CloudKit-backed stores have a fallback chain
  (CloudKit, then local, then in-memory) and never crash at launch when iCloud
  is unavailable.
- **IOS-PERS-007 (SHOULD)** Data shared with extensions uses the app group
  container; the group identifier comes from configuration.
- **IOS-PERS-008 (MUST)** Session invalidation (sign-out, revoked token) is
  handled by one owner that clears stored session data and resets navigation.
