# SmartSaving - Installation & Setup Guide

Complete guide to get SmartSaving running on your device in minutes.

## Prerequisites

### System Requirements

- Windows 10+ / macOS 10.15+ / Linux (Ubuntu 18.04+)
- Internet connection for package downloads
- 2GB+ free disk space

### Software Requirements

- **Flutter SDK** 3.10 or higher
- **Dart** 3.10 or higher (included with Flutter)
- **Android SDK** API 21+ (for Android development)
- **Xcode** 12+ (for iOS development - macOS only)
- **Git** (optional, for version control)

## Installation Steps

### 1. Install Flutter

#### On Windows

```bash
# Download Flutter SDK from: https://flutter.dev/docs/get-started/install/windows
# Extract to folder (e.g., C:\flutter)
# Add to PATH environment variable:
# 1. Open System Properties → Advanced tab → Environment Variables
# 2. Edit PATH and add C:\flutter\bin
# 3. Restart terminal/IDE

# Verify installation
flutter --version
dart --version
```

#### On macOS

```bash
# Using Homebrew (recommended)
brew install flutter

# Or manually from https://flutter.dev/docs/get-started/install/macos
# Add to PATH in ~/.zshrc or ~/.bash_profile:
# export PATH="$PATH:$HOME/flutter/bin"

# Verify installation
flutter --version
dart --version
```

#### On Linux

```bash
# Download from https://flutter.dev/docs/get-started/install/linux
# Extract and add to PATH in ~/.bashrc:
# export PATH="$PATH:$HOME/flutter/bin"

# Verify installation
flutter --version
dart --version
```

### 2. Setup Android Development

#### On Windows/macOS/Linux

```bash
# Run Flutter doctor to check setup
flutter doctor

# Install Android SDK if needed
flutter pub get
```

### 3. Clone/Download Project

```bash
# Navigate to project directory
cd c:\Project\smartsaving\temp\app2

# Or if cloning from git
git clone <repository-url>
cd app2
```

### 4. Install Project Dependencies

```bash
# Get all Flutter/Dart packages
flutter pub get

# Upgrade packages (optional)
flutter pub upgrade
```

### 5. Check Device Setup

```bash
# List connected devices
flutter devices

# If Android emulator not running, start it:
# - Open Android Studio
# - Go to AVD Manager
# - Click Play button for any emulator
# - Or use: emulator -avd <emulator-name>

# For iOS (macOS only):
# - Xcode is required
# - First iOS build may take 5-10 minutes
```

## Running the App

### Quick Start (Easiest)

```bash
# Run app with all checks
flutter run

# The app will automatically start on connected device/emulator
```

### Run on Specific Device

```bash
# List devices
flutter devices

# Run on specific device
flutter run -d <device_id>

# Example
flutter run -d emulator-5554
```

### Run in Release Mode

```bash
# Faster performance, no debugging
flutter run --release
```

### Run with Specific Configuration

```bash
# Android only
flutter run -t lib/main.dart --device-id android

# iOS only (macOS)
flutter run -t lib/main.dart --device-id ios
```

## Development Workflow

### Hot Reload (Recommended)

While app is running, press:

- **R** - Hot reload (keeps app state)
- **r** - Hot reload
- **R** - Hot restart (resets app state)
- **Q** - Quit

### Using IDE

#### VS Code

```bash
# Install Flutter extension
# Then: Ctrl+Shift+D → Select "Flutter" configuration → Click Play

# Or use Commands:
# Ctrl+Shift+P → "Flutter: Run"
# Ctrl+Shift+P → "Flutter: Hot Reload"
```

#### Android Studio

```bash
# Click Run button (green play icon)
# Or: Shift+F10 (Windows) / Ctrl+R (Mac)
```

## Troubleshooting Common Issues

### Issue: "flutter command not found"

```bash
# Solution: Add Flutter to PATH
# Windows: Add to Environment Variables
# macOS/Linux: Add to ~/.bashrc or ~/.zshrc
export PATH="$PATH:$HOME/flutter/bin"
source ~/.bashrc  # or source ~/.zshrc
```

### Issue: "Android SDK not found"

```bash
# Solution: Install Android SDK
flutter doctor --android-licenses

# Or manually set ANDROID_SDK_ROOT
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
```

### Issue: Packages dependency error

```bash
# Solution 1: Clean and reinstall
flutter clean
flutter pub get

# Solution 2: Upgrade packages
flutter pub upgrade

# Solution 3: Delete pubspec.lock
rm pubspec.lock
flutter pub get
```

### Issue: Device not appearing

```bash
# Check device connection
flutter devices

# Enable USB debugging (Android)
# Developer Options → USB Debugging → Enable

# For emulator
emulator -avd <emulator-name>

# Trust device (iOS)
# Unlock iPhone and tap Trust in popup
```

### Issue: Build failure

