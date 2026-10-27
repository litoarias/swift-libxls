# Architecture

Projects follow Clean Architecture with three main layers plus composition and
shared infrastructure. Folder names for the shared layer vary per project
(`Core`, `Commons`, `Common`, `Shared`); the project wiki names it.

```text
App / DI      -> Presentation + Domain + Data + Shared
Presentation  -> Domain
Presentation  -> Shared/DesignSystem
Data          -> Domain
Data          -> Shared (networking, persistence clients)
Domain        -> Foundation only
```

```text
View -> ViewModel -> Use Case -> Domain Repository (protocol)
                                       ^
                                       |
                              Data Repository (implementation)
                                       |
                       HTTP client / SwiftData / Keychain / SDK
```

## Rules

- **IOS-ARCH-001 (MUST)** Domain imports only Foundation (and Observation if
  needed). No SwiftUI, UIKit, SwiftData, Firebase, or project Data types.
  `[lint]` *Why:* Domain is the testable core and must survive a UI or storage
  rewrite.
- **IOS-ARCH-002 (MUST)** Presentation never imports or names Data types
  (repositories, DTOs, SwiftData models) or technical clients.
- **IOS-ARCH-003 (MUST)** Data never depends on Presentation.
- **IOS-ARCH-004 (MUST)** Concrete types are assembled in the composition root
  (`App`/`DI`, a dependency container or factory). Views and view models never
  instantiate repositories or clients. Dependencies are injected through
  `init`.
- **IOS-ARCH-005 (MUST)** Views contain no business logic. Presentation logic
  lives in the view model; business rules live in use cases or domain models.
- **IOS-ARCH-006 (SHOULD)** A repository protocol in Domain is the substitution
  boundary for a data capability. Its implementation in Data owns endpoint
  construction, SDK or storage access, DTO mapping, caching, and translation
  of technical errors into domain errors.
- **IOS-ARCH-007 (SHOULD)** Do not add a `Service` type that only mirrors a
  repository (same methods, same capability). A separate type is fine when it
  owns a distinct technical concern (a peer-to-peer session, an on-device
  model runner) that several repositories use.
- **IOS-ARCH-008 (SHOULD)** Use cases exist when there is a business rule,
  orchestration of several repositories, or a reusable operation. A view model
  may call a repository protocol directly for trivial reads; do not create
  pass-through use cases only to satisfy a diagram.
- **IOS-ARCH-009 (SHOULD)** Framework capability checks (`#available`, device
  capability, entitlement presence) are resolved outside views; views receive
  UI-ready state.
- **IOS-ARCH-010 (MUST)** Extensions (widgets, watch app, Live Activities,
  intents) reuse Domain and Data through shared targets or packages instead of
  copying code.
- **IOS-ARCH-011 (SHOULD)** A new provider for an existing capability is a new
  implementation of the same Domain protocol, selected in the composition root.
