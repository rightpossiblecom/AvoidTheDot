# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

-keepattributes Signature
-keepattributes *Annotation*

# Hive
-keep class hive.** { *; }
-keep class ** extends hive.TypeAdapter { *; }

# Play Core — referenced by Flutter embedding (deferred components / split).
# R8 otherwise strips these classes because app code never touches them directly.
-keep class com.google.android.play.core.** { *; }
-keep interface com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**
