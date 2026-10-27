# Recipe: Add A Feature

Example: adding `Bookings`. Adapt folder names to the project's structure
(see the project wiki).

1. **Domain**

   ```text
   Domain/Booking/Models/Booking.swift
   Domain/Booking/Errors/BookingError.swift
   Domain/Booking/Repositories/BookingRepository.swift
   Domain/Booking/UseCases/FetchBookingsUseCase.swift
   ```

2. **Data**

   ```text
   Data/Models/BookingDTO.swift            (only for external payloads)
   Data/Mappers/BookingMapper.swift        (if reusable or non-trivial)
   Data/Repositories/RemoteBookingRepository.swift
   ```

   The repository implements `BookingRepository`, uses the shared HTTP client
   or SDK directly, maps to Domain, and translates errors.

3. **Presentation**

   ```text
   Presentation/Bookings/ViewModels/BookingsScreenState.swift
   Presentation/Bookings/ViewModels/BookingsViewModel.swift
   Presentation/Bookings/Views/BookingsView.swift
   ```

4. **Composition**: wire the repository, use case, and view model in the
   composition root (`DI`, container, or factory). The view never builds its
   dependencies.

5. **Navigation**: add a route case only if the feature is navigable.

6. **Localization**: add every string to the catalog in every shipped language.

7. **Tests**

   ```text
   Domain/Booking/UseCases/FetchBookingsUseCaseTests.swift
   Data/Mappers/BookingMapperTests.swift
   Data/Repositories/RemoteBookingRepositoryTests.swift
   Presentation/Bookings/ViewModels/BookingsViewModelTests.swift
   ```

8. **Verify**: build, run tests, check the screen in light/dark and at a large
   Dynamic Type size.
