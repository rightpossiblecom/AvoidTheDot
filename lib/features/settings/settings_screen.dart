import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_links.dart';
import '../../core/services/stats_service.dart';
import '../about/about_screen.dart';
import 'settings_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    debugPrint('[AvoidTheDot] SettingsScreen: open');
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() => _packageInfo = info);
      debugPrint(
        '[AvoidTheDot] SettingsScreen: package ${info.appName} v${info.version}',
      );
    }
  }

  Future<void> _launch(Uri uri, {LaunchMode mode = LaunchMode.externalApplication}) async {
    debugPrint('[AvoidTheDot] SettingsScreen: launch $uri');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode);
    }
  }

  Future<void> _confirmClearData(
    BuildContext context,
    SettingsViewModel settings,
    StatsService stats,
  ) async {
    final colorScheme = Theme.of(context).colorScheme;
    final proceed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: colorScheme.surfaceContainerHigh,
            title: Text(
              'Erase saved data?',
              style: TextStyle(color: colorScheme.onSurface),
            ),
            content: Text(
              'This removes your stats and preferences on this device.',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text('Cancel', style: TextStyle(color: colorScheme.primary)),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                ),
                child: const Text('Erase'),
              ),
            ],
          ),
        ) ??
        false;

    if (!proceed || !context.mounted) return;

    await settings.clearAllUserData(stats);
    debugPrint('[AvoidTheDot] SettingsScreen: clear data done');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Saved data was removed.',
            style: TextStyle(color: Theme.of(context).colorScheme.onInverseSurface),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
        ),
      ),
      body: Consumer<SettingsViewModel>(
        builder: (context, settings, _) {
          return ListView(
            children: [
              ListTile(
                title: Text(
                  'Appearance',
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: SegmentedButton<ThemeMode>(
                  segments: [
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.system,
                      label: Text(
                        'Device',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      icon: Icon(Icons.brightness_auto, color: colorScheme.onSurface),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.light,
                      label: Text(
                        'Light',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      icon: Icon(Icons.light_mode_outlined, color: colorScheme.onSurface),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.dark,
                      label: Text(
                        'Dark',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      icon: Icon(Icons.dark_mode_outlined, color: colorScheme.onSurface),
                    ),
                  ],
                  selected: {settings.themeMode},
                  onSelectionChanged: (set) {
                    if (set.isNotEmpty) {
                      settings.setThemeMode(set.first);
                    }
                  },
                ),
              ),
              const Divider(),
              SwitchListTile(
                title: Text(
                  'Vibration on game over',
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                ),
                subtitle: Text(
                  'Short buzz when your run ends',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                value: settings.hapticsEnabled,
                activeThumbColor: colorScheme.primary,
                onChanged: settings.setHapticsEnabled,
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'Privacy policy',
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                ),
                trailing: Icon(Icons.open_in_new, color: colorScheme.onSurfaceVariant),
                onTap: () => _launch(Uri.parse(AppLinks.privacyPolicy)),
              ),
              ListTile(
                title: Text(
                  'Terms of use',
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                ),
                trailing: Icon(Icons.open_in_new, color: colorScheme.onSurfaceVariant),
                onTap: () => _launch(Uri.parse(AppLinks.termsOfService)),
              ),
              ListTile(
                title: Text(
                  'About this app',
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                ),
                trailing: Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const AboutScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'Rate on Play Store',
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                ),
                trailing: Icon(Icons.star_outline, color: colorScheme.onSurfaceVariant),
                onTap: () => _launch(Uri.parse(AppLinks.playStoreListing)),
              ),
              ListTile(
                title: Text(
                  'Send feedback',
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                ),
                trailing: Icon(Icons.mail_outline, color: colorScheme.onSurfaceVariant),
                onTap: () => _launch(Uri.parse(AppLinks.feedbackEmail)),
              ),
              ListTile(
                title: Text(
                  'Erase all saved data',
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.error),
                ),
                onTap: () => _confirmClearData(
                  context,
                  settings,
                  context.read<StatsService>(),
                ),
              ),
              if (_packageInfo != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                  child: Text(
                    '${_packageInfo!.appName} · version ${_packageInfo!.version}+${_packageInfo!.buildNumber}',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
