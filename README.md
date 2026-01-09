# Gacha Frontend

A Flutter-based gacha app frontend with 3D model viewing and AR support.

## Features

- **Banners Screen**: View and interact with gacha banners (stub pull functionality)
- **Inventory Screen**: Browse collected items in a grid layout
- **Detail Viewer**: View 3D models of items using model_viewer_plus
- **Routing**: Navigation powered by go_router
- **State Management**: Riverpod for reactive state management
- **HTTP Client**: Dio for API communication
- **Local Storage**: Hive for local data persistence
- **Material 3**: Modern Material Design 3 theming

## Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher

## Dependencies

- `flutter_riverpod`: State management
- `go_router`: Declarative routing
- `dio`: HTTP client
- `model_viewer_plus`: 3D model viewer
- `ar_flutter_plugin`: AR support
- `hive` & `hive_flutter`: Local storage

## Getting Started

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Run the app

Run with default API URL (http://localhost:3000):

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

Or specify a custom API URL:

```bash
flutter run --dart-define=API_BASE_URL=https://your-api-url.com
```

### 3. Run on specific platform

For web:
```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:3000
```

For Android:
```bash
flutter run -d android --dart-define=API_BASE_URL=http://localhost:3000
```

For iOS:
```bash
flutter run -d ios --dart-define=API_BASE_URL=http://localhost:3000
```

## Project Structure

```
lib/
├── main.dart                 # App entry point with ProviderScope and routing
├── screens/                  # UI screens
│   ├── banners_screen.dart   # Gacha banners with pull CTA
│   ├── inventory_screen.dart # Item grid view
│   └── detail_viewer_screen.dart # 3D model viewer
├── services/                 # Service layer
│   └── api_service.dart      # HTTP client with dio
├── providers/                # Riverpod providers
└── models/                   # Data models
```

## Navigation Routes

- `/banners` - Gacha banners screen (default)
- `/inventory` - Inventory grid screen
- `/detail/:itemId` - Item detail with 3D viewer

## Configuration

The app uses `--dart-define` for environment configuration:

- `API_BASE_URL`: Backend API base URL (default: http://localhost:3000)

No hardcoded secrets are included in the codebase.

## Development

### Linting

```bash
flutter analyze
```

### Testing

```bash
flutter test
```

## Notes

- The 3D model viewer uses a sample GLB model from modelviewer.dev
- Stub data is used for banners and inventory items
- AR functionality is prepared but requires actual implementation
- API calls gracefully handle errors and return empty/null for stub purposes
