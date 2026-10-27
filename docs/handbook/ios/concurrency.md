# Concurrency

- **IOS-CONC-001 (MUST)** Swift 6 language mode with complete strict
  concurrency checking in every target.
- **IOS-CONC-002 (MUST)** UI types (views, view models, factories, routers) are
  `@MainActor`.
- **IOS-CONC-003 (MUST)** Domain and Data stay `nonisolated` unless they wrap
  an API that requires the main actor (some delegates, UIKit-presenting SDKs).
  Document the reason next to the annotation. In targets that use default
  main-actor isolation (IOS-CONC-011), mark Domain and Data types `nonisolated`
  explicitly instead.
- **IOS-CONC-004 (MUST)** Do not add `@MainActor` outside UI just to silence a
  compiler error.
- **IOS-CONC-005 (MUST)** Shared mutable state is protected by an `actor` or a
  `Mutex`/lock primitive.
- **IOS-CONC-006 (MUST)** No `@unchecked Sendable` and no
  `nonisolated(unsafe)` unless a third-party API forces it; then document the
  invariant that makes it safe.
- **IOS-CONC-007 (MUST)** Use async/await. Wrap callback APIs with
  `withCheckedThrowingContinuation` at the Data boundary; do not add new
  completion-handler APIs.
- **IOS-CONC-008 (SHOULD)** Avoid `Task.detached` and
  `DispatchQueue.main.async`. `[lint]`
- **IOS-CONC-009 (SHOULD)** Run independent work concurrently with
  `async let` or task groups, and check cancellation in long loops.
- **IOS-CONC-010 (SHOULD)** Long-lived tasks (streams, polling, timers) are
  owned by a type that cancels them explicitly.
- **IOS-CONC-011 (MAY)** App targets may use Swift 6.2 approachable
  concurrency (`SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`,
  `SWIFT_APPROACHABLE_CONCURRENCY = YES`), the Xcode 26 default for new apps.
  Then UI code needs no `@MainActor` annotations, Domain and Data types are
  declared `nonisolated`, and CPU-heavy work runs in `@concurrent` functions.
  Shared packages and extensions keep the default `nonisolated` isolation.
