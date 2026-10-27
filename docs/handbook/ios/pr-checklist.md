# iOS PR Checklist

- [ ] Dependencies follow the allowed directions; Domain imports only
      Foundation (IOS-ARCH-001/002/003).
- [ ] No DTOs, SwiftData models, or SDK types leave Data (IOS-STRUCT-004).
- [ ] Dependencies are injected from the composition root (IOS-ARCH-004).
- [ ] No business logic in views (IOS-ARCH-005).
- [ ] View models are `@MainActor @Observable`; async work starts in `.task`
      (IOS-UI-001/003).
- [ ] Strict concurrency is clean, with no new `@unchecked Sendable`
      (IOS-CONC-001/006).
- [ ] Technical errors are translated; nothing is silently swallowed
      (IOS-ERR-002/003).
- [ ] Strings are in the catalog for every shipped language (IOS-L10N-001/002).
- [ ] Accessibility labels, Dynamic Type, and dark mode are checked
      (IOS-A11Y-001/002, IOS-DS-002).
- [ ] Tests use Swift Testing and protect the changed behavior; each one
      would fail if that behavior broke, none exists only for coverage
      (IOS-TEST-001/002/009). Coverage, if reported, counts only view
      models, Domain, and Data; views are out (IOS-TEST-006).
- [ ] SwiftLint passes; there are no new warnings (IOS-QUAL-002/003).
- [ ] If the user declines UMP, ATT is never shown (IOS-ADS-006).
- [ ] Privacy manifest and policy are updated if data collection changed
      (IOS-ADS-004).
