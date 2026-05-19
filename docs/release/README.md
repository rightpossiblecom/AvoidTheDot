# AvoidTheDot — Release package

## Signing (Google Play)

- Keystore file: `avoidthedot-release.jks` (duplicate of `android/app/avoidthedot-release.jks`).
- Android Gradle reads credentials from `android/key.properties` at the project root of the `android/` module.
- Backup copy of the same properties: `docs/release/key.properties`.

Credentials (same as checklist convention):

- Alias: `avoidthedot`
- Store password: `avoidthedot123`
- Key password: `avoidthedot123`

If you lose the keystore file, you cannot publish updates under the same Play app signing identity. Keep this folder with your source backup.

## Store listing

Plain-text copy for Google Play is in `play_store_listing.txt`. Use it as the short and full description (trim or split as the console asks).

## Privacy policy

Source content for hosting: `privacy_policy.md`. Host at the URL you ship in the app (see `lib/core/constants/app_links.dart`) and in Play Console.

## Feature graphic

Play listng asset: `featured_graphic_avoidthedot.png` (1024 x 500).

## Release bundle

The latest Play upload artifact is checked in here as:

`docs/release/app-release.aab`

Rebuild with:

`flutter build appbundle --release`

Then replace this file from `build/app/outputs/bundle/release/app-release.aab` if you need a fresh binary.

Suggested Play category: Games, Arcade or Games, Casual.