import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive_boxes.dart';

/// Persists run stats as JSON in a Hive [String] box (no adapters).
class StatsService extends ChangeNotifier {
  StatsService(this._box) {
    _load();
  }

  final Box<String> _box;

  double bestSurvivalSeconds = 0;
  int longestNearMissStreak = 0;
  int bestNearMissCountSingleRun = 0;
  int totalRuns = 0;

  void _load() {
    final raw = _box.get(HiveKeys.stats);
    if (raw == null || raw.isEmpty) {
      debugPrint('[AvoidTheDot] StatsService: no saved stats, using defaults');
      return;
    }
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      bestSurvivalSeconds =
          (map['bestSurvivalSeconds'] as num?)?.toDouble() ?? 0;
      longestNearMissStreak = (map['longestNearMissStreak'] as num?)?.toInt() ?? 0;
      bestNearMissCountSingleRun =
          (map['bestNearMissCountSingleRun'] as num?)?.toInt() ?? 0;
      totalRuns = (map['totalRuns'] as num?)?.toInt() ?? 0;
      debugPrint('[AvoidTheDot] StatsService: loaded best=${bestSurvivalSeconds}s runs=$totalRuns');
    } catch (e) {
      debugPrint('[AvoidTheDot] StatsService: corrupt stats, resetting ($e)');
    }
  }

  Future<void> recordRun({
    required double survivalSeconds,
    required int nearMissCount,
    required int nearMissStreak,
  }) async {
    totalRuns += 1;
    if (survivalSeconds > bestSurvivalSeconds) {
      bestSurvivalSeconds = survivalSeconds;
    }
    if (nearMissStreak > longestNearMissStreak) {
      longestNearMissStreak = nearMissStreak;
    }
    if (nearMissCount > bestNearMissCountSingleRun) {
      bestNearMissCountSingleRun = nearMissCount;
    }

    final payload = jsonEncode({
      'bestSurvivalSeconds': bestSurvivalSeconds,
      'longestNearMissStreak': longestNearMissStreak,
      'bestNearMissCountSingleRun': bestNearMissCountSingleRun,
      'totalRuns': totalRuns,
    });
    await _box.put(HiveKeys.stats, payload);
    debugPrint(
      '[AvoidTheDot] StatsService: saved run time=${survivalSeconds.toStringAsFixed(2)}s '
      'nearMiss=$nearMissCount streak=$nearMissStreak',
    );
    notifyListeners();
  }

  Future<void> clear() async {
    await _box.clear();
    bestSurvivalSeconds = 0;
    longestNearMissStreak = 0;
    bestNearMissCountSingleRun = 0;
    totalRuns = 0;
    debugPrint('[AvoidTheDot] StatsService: cleared');
    notifyListeners();
  }
}
