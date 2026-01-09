#!/bin/bash
# Comprehensive Flutter Project Verification

echo "=================================================="
echo "  Flutter Gacha Frontend - Project Verification"
echo "=================================================="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

success_count=0
total_checks=0

check_result() {
    total_checks=$((total_checks + 1))
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
        success_count=$((success_count + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $2"
        return 1
    fi
}

echo "1. Checking project structure..."
echo "--------------------------------"

# Check main directories
[ -d "lib" ] && check_result 0 "lib/ directory exists" || check_result 1 "lib/ directory exists"
[ -d "android" ] && check_result 0 "android/ directory exists" || check_result 1 "android/ directory exists"
[ -d "ios" ] && check_result 0 "ios/ directory exists" || check_result 1 "ios/ directory exists"
[ -d "web" ] && check_result 0 "web/ directory exists" || check_result 1 "web/ directory exists"
[ -d "test" ] && check_result 0 "test/ directory exists" || check_result 1 "test/ directory exists"

echo ""
echo "2. Checking configuration files..."
echo "-----------------------------------"

[ -f "pubspec.yaml" ] && check_result 0 "pubspec.yaml exists" || check_result 1 "pubspec.yaml exists"
[ -f "analysis_options.yaml" ] && check_result 0 "analysis_options.yaml exists" || check_result 1 "analysis_options.yaml exists"
[ -f ".gitignore" ] && check_result 0 ".gitignore exists" || check_result 1 ".gitignore exists"

echo ""
echo "3. Checking Dart source files..."
echo "---------------------------------"

[ -f "lib/main.dart" ] && check_result 0 "lib/main.dart exists" || check_result 1 "lib/main.dart exists"
[ -f "lib/screens/banners_screen.dart" ] && check_result 0 "lib/screens/banners_screen.dart exists" || check_result 1 "lib/screens/banners_screen.dart exists"
[ -f "lib/screens/inventory_screen.dart" ] && check_result 0 "lib/screens/inventory_screen.dart exists" || check_result 1 "lib/screens/inventory_screen.dart exists"
[ -f "lib/screens/detail_viewer_screen.dart" ] && check_result 0 "lib/screens/detail_viewer_screen.dart exists" || check_result 1 "lib/screens/detail_viewer_screen.dart exists"
[ -f "lib/services/api_service.dart" ] && check_result 0 "lib/services/api_service.dart exists" || check_result 1 "lib/services/api_service.dart exists"

echo ""
echo "4. Verifying required dependencies..."
echo "--------------------------------------"

grep -q "flutter_riverpod:" pubspec.yaml && check_result 0 "flutter_riverpod dependency" || check_result 1 "flutter_riverpod dependency"
grep -q "go_router:" pubspec.yaml && check_result 0 "go_router dependency" || check_result 1 "go_router dependency"
grep -q "dio:" pubspec.yaml && check_result 0 "dio dependency" || check_result 1 "dio dependency"
grep -q "model_viewer_plus:" pubspec.yaml && check_result 0 "model_viewer_plus dependency" || check_result 1 "model_viewer_plus dependency"
grep -q "ar_flutter_plugin:" pubspec.yaml && check_result 0 "ar_flutter_plugin dependency" || check_result 1 "ar_flutter_plugin dependency"
grep -q "hive:" pubspec.yaml && check_result 0 "hive dependency" || check_result 1 "hive dependency"
grep -q "hive_flutter:" pubspec.yaml && check_result 0 "hive_flutter dependency" || check_result 1 "hive_flutter dependency"

echo ""
echo "5. Verifying key implementations..."
echo "------------------------------------"

grep -q "ProviderScope" lib/main.dart && check_result 0 "ProviderScope in main.dart" || check_result 1 "ProviderScope in main.dart"
grep -q "GoRouter" lib/main.dart && check_result 0 "GoRouter in main.dart" || check_result 1 "GoRouter in main.dart"
grep -q "useMaterial3: true" lib/main.dart && check_result 0 "Material 3 theming" || check_result 1 "Material 3 theming"
grep -q "ModelViewer" lib/screens/detail_viewer_screen.dart && check_result 0 "ModelViewer in detail screen" || check_result 1 "ModelViewer in detail screen"
grep -q "API_BASE_URL" lib/services/api_service.dart && check_result 0 "API_BASE_URL environment variable" || check_result 1 "API_BASE_URL environment variable"
grep -q "fromEnvironment" lib/services/api_service.dart && check_result 0 "String.fromEnvironment for API_BASE_URL" || check_result 1 "String.fromEnvironment for API_BASE_URL"

echo ""
echo "6. Checking route configuration..."
echo "-----------------------------------"

grep -q "'/banners'" lib/main.dart && check_result 0 "/banners route" || check_result 1 "/banners route"
grep -q "'/inventory'" lib/main.dart && check_result 0 "/inventory route" || check_result 1 "/inventory route"
grep -q "'/detail/:itemId'" lib/main.dart && check_result 0 "/detail/:itemId route" || check_result 1 "/detail/:itemId route"

echo ""
echo "7. Verifying platform files..."
echo "-------------------------------"

[ -f "android/app/build.gradle" ] && check_result 0 "Android build.gradle" || check_result 1 "Android build.gradle"
[ -f "android/app/src/main/AndroidManifest.xml" ] && check_result 0 "AndroidManifest.xml" || check_result 1 "AndroidManifest.xml"
[ -f "ios/Runner/Info.plist" ] && check_result 0 "iOS Info.plist" || check_result 1 "iOS Info.plist"
[ -f "web/index.html" ] && check_result 0 "Web index.html" || check_result 1 "Web index.html"

echo ""
echo "8. Checking documentation..."
echo "-----------------------------"

[ -f "README.md" ] && check_result 0 "README.md" || check_result 1 "README.md"
[ -f "SETUP.md" ] && check_result 0 "SETUP.md" || check_result 1 "SETUP.md"
grep -q "flutter run --dart-define" README.md && check_result 0 "README contains run instructions" || check_result 1 "README contains run instructions"

echo ""
echo "9. Validating YAML syntax..."
echo "-----------------------------"

python3 -c "import yaml; yaml.safe_load(open('pubspec.yaml'))" 2>/dev/null
if [ $? -eq 0 ]; then
    check_result 0 "pubspec.yaml is valid YAML"
else
    check_result 1 "pubspec.yaml is valid YAML"
fi

python3 -c "import yaml; yaml.safe_load(open('analysis_options.yaml'))" 2>/dev/null
if [ $? -eq 0 ]; then
    check_result 0 "analysis_options.yaml is valid YAML"
else
    check_result 1 "analysis_options.yaml is valid YAML"
fi

echo ""
echo "10. Checking for hardcoded secrets..."
echo "--------------------------------------"

# Check for common secret patterns (should not find any)
if grep -r -i "api[_-]key\s*=\s*['\"][^'\"]\{10,\}['\"]" lib/ 2>/dev/null; then
    check_result 1 "No hardcoded API keys"
else
    check_result 0 "No hardcoded API keys"
fi

if grep -r -i "password\s*=\s*['\"][^'\"]\{3,\}['\"]" lib/ 2>/dev/null; then
    check_result 1 "No hardcoded passwords"
else
    check_result 0 "No hardcoded passwords"
fi

if grep -r -i "secret\s*=\s*['\"][^'\"]\{10,\}['\"]" lib/ 2>/dev/null; then
    check_result 1 "No hardcoded secrets"
else
    check_result 0 "No hardcoded secrets"
fi

echo ""
echo "=================================================="
echo "  Verification Summary"
echo "=================================================="
echo ""
echo "Total checks: $total_checks"
echo -e "Passed: ${GREEN}$success_count${NC}"
echo -e "Failed: ${RED}$((total_checks - success_count))${NC}"
echo ""

if [ $success_count -eq $total_checks ]; then
    echo -e "${GREEN}✓ All verifications passed!${NC}"
    echo ""
    echo "The Flutter project structure is complete and ready."
    echo "Next steps:"
    echo "  1. Install Flutter SDK (see SETUP.md)"
    echo "  2. Run: flutter pub get"
    echo "  3. Run: flutter run --dart-define=API_BASE_URL=http://localhost:3000"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Some verifications failed.${NC}"
    echo "Please review the failed checks above."
    echo ""
    exit 1
fi