```bash
# Clean everything
flutter clean
rm -rf ios/Pods ios/Podfile.lock  # macOS/iOS
flutter pub get

# Try again
flutter run
```

### Issue: Hot reload not working

```bash
# Use hot restart instead
# Press: Shift+R in terminal

# Or stop and run again
flutter run
```

## Building for Release

### Android APK

```bash
# Build APK
flutter build apk --release

# Find output at:
# build/app/outputs/flutter-apk/app-release.apk

# To install on device
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (Recommended)

```bash
# Build AAB for Google Play
flutter build appbundle --release

# Output at:
# build/app/outputs/bundle/release/app-release.aab
```

### iOS (macOS only)

```bash
# Build for device
flutter build ios --release

# Or build and upload to TestFlight
flutter build ios --release
# Then use Xcode to sign and upload

# Build for simulator
flutter build ios --release --simulator
```

## IDE Setup

### Android Studio

1. Open Android Studio
2. File → New → Project from Existing Sources
3. Select project folder
4. Click "Open"
5. Wait for sync to complete
6. Run → Run 'main.dart'

### VS Code

1. Open project folder
2. Install Flutter extension
3. Click "Get Packages"
4. Run → Start Debugging (F5)

### IntelliJ IDEA

1. Open project
2. Plugins → Marketplace → Install Flutter
3. Restart IDE
4. Run → Run 'main'

## Testing the App

### Login Flow

1. **Splash Screen** - Loading animation
2. **Login/Register** - Create account or login
   - Any email format works: `test@example.com`
   - Any password works (6+ chars): `password123`
3. **Home Screen** - Browse products
   - Search: Try "iPhone" or "Apple"
   - Track: Tap track button on any product

### Product Features

1. **Search** - Search by product name
2. **Compare** - View Amazon vs Flipkart prices
3. **Track** - Add to watchlist
4. **History** - View price trends
5. **Alerts** - Set target price

### Navigation

- **Bottom tabs** - Switch between Search/Tracked/Profile
- **Product card** - Tap to see details & compare
- **Track button** - Add/remove from watchlist
- **History button** - View price trends (if tracked)
- **Logout** - In Profile tab

## Performance Tips

### Fast Development

```bash
# Skip null safety checks
flutter run --no-null-safety

# Build faster
flutter run -t lib/main.dart --fast-start
```

### Faster Builds

```bash
# Build incrementally
flutter run --incremental-build

# Skip code generation
flutter run --no-tree-shake-icons
```

## Advanced Configuration

### Dart Analysis

```bash
# Check for errors
flutter analyze

# Run all checks
dart analyze lib/
```

### Package Audits

```bash
# Check for vulnerabilities
flutter pub audit

# See dependency tree
flutter pub deps
```

### Custom Build Configuration

Edit `android/app/build.gradle` or `ios/Podfile` for:

- Minimum SDK versions
- Signing configuration
- Custom dependencies
- Build flavors

## Environment Variables

Optional for advanced setup:

```bash
# Android SDK
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk

# Java Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home

# Flutter custom storage location
export FLUTTER_STORAGE_BASE_DIR=~/flutter_storage
```

## Next Steps

1. ✅ Installation complete
2. 👉 Run `flutter run`
3. 🚀 Explore the app
4. 💻 Check [ARCHITECTURE.md](ARCHITECTURE.md) for code structure
5. 🔌 Integrate real APIs when ready

## Getting Help

### Official Resources

- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [Flutter Community](https://flutter.dev/community)

### Debugging

```bash
# Verbose output for troubleshooting
flutter run -v

# See all available devices
flutter devices -d

# Check system setup
flutter doctor -v
```

### Issues & Solutions

- **GitHub Issues**: Check official Flutter repo
- **Stack Overflow**: Tag with `flutter` and `dart`
- **Flutter Discord**: Real-time community support

## Quick Commands Reference

```bash
# Essential commands
flutter pub get              # Install dependencies
flutter run                  # Run app
flutter run --release        # Production build
flutter clean                # Clear build files
flutter doctor               # Check setup
flutter devices              # List devices
flutter analyze              # Check code style
flutter pub upgrade          # Update dependencies
flutter pub run build_runner:watch  # Code generation (if needed)

# Android specific
flutter run -d android       # Run on Android only
flutter build apk --release  # Build APK
flutter build appbundle      # Build App Bundle

# iOS specific
flutter run -d ios           # Run on iOS (macOS)
flutter build ios --release  # Build iOS app

# Debugging
flutter run -v               # Verbose output
flutter run --debug          # Debug mode
flutter run --profile        # Profile mode
```

## Enjoy SmartSaving! 🎉

Your production-ready price comparison app is ready to use. Start tracking prices and saving money today!

---

**Need help?** Check [ARCHITECTURE.md](ARCHITECTURE.md) for detailed project structure and customization options.
