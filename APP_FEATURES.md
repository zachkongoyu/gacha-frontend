# Application Flow and Features

## App Structure

```
┌─────────────────────────────────────┐
│         Gacha Frontend              │
│  (Material 3 Theme with Riverpod)   │
└─────────────────────────────────────┘
                │
    ┌───────────┴───────────┬──────────────┐
    │                       │              │
┌───▼────┐          ┌──────▼──────┐  ┌───▼────────┐
│Banners │          │ Inventory   │  │   Detail   │
│ Screen │◄─────────┤   Screen    │◄─┤   Viewer   │
└────────┘          └─────────────┘  └────────────┘
/banners            /inventory       /detail/:id
```

## Screen Details

### 1. Banners Screen (`/banners`)
**Purpose**: Main gacha banner display with pull functionality

**Features**:
- Beautiful gradient banner display
- Large "Pull x10" button (CTA)
- Navigation to inventory
- Stub pull functionality with snackbar feedback

**UI Elements**:
- AppBar with "Gacha Banners" title
- 300px height banner container with gradient
- Icon (auto_awesome) representing gacha
- Banner title and description
- Elevated button with casino icon
- Text button for inventory navigation

**State**: Stub data (no backend integration yet)

---

### 2. Inventory Screen (`/inventory`)
**Purpose**: Display collected items in a grid layout

**Features**:
- Grid layout (2 columns)
- 6 stub items with different rarities
- Color-coded rarity system:
  - SSR (Amber/Gold) - Sword of Light
  - SR (Purple) - Magic Staff, Ancient Shield  
  - R (Blue) - Iron Helmet, Leather Boots
  - N (Grey) - Health Potion
- Tap any item to view details
- Back button to return to banners

**UI Elements**:
- AppBar with "Inventory" title
- GridView with Cards
- Each card shows:
  - Item icon
  - Item name
  - Rarity badge
- Empty state message (if no items)

**State**: Stub data with 6 predefined items

---

### 3. Detail Viewer Screen (`/detail/:itemId`)
**Purpose**: 3D model viewer for individual items

**Features**:
- 3D model viewer using `model_viewer_plus`
- Auto-rotating 3D model
- Camera controls (pan, zoom, rotate)
- Item details display
- AR view button (stub)
- Share button (stub)

**UI Elements**:
- AppBar with item name
- 400px height 3D model viewer
  - Sample GLB model: Astronaut from modelviewer.dev
  - Auto-rotate enabled
  - Interactive camera controls
- Item name and rarity badge
- Description section
- Action buttons (AR view, Share)
- Scrollable content

**State**: Stub item details mapped by itemId

---

## Routing Flow

```
Initial Load
     │
     ▼
 /banners ──────────────┐
     │                  │
     │ Tap "View       │
     │  Inventory"     │
     ▼                  │
/inventory              │
     │                  │
     │ Tap item        │ Back
     ▼                  │ button
/detail/1 ──────────────┘
/detail/2
/detail/N
```

## Technical Implementation

### State Management (Riverpod)
- `routerProvider`: Provides GoRouter instance
- Future providers for API calls (in api_service.dart)
- Provider scope wraps entire app

### HTTP Client (Dio)
```dart
const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:3000',
);
```
- Configured in `lib/services/api_service.dart`
- Base URL from `--dart-define=API_BASE_URL`
- Logging interceptor for debugging
- Timeout: 10 seconds
- Graceful error handling (returns empty/null for stub)

### 3D Model Viewer
- Package: `model_viewer_plus`
- Sample model: https://modelviewer.dev/shared-assets/models/Astronaut.glb
- Features:
  - Auto-rotate
  - Camera controls
  - Background color matching theme

### Local Storage (Hive)
- Initialized in main.dart
- Ready for future data persistence
- No data stored yet (stub phase)

### Theming (Material 3)
- Seed color: Deep Purple
- Both light and dark themes
- Color scheme generation from seed
- Modern Material Design 3 components

## Navigation Examples

### Go to Inventory
```dart
context.go('/inventory');
```

### Go to Detail (with parameter)
```dart
context.go('/detail/${item['id']}');
```

### Go to Banners
```dart
context.go('/banners');
```

## API Integration (Future)

The ApiService is ready for backend integration:

```dart
// Fetch banners
await apiService.fetchBanners();

// Fetch inventory
await apiService.fetchInventory();

// Fetch item details
await apiService.fetchItemDetails('item-id');
```

Currently returns stub data or empty responses.

## Environment Configuration

### Run with custom API URL:
```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com
```

### Run with default (localhost):
```bash
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

### Or simply:
```bash
flutter run
# Uses default: http://localhost:3000
```

## Stub Data

### Inventory Items (6 total)
1. **Sword of Light** - SSR
2. **Magic Staff** - SR
3. **Ancient Shield** - SR
4. **Iron Helmet** - R
5. **Leather Boots** - R
6. **Health Potion** - N

Each item has:
- ID
- Name
- Rarity
- Description

## Future Enhancements (Not in Scope)

- Actual gacha pull logic
- Backend API integration
- Real 3D models for items
- AR implementation using ar_flutter_plugin
- User authentication
- Item inventory persistence with Hive
- Pull history
- Animation effects
- Sound effects
- Pity system
- Currency system

## Platform Support

✅ **Android** (API 21+)
- Full support
- 3D model viewer works
- AR ready (needs implementation)

✅ **iOS** (11+)
- Full support
- 3D model viewer works
- AR ready (needs implementation)

✅ **Web**
- Full support
- 3D model viewer works via WebGL
- No AR support on web

✅ **Desktop** (Linux, macOS, Windows)
- Basic support
- 3D model viewer works
- No AR support on desktop

## Performance Notes

- Model viewer requires internet for GLB download
- Initial model load may take a few seconds
- Auto-rotate is smooth and performant
- Grid layout is efficient with Flutter's rendering
- No performance issues expected with stub data
