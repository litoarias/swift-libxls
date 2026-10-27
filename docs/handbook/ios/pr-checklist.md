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
- [ ] Tests use Swift Testing and cover the change (IOS-TEST-001/002).
- [ ] SwiftLint passes; there are no new warnings (IOS-QUAL-002/003).
- [ ] Privacy manifest and policy are updated if data collection changed
      (IOS-ADS-004).
