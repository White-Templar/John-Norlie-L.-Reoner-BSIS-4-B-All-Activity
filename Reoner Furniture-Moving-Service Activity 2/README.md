# Furniture Moving Service (Frontend-only)

Simple Flutter app showcasing:
- Stateless Hello World
- Stateful counter with button
- Reusable custom button
- Material and Cupertino variants of the same screens
- Two-page navigation via Drawer and BottomNavigationBar
- Staggered grid using `flutter_staggered_grid_view`

## Project Structure

```
lib/
  models/            // Plain data types (e.g., MovingServiceItem)
  services/          // Simple repositories (fake/local data only)
  widgets/           // Reusable UI components (PrimaryButton)
  views/
    home/            // Home shell for Material and Cupertino
    screens/         // Simple pages (Hello, Counter)
  main.dart          // App root and platform switcher
```

Why this layout:
- Separation by role keeps files short and easy to find.
- `models` and `services` are UI-agnostic and reusable.
- `widgets` holds small composable pieces used across screens.
- `views` groups user-facing pages and platform-specific shells.

## Run

1) Install dependencies
```
flutter pub get
```
2) Run the app
```
flutter run
```

## Widget Tree (high level)

```
MaterialApp
 └─ RootSwitcher (Stateful)
     ├─ HomeMaterial (Scaffold)
     │   ├─ AppBar(actions: toggle platform)
     │   ├─ Drawer → (Dashboard | Hello | Counter)
     │   ├─ Body: Indexed pages
     │   │   ├─ _HomeDashboard → MasonryGridView(ServiceCard + PrimaryButton)
     │   │   ├─ HelloPage (Stateless) → PrimaryButton
     │   │   └─ CounterPage (Stateful) → PrimaryButton
     │   └─ BottomNavigationBar (3 tabs)
     └─ HomeCupertino (CupertinoTabScaffold)
         ├─ Tab 0: List of services + PrimaryButton
         ├─ Tab 1: HelloPage(cupertino)
         └─ Tab 2: CounterPage(cupertino)
```

Refactoring example:
- The dashboard view was split into `_HomeDashboard` and `PrimaryButton` to keep each widget small and reusable.

## Packages

- `flutter_staggered_grid_view`: Used to build a simple masonry grid for services.

Note: This app is frontend-only. There is no backend or network I/O.
