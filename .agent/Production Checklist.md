# Flutter App Production Checklist

> **Purpose**: Step-by-step guide for preparing Flutter apps for Google Play Store release.  
> **Note**: This is a TEMPLATE. Create a copy when working on a specific app.

---

 do not use placeholders in NY PLace, after you are done this is going directly to appstore, be professional

 WE DONT CARE ABOUR SECURIY HERE WE PUSH ALL INFO TO GITHUB, THE APP US CHILD PLAY

## Pre-Release Information

Before starting, gather the following:

| Field | Value |
|-------|-------|
| App Name | [YOUR_APP_NAME] |
| Package Name | `com.[appname].app` |
| Primary Color | [HEX_COLOR] |
> **IMPORTANT**: For this project, we are HARDCODING the API Key and Model ID in `lib/core/services/ai_service.dart`. Do NOT use `.env` files for production to avoid build issues. Ensure your repository is private if you do this.

---

## Phase 1: Branding & Visuals

> **CRITICAL**: All logo files must be named exactly `app_logo` (without spaces or special characters). This ensures consistency across the Flutter app assets and landing page public directory.

### 1.1 App Icon
- [ ] we already have an app logo check if there is an app logo in the assets folder and the public with the name app_logo, if not Create app icon and name it exactly `app_logo` (no spaces or special characters)
- [ ] Save to Flutter app assets: `assets/app_logo.png`
- [ ] Copy to landing page public directory: `landing_page/public/app_logo.png`
- [ ] Confirm the logo exists in both locations before proceeding
- [ ] Configure `flutter_launcher_icons` in pubspec.yaml:
  ```yaml
  flutter_launcher_icons:
    android: true
    ios: true
    image_path: "assets/app_logo.png"
    adaptive_icon_background: "#0A192F"  # Your dark background
    adaptive_icon_foreground: "assets/app_logo.png"
  ```
- [ ] Run: `flutter pub run flutter_launcher_icons`

### 1.2 Splash Screen
- [ ] Ensure `app_logo.png` is available in `assets/` directory
- [ ] Configure `flutter_native_splash` in pubspec.yaml:
  ```yaml
  flutter_native_splash:
    color: "#0A192F"  # Match your theme background
    image: "assets/app_logo.png"
    android_12:
      color: "#0A192F"
      image: "assets/app_logo.png"
  ```
- [ ] Run: `flutter pub run flutter_native_splash:create`

### 1.3 App Name
- [ ] Update `android/app/src/main/AndroidManifest.xml`:
  ```xml
  <application android:label="[APP_NAME]" ...>
  ```
### 1.4 Package Name / Bundle ID
- [ ] Verify `applicationId` in `android/app/build.gradle.kts`:
  ```kotlin
  namespace = "com.[appname].app"
  applicationId = "com.[appname].app"
  ```
- [ ] **CRITICAL**: Update `MainActivity.kt` package declaration:
  - File: `android/app/src/main/kotlin/com/[appname]/app/MainActivity.kt`
  - Content: `package com.[appname].app`
  - Action: Move file to new directory structure if needed (`com/example` -> `com/[appname]/app`).
- [ ] Update `ios/Runner.xcodeproj/project.pbxproj`:
  - Search for `PRODUCT_BUNDLE_IDENTIFIER` and replace all `com.example.[appname]` with `com.[appname].app`.
do not forget to create the file for the app name eg(this is only an example android\app\src\main\kotlin\com\tinyhabits\app\MainActivity.kt) so the app wont crash
---

## Phase 2: Android Release Signing

### 2.1 Generate Keystore

**Windows (PowerShell):**
```powershell
& "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -genkey -v -keystore "docs/release/[appname]-release.jks" -keyalg RSA -keysize 2048 -validity 10000 -alias [appname] -storepass [appname]123 -keypass [appname]123 -dname "CN=[AppName], OU=[AppName], O=[AppName], L=City, ST=State, C=US"
```

**macOS/Linux:**
```bash
keytool -genkey -v -keystore docs/release/[appname]-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias [appname] \
  -storepass [appname]123 \
  -keypass [appname]123 \
  -dname "CN=[AppName], OU=[AppName], O=[AppName], L=City, ST=State, C=US"
```

### 2.2 Create key.properties ( do not use placeholders, after you are done this is going directly to appstore, be professional)
- [ ] Create `android/key.properties`:
  ```properties
  storePassword=[appname]123
  keyPassword=[appname]123
  keyAlias=[appname]
  storeFile=[appname]-release.jks
  ```
- [ ] Ensure `key.properties` is in `.gitignore` (if public repo)

### 2.3 Copy Keystore to Android Folder
```bash
cp docs/release/[appname]-release.jks android/app/[appname]-release.jks
```

### 2.4 Configure build.gradle.kts
- [ ] Update `android/app/build.gradle.kts` with signing config:
  ```kotlin
  import java.util.Properties
  import java.io.FileInputStream

  val keystorePropertiesFile = rootProject.file("key.properties")
  val keystoreProperties = Properties()
  if (keystorePropertiesFile.exists()) {
      keystoreProperties.load(FileInputStream(keystorePropertiesFile))
  }

  android {
      signingConfigs {
          create("release") {
              keyAlias = keystoreProperties["keyAlias"] as String?
              keyPassword = keystoreProperties["keyPassword"] as String?
              storeFile = keystoreProperties["storeFile"]?.let { file(it) }
              storePassword = keystoreProperties["storePassword"] as String?
          }
      }
      buildTypes {
          release {
              signingConfig = signingConfigs.getByName("release")
              isMinifyEnabled = true
              isShrinkResources = true
          }
      }
  }
  ```

