# App Development Rules

> **Purpose**: Standard guidelines for building utility apps for Google Play Store approval.
> **Target**: Fast approval, professional quality, zero user data collection.

---
## General Development Guidelines

- **Dependency Management**: Never manually edit `pubspec.yaml`. Always use terminal commands (e.g., `flutter pub add`) to add dependencies to ensure the latest compatible versions are used.
- **Data Modeling**: Use standard Dart classes for all data models. Do not use `freezed` or other code-generation libraries.

---

## 1. Architecture Pattern

### Use: Feature-First with Minimal MVVM

```
lib/
├── core/
│   ├── theme/           # App theme definition
│   ├── constants/       # App constants
│   └── services/        # Shared services (storage, etc.)
├── features/
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── home_view_model.dart
│   ├── settings/
│   │   ├── settings_screen.dart
│   │   └── settings_view_model.dart
│   └── about/
│       └── about_screen.dart (just talk only about the app and not the developers man)
└── main.dart
```

### Rules
- ✅ **Feature-First** folder structure
- ✅ **Minimal MVVM** - Screen + ViewModel per feature
- ❌ **DO NOT** use Clean Architecture (too complex for utility apps)
- ❌ **DO NOT** create domain/data/presentation layers
- ❌ **DO NOT** over-engineer with repositories, use cases, entities
- ✅ Keep it simple - ViewModel handles logic, Screen handles UI

### ViewModel Pattern
```dart
class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String _result = '';
  String get result => _result;
  
  Future<void> performAction(String input) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Perform app logic here
      _result = 'Success: $input';
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

---

## 2. Theming & Colors

### Use: Theme-Based Colors ONLY

### Rules
- ✅ **ALWAYS** use `Theme.of(context).colorScheme.xxx`
- ❌ **NEVER** hardcode colors like `Color(0xFF10B981)` or `Colors.green`
- ❌ **NEVER** use inline color definitions
- ✅ Define theme once in `core/theme/app_theme.dart`
- ✅ Support both Light and Dark modes

### Theme Definition
```dart
// core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Primary brand color
  static const Color _primaryColor = Color(0xFF10B981); // Emerald
  
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
    ),
    // Additional theme customizations...
  );
  
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
    // Additional theme customizations...
  );
}
```

### Usage in Widgets
```dart
// ✅ CORRECT
Container(
  color: Theme.of(context).colorScheme.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
  ),
)

// ❌ WRONG - Never do this
Container(
  color: Color(0xFF10B981), // Hardcoded!
  child: Text('Hello', style: TextStyle(color: Colors.white)),
)
```

### ColorScheme Properties to Use
| Property | Usage |
|----------|-------|
| `primary` | Main brand color (buttons, highlights) |
| `onPrimary` | Text/icons on primary color |
| `secondary` | Secondary accent |
| `surface` | Card/container backgrounds |
| `onSurface` | Text on surfaces |
| `error` | Error states |
| `outline` | Borders, dividers |

---

## 3. Local Storage

### Use: Hive Box (Simple Mode)

### Rules
- ✅ **ONLY** use `Hive.box<String>()` or simple types
- ❌ **DO NOT** use Hive adapters or TypeAdapters
- ❌ **DO NOT** create complex models for Hive
- ✅ Store data as JSON strings if needed
- ✅ Keep it simple - store primitives

### Setup
```dart
// main.dart
await Hive.initFlutter();
await Hive.openBox<String>('app_data');
await Hive.openBox<String>('settings');
```

### Usage
```dart
// Store data
final dataBox = Hive.box<String>('app_data');
dataBox.put('favorite_item', jsonEncode({
  'id': '123',
  'name': 'Item 1',
  'timestamp': DateTime.now().toIso8601String(),
}));

// Read data
final itemJson = dataBox.get('favorite_item');
if (itemJson != null) {
  final item = jsonDecode(itemJson);
}

