# iOS Layer

Rules for Apple-platform apps and Swift packages (iOS, iPadOS, watchOS,
macOS, widgets, and extensions). Read the page that matches the task.

| Read this page | When |
| --- | --- |
| [Architecture](architecture.md) | Any change that adds a type, file, or dependency. |
| [Project Structure](project-structure.md) | Creating folders, contexts, or moving files. |
| [Naming](naming.md) | Naming any new type. |
| [SwiftUI](swiftui.md) | Writing or changing views and view models. |
| [Concurrency](concurrency.md) | Any `async`, actor, `Task`, `Sendable`, or isolation work. |
| [Networking And Integrations](networking-and-integrations.md) | Backend calls, SDKs, system frameworks (HealthKit, StoreKit, WatchConnectivity…). |
| [Persistence](persistence.md) | SwiftData, Keychain, UserDefaults, files, iCloud. |
| [Errors And Logging](errors-and-logging.md) | Throwing, catching, presenting errors, or logging. |
| [Localization And Accessibility](localization-and-accessibility.md) | Any user-facing text or UI. |
| [UI And Design System](ui-and-design-system.md) | Colors, fonts, components, layout. |
| [Analytics, Ads And Consent](analytics-ads-and-consent.md) | Firebase, AdMob, ATT, UMP, event tracking. |
| [Testing](testing.md) | Adding or changing logic. |
| [Code Quality](code-quality.md) | SwiftLint, warnings, build settings. |
| [Recipe: Add A Feature](recipes/add-a-feature.md) | Building a new screen end to end. |
| [Recipe: Add A Data Capability](recipes/add-a-data-capability.md) | A repository, SDK wrapper, or store without its own screen. |
| [Recipe: Add Crashlytics](recipes/add-crashlytics.md) | Before an app's first store release, or when it has no crash reporter. |
| [PR Checklist](pr-checklist.md) | Before opening or approving a PR. |

Baseline for new projects: latest stable Xcode, Swift 6 language mode,
`SWIFT_STRICT_CONCURRENCY = complete`, iOS 18 or later as minimum deployment
target unless the project wiki says otherwise.
