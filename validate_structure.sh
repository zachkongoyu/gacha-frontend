#!/bin/bash
# Flutter Project Structure Validation Script

echo "=== Flutter Gacha Frontend Project Validation ==="
echo ""

# Check for required files
echo "Checking project structure..."
files=(
    "pubspec.yaml"
    "analysis_options.yaml"
    "lib/main.dart"
    "lib/screens/banners_screen.dart"
    "lib/screens/inventory_screen.dart"
    "lib/screens/detail_viewer_screen.dart"
    "lib/services/api_service.dart"
    "android/app/build.gradle"
    "android/app/src/main/AndroidManifest.xml"
    "ios/Runner/Info.plist"
    "web/index.html"
    "test/widget_test.dart"
)

missing_files=0
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file"
    else
        echo "✗ $file (MISSING)"
        missing_files=$((missing_files + 1))
    fi
done

echo ""
if [ $missing_files -eq 0 ]; then
    echo "✓ All required files present!"
else
    echo "✗ Missing $missing_files file(s)"
    exit 1
fi

echo ""
echo "Checking dependencies in pubspec.yaml..."
dependencies=(
    "flutter_riverpod"
    "go_router"
    "dio"
    "model_viewer_plus"
    "ar_flutter_plugin"
    "hive"
    "hive_flutter"
)

missing_deps=0
for dep in "${dependencies[@]}"; do
    if grep -q "$dep:" pubspec.yaml; then
        echo "✓ $dep"
    else
        echo "✗ $dep (MISSING)"
        missing_deps=$((missing_deps + 1))
    fi
done

echo ""
if [ $missing_deps -eq 0 ]; then
    echo "✓ All required dependencies present in pubspec.yaml!"
else
    echo "✗ Missing $missing_deps dependency/dependencies"
    exit 1
fi

echo ""
echo "Project structure validation complete!"
echo ""
echo "Next steps:"
echo "1. Install Flutter SDK (see SETUP.md)"
echo "2. Run: flutter pub get"
echo "3. Run: flutter run --dart-define=API_BASE_URL=http://localhost:3000"
