# Naming

| Kind | Pattern | Example |
| --- | --- | --- |
| Domain model | Plain business name | `Workout`, `UserProfile` |
| DTO | `<Name>DTO` | `WorkoutDTO` |
| Persistence model | `<Name>Entity` or `<Name>Record` | `WorkoutEntity` |
| Mapper | `<Name>Mapper` | `WorkoutMapper` |
| Domain repository | `<Name>Repository` | `WorkoutRepository` |
| Repository implementation | `<Qualifier><Name>Repository` | `SwiftDataWorkoutRepository`, `RemoteWorkoutRepository`, `HealthKitHeartRateRepository` |
| Technical client | `<Capability>Client` | `HTTPClient`, `KeychainClient` |
| Use case | `<Verb><Entity>UseCase` | `FetchWorkoutsUseCase` |
| Domain error | `<Context>Error` | `WorkoutError` |
| Screen state | `<Feature>ScreenState` or `<Feature>State` | `HomeScreenState` |
| View model | `<Feature>ViewModel` | `HomeViewModel` |
| View model contract | `<Feature>ViewModelContract` | `HomeViewModelContract` |
| View | `<Feature>View` | `HomeView` |
| Factory | `<Feature>FeatureFactory` | `HomeFeatureFactory` |
| Test | `<TypeUnderTest>Tests` | `HomeViewModelTests` |
| Test double | `<Protocol><Kind>` | `WorkoutRepositoryStub`, `AnalyticsSpy` |

- **IOS-NAME-001 (SHOULD)** Avoid vague names: `Manager`, `Helper`, `Utils`,
  `Default*`, `*Impl`, `Base*`. Name the responsibility instead.
- **IOS-NAME-002 (MUST)** Domain models carry no technical suffix (`DTO`,
  `Entity`, `Model`).
- **IOS-NAME-003 (SHOULD)** Booleans read as assertions (`isLoading`,
  `hasCompletedOnboarding`); async functions that fetch are `load…`/`fetch…`.
- **IOS-NAME-004 (SHOULD)** Accessibility identifiers and analytics event
  names use `snake_case` strings defined in one place per feature.
