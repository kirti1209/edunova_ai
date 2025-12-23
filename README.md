# Edunova AI

Flutter-based learning dashboard with email login, personalized welcome, quick stats, focus chips, course cards, and highlights.

## Features
- Email login powered by Firebase (see `lib/features/login`)
- Dashboard with greeting header, quick stats, focus chips, courses, and highlights (`lib/features/Dashboard`)
- Light gradient background and reusable widgets for cards/chips

## Prerequisites
- Flutter 3.x
- Dart SDK (bundled with Flutter)
- Firebase project keys (copy `google-services.json` into `android/app` and `GoogleService-Info.plist` into `ios/Runner`)

## Setup
1) Install dependencies
```
flutter pub get
```
2) Configure Firebase
- Update `lib/firebase_options.dart` via `flutterfire configure` or by adding your keys manually.
- Ensure Android/iOS platform config files are placed as noted above.

## Run
```
flutter run
```
Use `-d chrome`, `-d android`, or `-d ios` to target a specific device/emulator.

## Build
- Android: `flutter build apk` or `flutter build appbundle`
- iOS: `flutter build ios`
- Web: `flutter build web`

## Project structure (key parts)
- `lib/main.dart` — app entry
- `lib/constants/` — theme/colors/strings
- `lib/features/login/` — auth UI + service
- `lib/features/Dashboard/` — dashboard screens and widgets

