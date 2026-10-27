# SwiftUI

- **IOS-UI-001 (MUST)** View models are `@MainActor @Observable final class`.
  Do not use `ObservableObject`, `@Published`, `@StateObject`, or
  `@ObservedObject` in new code.
- **IOS-UI-002 (MUST)** A view that owns its view model stores it in
  `@State private var viewModel` and receives it through `init`.
- **IOS-UI-003 (MUST)** Start async work with `.task { }` (or
  `.task(id:)`), not `.onAppear { Task { } }`. *Why:* `.task` is cancelled with
  the view; a bare `Task` leaks work.
- **IOS-UI-004 (SHOULD)** Screen state is one value (`enum` or `struct`)
  covering loading, content, empty, and error, instead of several independent
  booleans that can contradict each other.
- **IOS-UI-005 (MUST)** View models guard against duplicate loads (a second
  `load()` while one is running does not start another request).
- **IOS-UI-006 (MAY)** For screens with external dependencies, a view may be
  generic over a `<Feature>ViewModelContract` protocol (`@MainActor`,
  `AnyObject`, `Observable`), exposing only the state and actions the view
  uses. Use it when previews or tests need a fake view model.
- **IOS-UI-007 (SHOULD)** Pure presentational views take values and closures,
  not view models.
- **IOS-UI-008 (SHOULD)** Keep `body` small: extract subviews into separate
  `View` structs rather than computed properties returning `some View` when
  they have their own state or are reused.
- **IOS-UI-009 (SHOULD)** Every screen has a `#Preview` that works without
  network, real persistence, or secrets (inject stubs).
- **IOS-UI-010 (SHOULD)** Navigation is value-based (`NavigationStack` with a
  route enum). The view model or a router decides where to go; views do not
  build destination dependencies themselves.
- **IOS-UI-011 (MUST)** Use `@Environment` for system values and app-wide
  services only; feature dependencies are injected explicitly.

```swift
@MainActor
@Observable
final class HomeViewModel {
    private(set) var state: HomeScreenState = .loading
    private let fetchWorkouts: FetchWorkoutsUseCase
    private var isLoading = false

    init(fetchWorkouts: FetchWorkoutsUseCase) {
        self.fetchWorkouts = fetchWorkouts
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            state = .content(try await fetchWorkouts.execute())
        } catch {
            state = .error(HomeErrorMessage(error))
        }
    }
}

struct HomeView: View {
    @State private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        content.task { await viewModel.load() }
    }
}
```
