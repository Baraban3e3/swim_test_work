# Swim Test App

🎥 **[Watch the Loom Video Walkthrough (5:40)](https://www.loom.com/share/cf0f0a43100a40bd877e1320d410ebc8)**
This repository contains the Flutter application built for the technical assessment. It features a User List screen that fetches data from an API, a User Details screen, and a custom Pace Selector UI with dynamic logic and localization.

## State Management

**Choice:** `flutter_bloc` (BLoC Pattern)

**Why:**
I chose BLoC because it enforces a strict separation between the presentation layer and business logic. It provides predictable, stream-based state transitions which makes debugging and testing significantly easier. As the application grows, BLoC scales exceptionally well, keeping UI components clean and focused solely on rendering state. 

## Project Structure

The project follows a **Feature-first Clean Architecture** approach:

```text
lib/
 ├── core/              # Shared resources (Theme, Colors, Localization setup, DI)
 ├── features/          # Feature modules
 │   ├── pace_selector/ # Pace selector logic and UI
 │   └── users/         # Users list and details fetching/display
 ├── injection_container.dart # GetIt dependency injection setup
 └── main.dart          # Entry point
```

Each feature is divided into:
- **`data/`**: Models, Data Sources (API calls), and Repositories implementations.
- **`domain/`**: Entities, Repositories interfaces, and UseCases (business logic).
- **`presentation/`**: Pages, Widgets, and BLoC/Cubit state management.

This structure ensures that changes in the UI or Data layer do not affect the Domain layer, adhering to the Dependency Inversion Principle.

## Swimmer Level Ranges

The application calculates the swimmer's level dynamically based on their total 100m freestyle pace time (in seconds). The ranges are defined as follows:

- **Elite**: 0:00 – 1:10 (0 - 70 seconds)
- **Advanced**: 1:11 – 1:30 (71 - 90 seconds)
- **Intermediate**: 1:31 – 2:30 (91 - 150 seconds)
- **Beginner**: 2:31 – 4:00 (151 - 240 seconds)

## Localization

The application is fully localized using `easy_localization`. It currently supports **English** (`en`) and **Ukrainian** (`uk`). All text strings are extracted into JSON files in the `assets/translations/` directory, ensuring scalability when adding new languages in the future.

## Testing

The project includes a robust suite of unit tests verifying all critical layers:
- **Domain**: Entity boundary conditions and level parsing logic (`PaceEntity`).
- **Data**: Data source HTTP mocking (`PaceRemoteDataSource`) and repository exception-to-failure mapping (`UsersRepositoryImpl`).
- **Presentation**: BLoC/Cubit state transition testing using `bloc_test`, including complex validation like search filtering and pace parameter clamping.

Tests are run using:
```bash
flutter test
```

## Future Improvements (With More Time)

If I had more time to work on this project, I would implement the following:

1. **Widget Tests:** Add UI widget tests for complex custom UI components like the `PaceSlider`.
2. **Advanced Error Handling:** Integrate functional programming concepts (e.g., using `fpdart` or `dartz` for `Either` types) to explicitly handle failures and successes throughout the domain layer without relying heavily on exceptions.
3. **Offline Support:** Implement local caching (e.g., using `hive` or `sqflite`) for the Users API so the app can function smoothly offline.
4. **Design System:** Extract all colors, typography, and reusable components (buttons, custom inputs) into an isolated internal design system package to enforce consistency.
5. **Localization Automation:** Set up automated translation generation and stricter key typing for `easy_localization`.
