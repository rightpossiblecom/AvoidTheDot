import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/services/hive_boxes.dart';
import 'core/services/stats_service.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';
import 'features/home/home_view_model.dart';
import 'features/settings/settings_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('[AvoidTheDot] main: binding initialized');

  await Hive.initFlutter();
  final appDataBox = await Hive.openBox<String>(HiveBoxes.appData);
  final settingsBox = await Hive.openBox<String>(HiveBoxes.settings);
  debugPrint('[AvoidTheDot] main: Hive boxes opened');

  final statsService = StatsService(appDataBox);
  final settingsViewModel = SettingsViewModel(settingsBox, appDataBox);
  await settingsViewModel.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<StatsService>.value(value: statsService),
        ChangeNotifierProvider<SettingsViewModel>.value(value: settingsViewModel),
        ChangeNotifierProvider<HomeViewModel>(
          create: (ctx) => HomeViewModel(ctx.read<StatsService>()),
        ),
      ],
      child: const AvoidTheDotApp(),
    ),
  );
  debugPrint('[AvoidTheDot] main: runApp scheduled');
}

class AvoidTheDotApp extends StatelessWidget {
  const AvoidTheDotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, settings, _) {
        debugPrint('[AvoidTheDot] AvoidTheDotApp: build theme=${settings.themeMode}');
        return MaterialApp(
          title: 'AvoidTheDot',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.themeMode,
          home: const HomeScreen(),
        );
      },
    );
  }
}
