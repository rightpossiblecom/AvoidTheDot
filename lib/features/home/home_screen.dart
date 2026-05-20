import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/game_constants.dart';
import '../game/game_screen.dart';
import '../settings/settings_screen.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _preview;

  @override
  void initState() {
    super.initState();
    _preview = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    debugPrint('[AvoidTheDot] HomeScreen: open');
  }

  @override
  void dispose() {
    _preview.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AvoidTheDot',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: colorScheme.onSurface),
            onPressed: () {
              debugPrint('[AvoidTheDot] HomeScreen: navigate settings');
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/unsplash/hero_01.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: colorScheme.surface.withValues(alpha: 0.86),
            ),
          ),
          SafeArea(
            child: Consumer<HomeViewModel>(
              builder: (context, home, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      Center(
                        child: Image.asset(
                          'assets/app_logo.png',
                          width: 88,
                          height: 88,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Stay ahead of the dot.',
                        textAlign: TextAlign.center,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'One bouncing threat. Move smoothly. Survive as long as you can.',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 28),
                      _PreviewOrbit(
                        controller: _preview,
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your best',
                                style: textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _StatRow(
                                label: 'Longest survival',
                                value: home.bestTimeLabel,
                                colorScheme: colorScheme,
                                textTheme: textTheme,
                              ),
                              _StatRow(
                                label: 'Best close-call streak',
                                value: home.longestNearMissStreak > 0
                                    ? '${home.longestNearMissStreak}'
                                    : '—',
                                colorScheme: colorScheme,
                                textTheme: textTheme,
                              ),
                              _StatRow(
                                label: 'Most close calls (one run)',
                                value: home.bestNearMissCount > 0
                                    ? '${home.bestNearMissCount}'
                                    : '—',
                                colorScheme: colorScheme,
                                textTheme: textTheme,
                              ),
                              if (home.totalRuns > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Runs played: ${home.totalRuns}',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: () {
                          debugPrint('[AvoidTheDot] HomeScreen: start game');
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const GameScreen(),
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                        ),
                        child: const Text('Survive'),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.colorScheme,
    required this.textTheme,
  });

  final String label;
  final String value;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewOrbit extends StatelessWidget {
  const _PreviewOrbit({required this.controller, required this.colorScheme});

  final AnimationController controller;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final t = controller.value * math.pi * 2;
        final cx = 80 + math.cos(t) * 36;
        final cy = 44 + math.sin(t * 1.3) * 22;
        return SizedBox(
          height: 100,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Container(
                  width: 160,
                  height: 88,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: cx - GameConstants.enemyRadiusPx,
                        top: cy - GameConstants.enemyRadiusPx,
                        child: Container(
                          width: GameConstants.enemyRadiusPx * 2,
                          height: GameConstants.enemyRadiusPx * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.primary,
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withValues(
                                  alpha: 0.45,
                                ),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 80 - GameConstants.playerRadiusPx,
                        top: 44 - GameConstants.playerRadiusPx,
                        child: Container(
                          width: GameConstants.playerRadiusPx * 2,
                          height: GameConstants.playerRadiusPx * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.tertiary,
                              width: 2,
                            ),
                            color: colorScheme.tertiary.withValues(alpha: 0.15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
