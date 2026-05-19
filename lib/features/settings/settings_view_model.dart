import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/services/hive_boxes.dart';
import '../../core/services/stats_service.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(this._settingsBox, this._appDataBox);

  final Box<String> _settingsBox;
  final Box<String> _appDataBox;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool _hapticsEnabled = true;
  bool get hapticsEnabled => _hapticsEnabled;

  Future<void> load() async {
    final themeRaw = _settingsBox.get(HiveKeys.themeMode);
    switch (themeRaw) {
      case 'light':
        _themeMode = ThemeMode.light;
      case 'dark':
        _themeMode = ThemeMode.dark;
      default:
        _themeMode = ThemeMode.system;
    }

    final hap = _settingsBox.get(HiveKeys.hapticsEnabled);
    if (hap == '0') {
      _hapticsEnabled = false;
    } else {
      _hapticsEnabled = true;
    }

    debugPrint(
      '[AvoidTheDot] SettingsViewModel: loaded theme=$themeRaw haptics=$_hapticsEnabled',
    );
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final stored = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _settingsBox.put(HiveKeys.themeMode, stored);
    debugPrint('[AvoidTheDot] SettingsViewModel: theme set to $stored');
    notifyListeners();
  }

  Future<void> setHapticsEnabled(bool value) async {
    _hapticsEnabled = value;
    await _settingsBox.put(HiveKeys.hapticsEnabled, value ? '1' : '0');
    debugPrint('[AvoidTheDot] SettingsViewModel: haptics=$value');
    notifyListeners();
  }

  /// Clears saved stats and preferences (fresh install feel).
  Future<void> clearAllUserData(StatsService stats) async {
    await stats.clear();
    await _settingsBox.clear();
    await _appDataBox.clear();
    _themeMode = ThemeMode.system;
    _hapticsEnabled = true;
    debugPrint('[AvoidTheDot] SettingsViewModel: all user data cleared');
    notifyListeners();
  }
}