// Clear data
await dataBox.clear();
```

---

## 4. App Completeness (Anti-Spam)

### Required Screens for Play Store Approval

Every app MUST have these screens to look professional:

| Screen | Purpose | Required |
|--------|---------|----------|
| **Home** | Main functionality | ✅ Yes |
| **Settings** | User preferences | ✅ Yes |
| **About** | App info, version | ✅ Yes |

> **Note**: These 3 screens are the **bare minimum**. You are highly encouraged to add more screens, capabilities, and features that make the app feel exciting and highly functional. Do not restrict the app's architecture or flow to only these 3 pages.

### Settings Screen Must Include
- [ ] Theme toggle (Light/Dark/System)
- [ ] Clear App Data button
- [ ] Privacy Policy link
- [ ] Terms of Service link
- [ ] App version info
- [ ] Rate App / Feedback option

### About Screen Must Include
- [ ] App name and version
- [ ] Brief description
- [ ] Developer/company info
- [ ] Open source licenses (if applicable)

### Rules
- ❌ **DO NOT** build one-page apps
- ❌ **DO NOT** submit apps that look like demos
- ✅ Make it look like a complete, professional product
- ✅ Add polish (animations, transitions, loading states)
- ✅ Add delightful small features (micro-interactions, haptic feedback, extra utilities) that make the app feel exciting
- ✅ Build additional screens as needed; do not restrict yourself to only the minimum required screens
- ✅ Include proper error handling and empty states

---

## 5. Privacy & Data Collection

### Rules for Fast Approval

- ✅ **NO user accounts** - No login, no signup
- ✅ **NO cloud storage** - Everything local with Hive
- ✅ **NO analytics tracking** - No Firebase Analytics, etc.
- ✅ **NO personal data collection** - No emails, names, etc.
- ✅ **Privacy Policy must state**: "We do not collect any personal data"

### Privacy Declaration (Play Store)
When asked about data collection:
- No data collected
- No data shared
- No account required
- Local storage only

---

## 6. Dependency Management

### Adding Dependencies
```bash
# ✅ ALWAYS use terminal command
flutter pub add package_name

# ❌ NEVER edit pubspec.yaml directly
```

### Recommended Packages
| Purpose | Package |
|---------|---------|
| State Management | `provider` |
| Local Storage | `hive_flutter` |
| Navigation | Built-in Navigator 2.0 or simple 1.0 |
| JSON | `dart:convert` (built-in) |
| Icons | `flutter_launcher_icons` |
| Splash | `flutter_native_splash` |
| Fonts | `google_fonts` |

### Packages to Avoid
| Package | Reason |
|---------|--------|
| `firebase_*` | Adds complexity, tracking |
| `shared_preferences` | Use Hive instead |
| `bloc` / `riverpod` | Overkill for utility apps |
| `get_it` / `injectable` | Over-engineering |

---

## 7. Code Style Guidelines

### Naming Conventions
```dart
// Files: snake_case
home_screen.dart
home_view_model.dart

// Classes: PascalCase
class HomeScreen extends StatelessWidget {}
class HomeViewModel extends ChangeNotifier {}

// Variables/methods: camelCase
final isLoading = false;
void performAction() {}
```

### Widget Structure
```dart
class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature'),
      ),
      body: Consumer<FeatureViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return _buildContent(context, viewModel, colorScheme);
        },
      ),
    );
  }
  
  Widget _buildContent(
    BuildContext context, 
    FeatureViewModel viewModel,
    ColorScheme colorScheme,
  ) {
    // Widget content
  }
}
```

---

## 8. Quick Reference Checklist

### Before Starting a New App
- [ ] Set up feature-first folder structure
- [ ] Create `core/theme/app_theme.dart` with colors
- [ ] Initialize Hive in `main.dart`
- [ ] Plan all 3 required base screens (Home, Settings, About)

### Before Submitting to Play Store
- [ ] All screens implemented and polished
- [ ] Theme works in both Light and Dark modes
- [ ] App Core functionality works
- [ ] Settings has all required links
- [ ] No hardcoded colors in code
- [ ] Privacy policy states "No data collected"
- [ ] App icon and splash screen configured
- [ ] Version bumped in pubspec.yaml

---

## 9. Summary

| Aspect | Requirement |
|--------|-------------|
| Architecture | Feature-First + Minimal MVVM |
| Colors | Theme.of(context).colorScheme ONLY |
| Storage | Hive Box (no adapters) |
| Auth | None - No login required |
| Data Collection | None - Privacy first |
| Screens | Minimum 3 (Home, Settings, About) |
| Quality | Professional, polished, complete |

---

*Last Updated: February 2026*