import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/constants/game_constants.dart';
import '../../core/services/stats_service.dart';
import '../home/home_view_model.dart';
import '../settings/settings_view_model.dart';
import 'game_simulation.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final GameSimulation _sim = GameSimulation();

  late final Ticker _ticker;
  Duration? _lastTick;
  Offset? _pointer;
  Size _fieldSize = Size.zero;
  bool _started = false;
  bool _handledGameOver = false;
  SettingsViewModel? _settingsVm;
  double _prevNearPulse = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('[AvoidTheDot] GameScreen: init');
    _ticker = createTicker(_onTick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _settingsVm ??= context.read<SettingsViewModel>();
  }

  void _onTick(Duration elapsed) {
    if (!mounted || _handledGameOver) return;

    final last = _lastTick ?? elapsed;
    var dt = (elapsed - last).inMicroseconds / 1e6;
    _lastTick = elapsed;
    if (dt <= 0) return;
    if (dt > GameConstants.maxDeltaSec) {
      dt = GameConstants.maxDeltaSec;
    }

    final wasOver = _sim.isGameOver;
    setState(() {
      _sim.update(dt, _pointer, _fieldSize);
    });

    final pulse = _sim.nearMissPulseSec;
    final sm = _settingsVm;
    if (sm != null && pulse > 0 && _prevNearPulse <= 0 && sm.hapticsEnabled) {
      HapticFeedback.selectionClick();
    }
    _prevNearPulse = pulse;

    if (!wasOver && _sim.isGameOver) {
      _handledGameOver = true;
      _ticker.stop();
      _openGameOverDialog();
    }
  }

  void _openGameOverDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final settings = context.read<SettingsViewModel>();
      final stats = context.read<StatsService>();
      final prevBest = stats.bestSurvivalSeconds;
      final time = _sim.elapsedSec;
      final newBest = time > prevBest;

      if (settings.hapticsEnabled) {
        await HapticFeedback.heavyImpact();
      }
      if (!mounted) return;

      await stats.recordRun(
        survivalSeconds: time,
        nearMissCount: _sim.nearMissCount,
        nearMissStreak: _sim.bestNearMissStreakThisRun,
      );

      if (!mounted) return;

      final colorScheme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: colorScheme.surfaceContainerHigh,
            title: Text(
              newBest ? 'New personal best' : 'Run over',
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You lasted ${HomeViewModel.formatSeconds(time)}.',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Close calls this run: ${_sim.nearMissCount}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Best streak this run: ${_sim.bestNearMissStreakThisRun}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                if (!newBest && prevBest > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Your record: ${HomeViewModel.formatSeconds(prevBest)}.',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                  debugPrint('[AvoidTheDot] GameScreen: exit to home');
                },
                child: Text(
                  'Home',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _restartMatch();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
                child: const Text('Play again'),
              ),
            ],
          );
        },
      );
    });
  }

  void _restartMatch() {
    debugPrint('[AvoidTheDot] GameScreen: restart match');
    setState(() {
      _handledGameOver = false;
      _lastTick = null;
      _pointer = null;
      _prevNearPulse = 0;
      _sim.reset(_fieldSize);
      _ticker.start();
    });
  }

  void _maybeStart(Size size) {
    if (_started) return;
    if (size.width < 48 || size.height < 48) return;
    _started = true;
    _fieldSize = size;
    _sim.reset(size);
    _lastTick = null;
    _ticker.start();
    debugPrint('[AvoidTheDot] GameScreen: tickers started field=$size');
  }

  @override
  void dispose() {
    _ticker.dispose();
    debugPrint('[AvoidTheDot] GameScreen: dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: colorScheme.onSurface),
          onPressed: () {
            debugPrint('[AvoidTheDot] GameScreen: user quit');
            _ticker.stop();
            Navigator.of(context).maybePop();
          },
        ),
        title: Text(
          'Survive',
          style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _maybeStart(size);
          });

          return Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (e) {
              _pointer = e.localPosition;
            },
            onPointerMove: (e) {
              _pointer = e.localPosition;
            },
            onPointerUp: (_) {
              _pointer = null;
            },
            onPointerCancel: (_) {
              _pointer = null;
            },
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/unsplash/game_bg_01.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                RepaintBoundary(
                  child: CustomPaint(
                    size: size,
                    painter: _GamePainter(
                      simulation: _sim,
                      colorScheme: colorScheme,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 24,
                  right: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        HomeViewModel.formatSeconds(_sim.elapsedSec),
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      if (_sim.nearMissCount > 0)
                        Text(
                          'Close calls: ${_sim.nearMissCount}',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GamePainter extends CustomPainter {
  _GamePainter({required this.simulation, required this.colorScheme});

  final GameSimulation simulation;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = colorScheme.surface.withValues(alpha: 0.7);
    canvas.drawRect(Offset.zero & size, bg);

    final inset = GameConstants.playfieldPadding;
    final fieldRect = Rect.fromLTWH(
      inset,
      inset,
      size.width - inset * 2,
      size.height - inset * 2,
    );

    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = colorScheme.outlineVariant;

    final rOuter = RRect.fromRectAndRadius(
      fieldRect,
      const Radius.circular(20),
    );
    canvas.drawRRect(rOuter, border);

    if (simulation.nearMissPulseSec > 0) {
      final pulse = simulation.nearMissPulseSec / 0.22;
      final glow = Paint()
        ..color = colorScheme.secondary.withValues(alpha: 0.18 * pulse)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24);
      canvas.drawCircle(
        simulation.enemyPos,
        GameConstants.enemyRadiusPx + 14,
        glow,
      );
    }

    final enemyPaint = Paint()
      ..color = colorScheme.primary
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(
      simulation.enemyPos,
      GameConstants.enemyRadiusPx,
      enemyPaint,
    );

    final enemyCore = Paint()..color = colorScheme.primary;
    canvas.drawCircle(
      simulation.enemyPos,
      GameConstants.enemyRadiusPx * 0.72,
      enemyCore,
    );

    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = colorScheme.tertiary;
    canvas.drawCircle(simulation.playerPos, GameConstants.playerRadiusPx, ring);

    final fill = Paint()..color = colorScheme.tertiary.withValues(alpha: 0.14);
    canvas.drawCircle(
      simulation.playerPos,
      GameConstants.playerRadiusPx * 0.78,
      fill,
    );
  }

  @override
  bool shouldRepaint(covariant _GamePainter oldDelegate) => true;
}
