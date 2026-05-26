# AvoidTheDot — Release package

## Play Console identity

- **Package name (Android applicationId):** `com.avoidthedot.game`
- **Do not use:** `com.avoidthedot.app` (locked to a verification key we do not own)

When registering the package under **Android developer verification**, add **only** the SHA-256 fingerprint below. Do not pick a key from Google’s suggested list.

## Signing (Google Play)

- **Keystore file:** `avoidthedot-release.jks`
  - Primary: `android/app/avoidthedot-release.jks`
  - Backup: `docs/release/avoidthedot-release.jks`
- **Gradle config:** `android/key.properties` (backup copy: `docs/release/key.properties`)

Credentials:

| Field | Value |
| --- | --- |
| Alias | `avoidthedot` |
| Store password | `avoidthedot123` |
| Key password | `avoidthedot123` |
| Store file | `avoidthedot-release.jks` (relative to `android/app/` in Gradle) |

Certificate fingerprints (for Play verification / Firebase):

| Algorithm | Fingerprint |
| --- | --- |
| SHA-1 | `F0:F8:0B:4C:69:08:A4:F1:AC:44:30:6D:DB:E9:9D:EE:F2:E5:E6:64` |
| SHA-256 | `CC:7A:FD:9F:43:1D:E1:6E:AC:89:97:F3:5A:85:06:E0:EF:3B:1B:15:6B:8C:06:11:91:24:B7:51:93:CE:AE:AB` |

- **Upload certificate (PEM):** `docs/release/upload_certificate.pem` — for Play upload-key reset requests only; not needed for normal releases.

If you lose the keystore file, you cannot publish updates under the same Play app. Keep this folder with your source backup.

## Build & upload

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

Latest checked-in copy: `docs/release/app-release.aab` (replace after each release build).

Upload to **Internal testing** (or your chosen track) in Play Console. App signing preference: **Let Google manage and protect your app signing key (recommended)**.

## Store listing

Plain-text copy for Google Play: `play_store_listing.txt`

## Privacy policy

Source: `privacy_policy.md` — host at the URL in `lib/core/constants/app_links.dart` and in Play Console.

## Feature graphic

Play listing asset: `featured_graphic_avoidthedot.png` (1024 × 500)

Suggested Play category: Games → Arcade or Casual
