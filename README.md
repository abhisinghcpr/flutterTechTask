# Magnet - Flutter Home Screen + Google Login

A production-ready Flutter application recreating the **Magnet** Home Screen UI with Google Authentication, offline handling, and clean modular architecture.

---

## 📱 Features

### Part 1: Magnet Home Screen UI
- **Design Fidelity**: Pixel-accurate recreation of the Magnet UI (Profile Card, Visitor Analytics Card with custom bezier chart painter, Social Feeds, Shop Section, Web Templates, and floating Navigation Pill).
- **Responsive Layout**:
  - Automatically adapts across compact phones, large phones, landscape orientation, and tablets without overflow errors.
  - On larger screens/landscape, adapts into a modern two-column layout.
- **Clean Architecture & Central Design System**:
  - Unified theme, palette (`AppColors`), text styles, and spacing dimensions (`AppDimens`).
  - No hardcoded strings or raw hex colors inside widgets (`AppStrings`).
  - Modular data models and dummy data served via `MockMagnetRepository`.
- **Accessibility & Safe Area**:
  - Respects device `SafeArea`, status bars, and system font scaling.

### Part 2: Google Login & Offline Handling
- **Google Sign-In**: Integrated with Firebase Authentication (`firebase_auth` + `google_sign_in`).
- **Session Persistence**: Returning users automatically bypass the login screen and land directly on the Home Screen.
- **Local Profile Caching**: User profile attributes (name, email, and photo) are saved into `shared_preferences`.
- **Real-time Offline Detection**:
  - Monitored continuously via `connectivity_plus`.
  - When disconnected (e.g. Airplane Mode), an animated **"You are offline"** banner automatically appears at the top.
  - The Profile Card seamlessly transitions to show cached name and email with an offline cache indicator.
  - Automatically resumes normal online mode the moment internet is restored.
- **Logout with Cache Invalidation**:
  - Dedicated logout action with confirmation dialog.
  - Signs out from both Firebase and Google accounts and clears locally cached data from `shared_preferences`.
- **Error Handling**:
  - Graceful handling for cancelled sign-ins, network timeouts, and Firebase authentication errors via GetX snackbars.

---

## 🏗️ Architecture & Project Structure

The project follows clean layer separation (`core / data / presentation`):

```text
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # Centralized theme colors
│   │   ├── app_dimens.dart        # Padding, margin, and border radius tokens
│   │   └── app_strings.dart       # All static text strings (no hardcoded text)
│   └── theme/
│       └── app_theme.dart         # Material 3 light theme configuration
├── data/
│   ├── models/
│   │   ├── profile_model.dart
│   │   ├── shop_item_model.dart
│   │   ├── social_post_model.dart
│   │   ├── visitor_analytics_model.dart
│   │   └── web_template_model.dart
│   └── repositories/
│       └── mock_magnet_repository.dart  # Mock repository providing dummy data
├── presentation/
│   ├── controllers/
│   │   └── auth_controller.dart   # GetX controller for auth, connectivity & storage
│   ├── screens/
│   │   ├── home/
│   │   │   └── home_screen.dart   # Responsive home screen with Obx reactivity
│   │   ├── login/
│   │   │   └── login_screen.dart  # Google sign-in screen
│   │   └── splash/
│   │       └── splash_screen.dart # Initial session check
│   └── widgets/
│       ├── bottom_nav_bar_pill.dart
│       ├── magnet_header.dart
│       ├── offline_banner.dart
│       ├── profile_card.dart
│       ├── shop_section.dart
│       ├── social_feed_card.dart
│       ├── visitor_analytics_card.dart
│       └── web_templates_section.dart
├── firebase_options.dart
└── main.dart
```

---

## 📦 Packages Used

| Package | Version | Purpose |
| :--- | :--- | :--- |
| **`get`** | `^4.7.3` | State management, reactive streams (`Obx`), dialogs, routing |
| **`firebase_core`** | `^4.15.0` | Firebase initialization |
| **`firebase_auth`** | `^6.7.0` | User authentication & credential management |
| **`google_sign_in`** | `^7.2.0` | Native Google OAuth flow |
| **`shared_preferences`**| `^2.5.5` | Persistent local storage for user profile data |
| **`connectivity_plus`** | `^7.3.2` | Real-time network connectivity monitoring |
| **`cupertino_icons`** | `^1.0.8` | Cupertino icons set |

---

## 🚀 Setup & Installation

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.24.0`)
- Android Studio / VS Code with Flutter extension
- An Android device or emulator with Google Play Services

### 1. Clone the Repository
```bash
git clone <your-repo-link>
cd task_assigment
```

### 2. Configure Firebase (Do Not Commit Secrets)
1. Register an Android app in your [Firebase Console](https://console.firebase.google.com/) with package name:
   `com.example.task_assigment` (or your configured application ID).
2. Download your `google-services.json` file and place it in:
   ```text
   android/app/google-services.json
   ```
   *(A template is provided at `android/app/google-services.json.example`)*.
3. Enable **Google Sign-In** under **Firebase Authentication > Sign-in method**.
4. Add your machine's SHA-1 and SHA-256 fingerprint to your Firebase Android app settings.

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run the Application
```bash
flutter run
```

---

## 🧪 Testing Guide

- **Run Analysis**:
  ```bash
  flutter analyze
  ```
- **Run Unit Tests**:
  ```bash
  flutter test
  ```
- **Offline Behavior Test**:
  1. Launch the app and sign in with Google while connected to the internet.
  2. Notice your name, email, and photo appearing on the profile card.
  3. Turn on **Airplane Mode** (or disable Wi-Fi and Mobile Data).
  4. Notice the **"You are offline"** banner instantly slide in, and the profile card displaying locally saved profile data.
  5. Turn internet back on — the banner immediately dismisses and live online status resumes.
- **Rotation / Responsive Test**:
  - Rotate your mobile device to Landscape or run on a Tablet to observe the adaptive 2-column layout.

---

## 📦 Building the Release APK

To generate a standalone production APK:
```bash
flutter build apk --release
```
The output file will be generated at:
```text
build/app/outputs/flutter-apk/app-release.apk
```
