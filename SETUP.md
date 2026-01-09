# Setup Instructions

## Prerequisites

Before running this Flutter project, ensure you have the following installed:

### 1. Install Flutter SDK

Visit [flutter.dev](https://flutter.dev/docs/get-started/install) and follow the installation instructions for your operating system.

For Linux:
```bash
# Download Flutter SDK
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.9-stable.tar.xz

# Extract
tar xf flutter_linux_3.16.9-stable.tar.xz

# Add to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Run flutter doctor
flutter doctor
```

For macOS:
```bash
# Using Homebrew
brew install --cask flutter

# Or download from flutter.dev
```

For Windows:
- Download the Flutter SDK from flutter.dev
- Extract and add to PATH
- Run `flutter doctor` in PowerShell/CMD

### 2. Verify Installation

```bash
flutter doctor
```

This command checks your environment and displays a report of the status of your Flutter installation.

### 3. Install Dependencies

Once Flutter is installed:

```bash
cd /path/to/gacha-frontend
flutter pub get
```

### 4. Run the Application

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

## Platform-Specific Setup

### Android
- Install Android Studio
- Install Android SDK
- Set up an Android emulator or connect a physical device
- Accept Android licenses: `flutter doctor --android-licenses`

### iOS (macOS only)
- Install Xcode from the App Store
- Install CocoaPods: `sudo gem install cocoapods`
- Set up iOS simulator or connect a physical device

### Web
- No additional setup required
- Run with: `flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:3000`

### Linux Desktop
- Install required dependencies:
  ```bash
  sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
  ```

## Troubleshooting

### Common Issues

**Issue**: `flutter: command not found`
- **Solution**: Add Flutter to your PATH environment variable

**Issue**: Plugin dependencies fail to install
- **Solution**: Run `flutter pub cache repair` then `flutter pub get`

**Issue**: Model viewer not working
- **Solution**: Ensure you're running on a platform that supports WebView (Android API 21+, iOS 11+, Web)

**Issue**: API connection fails
- **Solution**: Verify the API_BASE_URL is correct and accessible from your device/emulator

## Development Workflow

1. Make code changes
2. Hot reload: Press `r` in the terminal where Flutter is running
3. Hot restart: Press `R` in the terminal
4. Stop app: Press `q` in the terminal

## Building for Production

### Android APK
```bash
flutter build apk --dart-define=API_BASE_URL=https://your-production-api.com
```

### iOS
```bash
flutter build ios --dart-define=API_BASE_URL=https://your-production-api.com
```

### Web
```bash
flutter build web --dart-define=API_BASE_URL=https://your-production-api.com
```