### 2.5 Backup Keystore
- [ ] Copy keystore to `docs/release/[appname]-release.jks`
- [ ] Create `docs/release/key.properties` (backup copy with passwords)
- [ ] Update `docs/release/README.md` with credentials

**⚠️ CRITICAL: Back up your keystore! Losing it means you can't update the app!**

---

## Phase 3: Permissions Audit

### 3.1 Android Permissions
- [ ] Review `android/app/src/main/AndroidManifest.xml`
- [ ] Remove unnecessary permissions
- [ ] Required for most AI apps:
  ```xml
  <uses-permission android:name="android.permission.INTERNET"/>
  ```
---

## Phase 4: Version & Build Number

### 4.1 Update pubspec.yaml
- [ ] Increment version before each release:
  ```yaml
  version: 1.0.0+1  # version+buildNumber
  ```
- [ ] Convention:
  - Major.Minor.Patch + BuildNumber
  - Example: `1.0.0+1`, `1.0.1+2`, `1.1.0+3`

---

## Phase 5: App Store Metadata

### 5.1 Play Store Listing
- [ ] Short description (max 80 chars)
- [ ] Full description (max 4000 chars) (do not use markdown systax, just plan text
- [ ] Create `docs/release/play_store_listing.txt`

### 5.3 Feature Graphic
- [ ] Create 1024x500 feature graphic
- [ ] Save to `docs/release/featured_graphic_[appname].png`

### 5.4 Privacy Policy
- [ ] Create privacy policy content in `docs/release/privacy_policy.md`
- [ ] Host at `https://[appname].app/privacy-policy`

### 5.5 Category & Rating
- [ ] Select appropriate Play Store category
- [ ] Complete content rating questionnaire

---

## Phase 6: Technical Verification

### 6.1 Build Test
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build appbundle --release
```

### 6.2 Release Build Verification
- [ ] Test release APK on real device
- [ ] Verify no debug banners
- [ ] Test all features
- [ ] Test network error handling
- [ ] Test offline behavior

### 6.3 ProGuard/R8 Testing
- [ ] Verify code shrinking doesn't break functionality
- [ ] Check JSON serialization still works
- [ ] Check Hive storage still works

---

## Phase 7: Deployment

### 7.1 Build App Bundle
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

- [ ] After successful build, copy AAB to release directory:
  ```bash
  cp build/app/outputs/bundle/release/app-release.aab docs/release/app-release.aab
  ```
- [ ] Verify the file exists: `docs/release/app-release.aab`

### 7.2 Play Console Upload
1. Go to Google Play Console
2. Create new app (or select existing)
3. Complete store listing
4. Upload AAB to Internal Testing track
5. Complete content declarations
6. Complete pricing & distribution

### 7.4 Production Release
- [ ] Review all store listing information
- [ ] Submit for review
- [ ] Respond to any review feedback
- [ ] Monitor initial user feedback

---

## Phase 8: Client Handoff (If Selling)

### 8.1 Prepare Release Bundle
```bash
cd docs
zip -r -e [appname]-release-credentials.zip release/
```

### 8.2 Include in Package
- [ ] Full source code
- [ ] `docs/release/` folder with:
  - Keystore file
  - key.properties with passwords
  - README with setup instructions
  - Play Store listing copy
  - Privacy policy
  - Feature graphic
  - JSK FILE (MUST NOT BE GIT IGNORED)
- [ ] `assets/app_logo.png`
- [ ] Any additional documentation
- [ ] Any additional documentation




---

## Quick Reference: Files to Update

| Priority | File | What to Update |
|----------|------|----------------|
| 🔴 High | `assets/app_logo.png` | App icon source (Flutter app) |
| 🔴 High | `landing_page/public/app_logo.png` | App icon copy (landing page) |
| 🔴 High | `pubspec.yaml` | Version, name, dependencies |
| 🔴 High | `AndroidManifest.xml` | App label, permissions |
| 🔴 High | `build.gradle.kts` | Package ID, signing config |
| 🟡 Medium | `key.properties` | Signing credentials |
| 🟢 High | `docs/release/` | Store listing, privacy policy |

---

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Keystore not found | Copy to `android/app/` folder |
| Signing failed | Check key.properties paths and passwords |
| Build too large | Enable `isShrinkResources = true` |
| ProGuard breaking code | Add keep rules for problem classes |
| Wrong app name | Update AndroidManifest.xml |

---

*Last Updated: January 2026*

BIG NOTES
no file in the docs SHOULD be ignore by git, fuck security issues man, 
no file in the docs SHOULD be ignore by git, fuck security issues man, 
no file in the docs SHOULD be ignore by git, fuck security issues man, 
no file in the docs SHOULD be ignore by git, fuck security issues man, 
no file in the docs SHOULD be ignore by git, fuck security issues man, 
no file in the docs SHOULD be ignore by git, fuck security issues man, 
no file in the docs SHOULD be ignore by git, fuck security issues man, 
no file in the docs SHOULD be ignore by git, fuck security issues man, 