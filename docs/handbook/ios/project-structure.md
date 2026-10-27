# Project Structure

```text
<App>/
|-- App/            entry point, composition root (or DI/)
|-- Presentation/   <Feature>/{Views,ViewModels}, shared UI
|-- Domain/         <Context>/{Models,Repositories,UseCases,Errors}
|-- Data/           {Models (DTOs),Mappers,Repositories} or by context
|-- <Shared>/       networking, persistence clients, design system, utilities
`-- Resources/      assets, Localizable.xcstrings, configuration
<App>Tests/         mirrors the app structure
```

- **IOS-STRUCT-001 (SHOULD)** Domain is organized by business context
  (`Domain/Workout`, `Domain/Session`), not by technical type at the root.
- **IOS-STRUCT-002 (SHOULD)** Each context creates only the subfolders it needs
  (`Models`, `Repositories`, `UseCases`, `Errors`).
- **IOS-STRUCT-003 (SHOULD)** A use case protocol, when one exists, lives in the
  same file as its implementation.
- **IOS-STRUCT-004 (MUST)** External payloads (JSON DTOs, SDK models,
  SwiftData `@Model` types) stay in Data and are mapped to Domain models before
  leaving it.
- **IOS-STRUCT-005 (SHOULD)** Mappers get their own file when the mapping is
  reused or non-trivial; small mappings may stay private in the repository.
- **IOS-STRUCT-006 (SHOULD)** Presentation is organized by feature
  (`Presentation/Home/…`). Components used by one feature stay inside it;
  promote to the shared design system only when a second feature needs them.
- **IOS-STRUCT-007 (MUST)** Tests mirror the source structure, so the test for
  `Domain/Workout/UseCases/StartWorkoutUseCase.swift` is
  `Tests/Domain/Workout/UseCases/StartWorkoutUseCaseTests.swift`.
- **IOS-STRUCT-008 (SHOULD)** Debug-only screens and QA tools live in a
  `Debug` folder and are compiled out of Release (`#if DEBUG`).
- **IOS-STRUCT-009 (SHOULD)** One primary type per file, file named after it.
  Small private helpers may share the file.
