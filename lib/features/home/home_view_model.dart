import 'package:flutter/foundation.dart';

import '../../core/services/stats_service.dart';

/// Exposes formatted stats for the home screen; rebroadcasts [StatsService] updates.
class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._stats) {
    _stats.addListener(_onStatsChanged);
  }

  final StatsService _stats;

  void _onStatsChanged() => notifyListeners();

  @override
  void dispose() {
    _stats.removeListener(_onStatsChanged);
    super.dispose();
  }

  double get bestSurvivalSeconds => _stats.bestSurvivalSeconds;

  int get longestNearMissStreak => _stats.longestNearMissStreak;

  int get bestNearMissCount => _stats.bestNearMissCountSingleRun;

  int get totalRuns => _stats.totalRuns;

  String get bestTimeLabel {
    final s = _stats.bestSurvivalSeconds;
    if (s <= 0) {
      return '—';
    }
    return _formatSeconds(s);
  }

  static String formatSeconds(double seconds) => _formatSeconds(seconds);

  static String _formatSeconds(double seconds) {
    final t = seconds.floor();
    final m = t ~/ 60;
    final r = t % 60;
    final frac = ((seconds - t) * 100).floor().clamp(0, 99);
    if (m > 0) {
      return '$m:${r.toString().padLeft(2, '0')}.${frac.toString().padLeft(2, '0')}';
    }
    return '$r.${frac.toString().padLeft(2, '0')}s';
  }
}
