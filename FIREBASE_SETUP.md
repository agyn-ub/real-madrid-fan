# Firebase Authentication Setup Guide - Apple Sign In Only

## Prerequisites
- Xcode 15.0 or later
- Apple Developer Account
- Firebase Account

## Setup Instructions

### 1. Firebase Console Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing one
3. Add an iOS app:
   - Bundle ID: Use your app's bundle identifier (e.g., `angus.Real-Madrid-fan`)
   - App nickname: Real Madrid Fan
   - Download `GoogleService-Info.plist`

### 2. Enable Authentication

1. In Firebase Console, go to Authentication
2. Click "Get Started"
3. Go to "Sign-in method" tab
4. Enable "Apple" provider:
   - Click on Apple
   - Enable it
   - Save (no additional configuration needed for iOS)

### 3. Xcode Project Setup

1. **Add GoogleService-Info.plist**:
   - Delete the placeholder file `GoogleService-Info-PLACEHOLDER.plist`
   - Drag your downloaded `GoogleService-Info.plist` to the project root (NOT inside the app folder)
   - Make sure "Copy items if needed" is checked
   - Add to target: Real Madrid fan

2. **Verify Capabilities**:
   - Select your project in Xcode
   - Select your target
   - Go to "Signing & Capabilities"
   - Ensure "Sign in with Apple" is enabled (should already be configured)

3. **Configure Bundle Identifier**:
   - Make sure your Bundle ID matches the one in Firebase Console
   - Update in Target > General > Identity if needed

### 4. Apple Developer Portal Setup

1. Go to [Apple Developer Portal](https://developer.apple.com/)
2. Identifiers > Your App ID
3. Enable "Sign In with Apple" capability
4. Save

### 5. Test the Implementation

1. Build and run the app on a real device or simulator
2. Tap the profile icon in the top right
3. Click "Sign in with Apple"
4. Complete authentication
5. Your profile should appear

## Features Implemented

- ✅ Apple Sign In Authentication
- ✅ Simple user profile display
- ✅ Session management
- ✅ Clean sign out functionality
- ✅ No data persistence (authentication only)

## Project Structure

```
Real Madrid fan/
├── Services/
│   └── AuthenticationManager.swift  # Handles Apple Sign In
├── Models/
│   └── User.swift                   # Simple user model (auth data only)
├── Views/
│   ├── AuthenticationView.swift     # Sign in screen
│   └── ProfileView.swift            # User profile display
└── Real_Madrid_fanApp.swift        # Firebase initialization
```

## What This Implementation Does

- **Authentication Only**: Users can sign in with their Apple ID
- **No Data Storage**: No user data or quiz scores are saved
- **Session Persistence**: Users remain signed in between app launches
- **Simple Profile**: Shows user's name/email and sign out option

## Troubleshooting

### Common Issues:

1. **"No GoogleService-Info.plist found"**
   - Ensure you've added the file to your Xcode project root
   - Check that it's included in your target

2. **Apple Sign In not working**
   - Verify capabilities in Xcode
   - Check Apple Developer Portal configuration
   - Ensure you're testing on iOS 13.0+

3. **Build errors after adding Firebase**
   - Clean build folder (Cmd+Shift+K)
   - Reset package caches: File > Packages > Reset Package Caches
   - Restart Xcode

## Note on Firestore

This implementation does NOT use Firestore. The Firebase dependency is included in the project file but is not actively used. If you want to completely remove it:

1. Remove `FirebaseFirestore` from Package Dependencies in Xcode
2. Keep only `FirebaseAuth` and `FirebaseCore`

## Support

For issues or questions:
- Firebase Documentation: https://firebase.google.com/docs/auth
- Apple Sign In: https://developer.apple.com/sign-in-with-apple/
- SwiftUI Documentation: https://developer.apple.com/documentation/swiftui/