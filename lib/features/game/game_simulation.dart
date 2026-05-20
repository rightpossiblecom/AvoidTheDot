import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/game_constants.dart';

/// Pure simulation state updated on each tick (no Flutter bindings).
class GameSimulation {
  GameSimulation();

  final math.Random _random = math.Random();

  bool isGameOver = false;
  double elapsedSec = 0;

  Offset playerPos = Offset.zero;
  Offset enemyPos = Offset.zero;
  Offset enemyVel = Offset.zero;

  int nearMissCount = 0;
  int currentNearMissStreak = 0;
  int bestNearMissStreakThisRun = 0;
  double nearMissCooldownSec = 0;

  /// Latest near-miss for a short UI pulse (seconds remaining).
  double nearMissPulseSec = 0;

  double _currentSpeed = GameConstants.baseEnemySpeed;
  bool _wasInNearMissBand = false;

  Rect _bounds = Rect.zero;

  void reset(Size playfieldSize) {
    isGameOver = false;
    elapsedSec = 0;
    nearMissCount = 0;
    currentNearMissStreak = 0;
    bestNearMissStreakThisRun = 0;
    nearMissCooldownSec = 0;
    nearMissPulseSec = 0;
    _currentSpeed = GameConstants.baseEnemySpeed;
    _wasInNearMissBand = false;

    _bounds = _computeBounds(playfieldSize);

    final cx = _bounds.center.dx;
    final cy = _bounds.center.dy;
    playerPos = Offset(cx, cy);

    final angle = _random.nextDouble() * math.pi * 2;
    enemyVel = Offset(math.cos(angle), math.sin(angle)) * _currentSpeed;

    final minDistance = GameConstants.minSpawnSeparationPx;
    Offset spawn = playerPos;
    for (var i = 0; i < 12; i += 1) {
      final candidate = Offset(
        _bounds.left + _random.nextDouble() * _bounds.width,
        _bounds.top + _random.nextDouble() * _bounds.height,
      );
      if ((candidate - playerPos).distance >= minDistance) {
        spawn = candidate;
        break;
      }
    }

    if ((spawn - playerPos).distance < minDistance) {
      spawn = _clampEnemy(playerPos + Offset(minDistance, 0));
    }

    enemyPos = _clampEnemy(spawn);
  }

  Rect _computeBounds(Size playfieldSize) {
    final p = GameConstants.playfieldPadding;
    final er = GameConstants.enemyRadiusPx;
    return Rect.fromLTRB(
      p + er,
      p + er,
      playfieldSize.width - p - er,
      playfieldSize.height - p - er,
    );
  }

  Offset _clampPlayer(Offset o) {
    final r = GameConstants.playerRadiusPx;
    return Offset(
      o.dx.clamp(_bounds.left + r, _bounds.right - r),
      o.dy.clamp(_bounds.top + r, _bounds.bottom - r),
    );
  }

  Offset _clampEnemy(Offset o) {
    return Offset(
      o.dx.clamp(_bounds.left, _bounds.right),
      o.dy.clamp(_bounds.top, _bounds.bottom),
    );
  }

  void update(double dt, Offset? pointerLocal, Size playfieldSize) {
    if (isGameOver) return;

    _bounds = _computeBounds(playfieldSize);

    if (nearMissPulseSec > 0) {
      nearMissPulseSec = (nearMissPulseSec - dt).clamp(0, 1);
    }

    if (pointerLocal != null) {
      playerPos = _clampPlayer(pointerLocal);
    }

    elapsedSec += dt;

    _currentSpeed =
        (GameConstants.baseEnemySpeed +
                elapsedSec * GameConstants.speedRampPerSecond)
            .clamp(0.0, GameConstants.maxEnemySpeed);

    if (enemyVel.distance > 0) {
      final dir = enemyVel / enemyVel.distance;
      enemyVel = dir * _currentSpeed;
    }

    enemyPos += enemyVel * dt;

    if (enemyPos.dx <= _bounds.left && enemyVel.dx < 0) {
      enemyVel = Offset(enemyVel.dx.abs(), enemyVel.dy);
    } else if (enemyPos.dx >= _bounds.right && enemyVel.dx > 0) {
      enemyVel = Offset(-enemyVel.dx.abs(), enemyVel.dy);
    }
    if (enemyPos.dy <= _bounds.top && enemyVel.dy < 0) {
      enemyVel = Offset(enemyVel.dx, enemyVel.dy.abs());
    } else if (enemyPos.dy >= _bounds.bottom && enemyVel.dy > 0) {
      enemyVel = Offset(enemyVel.dx, -enemyVel.dy.abs());
    }
    enemyPos = _clampEnemy(enemyPos);

    final touch = GameConstants.playerRadiusPx + GameConstants.enemyRadiusPx;
    final d = (playerPos - enemyPos).distance;

    if (d < touch) {
      isGameOver = true;
      return;
    }

    if (nearMissCooldownSec > 0) {
      nearMissCooldownSec -= dt;
    }

    final nearThreshold = touch + GameConstants.nearMissExtraPx;
    final inBand = d >= touch && d <= nearThreshold;

    if (inBand && !_wasInNearMissBand && nearMissCooldownSec <= 0) {
      nearMissCount += 1;
      currentNearMissStreak += 1;
      if (currentNearMissStreak > bestNearMissStreakThisRun) {
        bestNearMissStreakThisRun = currentNearMissStreak;
      }
      nearMissCooldownSec = GameConstants.nearMissCooldownSec;
      nearMissPulseSec = 0.22;
    }
    if (!inBand && d > nearThreshold + 8) {
      currentNearMissStreak = 0;
    }

    _wasInNearMissBand = inBand;
  }
}
