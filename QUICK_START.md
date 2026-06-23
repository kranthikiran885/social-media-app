# Quick Start Guide - Flutter Social Media App

## Installation

### Prerequisites
- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio or Xcode
- Git

### Setup Steps

1. **Clone Repository**
   ```bash
   git clone [repository-url]
   cd frontend
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Build Files**
   ```bash
   flutter pub get
   flutter clean
   flutter pub cache clean
   ```

4. **Run App**
   ```bash
   flutter run
   # or for web
   flutter run -d chrome
   ```

## Project Structure Quick Guide

```
lib/
├── main.dart                           # App entry point
├── core/theme/app_colors.dart          # Design system
└── features/
    ├── discover/          # Home & Explore
    ├── posts/             # Post Details & Comments
    ├── live/              # Live Streaming
    ├── shopping/          # Shop & Products
    ├── content/           # Content Creation
    ├── stories/           # Stories Viewer
    ├── profile/           # User Profile
    └── onboarding/        # Onboarding Flow
```

## Key Pages & Navigation

### All Available Pages
| Page | Route | Purpose |
|------|-------|---------|
| Home Feed | `/` | Browse posts and stories |
| Explore | `/explore` | Discover trending content |
| Search | `/search` | Find posts, users, hashtags |
| Post Details | `/post/{id}` | View full post with comments |
| Comments | `/comments` | Thread discussion view |
| Live Stream | `/live` | Watch live with chat |
| Shop | `/shop` | Browse products |
| Product Details | `/product/{id}` | Full product information |
| Content Creation | `/create` | Create posts, stories, reels |
| Stories | `/stories` | View story carousel |
| Profile | `/profile/{userId}` | User profile and content |
| Onboarding | `/onboarding` | App introduction |

## Running Specific Pages

To jump to a specific page during development:

```dart
// In main.dart, modify _navigatorObservers:
void main() {
  runApp(const MyApp());
}

// Quick test by modifying initial route:
MaterialApp(
  initialRoute: '/explore',  // Change to test different pages
  routes: {
    '/': (context) => const DiscoverPage(),
    '/explore': (context) => const ExplorePage(),
    // ... etc
  },
)
```

## Common Tasks

### Adding a New Page

1. Create folder: `lib/features/[name]/presentation/pages/`
2. Create file: `[name]_page.dart`
3. Extend `StatefulWidget` or `StatelessWidget`
4. Add route to `main.dart`

### Customizing Colors

Edit `lib/core/theme/app_colors.dart`:
```dart
class AppColors {
  static const Color primary = Color(0xFF6366F1);  // Change color
  // ... other colors
}
```

### Testing UI Changes

Use hot reload:
```bash
# After saving changes in editor
r          # Hot reload
R          # Full restart
q          # Quit
```

## Debugging Tips

### View Console Output
```bash
flutter run -v  # Verbose mode
```

### Check Performance
- Use DevTools: `flutter pub global run devtools`
- Monitor frame rate in running app
- Profile with: `flutter run --profile`

### Common Errors & Solutions

**Error: "No devices connected"**
```bash
flutter devices                    # List devices
flutter run -d [device-id]        # Run on specific device
```

**Error: "Gradle build failed"**
```bash
cd android
./gradlew clean                    # Clean Android build
cd ..
flutter pub get
```

**Error: "Pod install failed"**
```bash
cd ios
rm Podfile.lock
pod install
cd ..
```

## Building for Release

### Android
```bash
flutter build apk --release        # Create APK
flutter build appbundle --release  # Create App Bundle
```

### iOS
```bash
flutter build ios --release        # Create iOS build
```

### Web
```bash
flutter build web --release        # Create web build
```

## Key Files to Edit

### Theme & Colors
`lib/core/theme/app_colors.dart`

### Main App Config
`lib/main.dart`

### Routes
`lib/main.dart` routes map

### Features
Each feature has its own folder under `lib/features/`

## Testing the App

### Test Different Pages
1. Modify `initialRoute` in `main.dart`
2. Hot reload to navigate directly to that page
3. Test page interactions

### Test State Changes
- Like/unlike posts
- Toggle follow/unfollow
- Add items to cart
- Submit comments

### Test Navigation
- Use back button
- Tap navigation items
- Test deep linking

## Performance Optimization

### Enable Release Mode
```bash
flutter run --release  # Much faster performance
```

### Check Build Size
```bash
flutter build apk --analyze-size  # Show size breakdown
```

### Profile App
```bash
flutter run --profile
# Use DevTools for performance analysis
```

## Useful Flutter Commands

```bash
flutter clean                   # Clean build artifacts
flutter pub get               # Get dependencies
flutter pub upgrade           # Update dependencies
flutter analyze              # Check code quality
flutter format .             # Format code
flutter test                 # Run unit tests
flutter doctor               # Check environment
```

## IDE Shortcuts

### Android Studio/VS Code
- `Ctrl+Space` - Autocomplete
- `Ctrl+/` - Comment/uncomment
- `Alt+Enter` - Quick fixes
- `Ctrl+Shift+R` - Find in files

### Hot Reload
- `r` - Hot reload
- `R` - Full restart
- `q` - Quit

## Next Steps

1. **Explore Codebase** - Read through key pages
2. **Customize Colors** - Update app_colors.dart
3. **Add Backend** - Connect to API endpoints
4. **Setup Auth** - Implement login/registration
5. **Deploy** - Build and publish to app stores

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design](https://material.io/design)
- [Flutter Community](https://flutter.dev/community)

## Support

For issues or questions:
1. Check console output for errors
2. Review official Flutter documentation
3. Search Stack Overflow
4. Check GitHub issues

## Development Tips

1. **Use const constructors** - Better performance
2. **Dispose resources** - Prevent memory leaks
3. **Test on device** - Emulator may behave differently
4. **Use Dart formatting** - Keep code clean
5. **Comment complex logic** - Future maintainability

## File Size Tips

- Images: Use WebP format, compress before adding
- Dependencies: Minimize package imports
- Code: Remove unused imports with `flutter clean`

## Ready to Go!

Your Flutter social media app is ready for development. Start by exploring the pages and customizing them for your needs.

Happy coding! 🚀
