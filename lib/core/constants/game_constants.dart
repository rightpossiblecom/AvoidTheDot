/// Tunable gameplay values (logical pixels / seconds).
class GameConstants {
  GameConstants._();

  static const double playfieldPadding = 20;
  static const double playerRadiusPx = 18;
  static const double enemyRadiusPx = 15;

  static const double baseEnemySpeed = 130;
  static const double speedRampPerSecond = 10;
  static const double maxEnemySpeed = 400;

  /// Extra gap beyond touch distance to count a near miss.
  static const double nearMissExtraPx = 32;

  static const double nearMissCooldownSec = 0.4;

  /// Minimum distance between player and enemy at spawn.
  static const double minSpawnSeparationPx = 90;

  /// Cap per-frame dt to avoid huge jumps after backgrounding.
  static const double maxDeltaSec = 1 / 30;
}
