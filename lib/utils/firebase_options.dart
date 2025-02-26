import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

// Define the Firebase configuration for each platform
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // iOS and macOS configuration
      log("IOS PLATFORM");
      return ios;
    } else {
      // Android configuration
      log("ANDROID PLATFORM");
      return android;
    }
  }

  // Firebase configuration for iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_rjfGMXotaAENpjJgpRvG9bMVeKq-48M',
    projectId: 'smartretiree-f1684',
    messagingSenderId: '709606280714',
    appId: '1:709606280714:ios:5bdf18395e92c9eeced9f3',
    iosBundleId: 'com.example.smartRetiree',
  );

  // Firebase configuration for Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxA1umor4ZTuTn_AvxB86715Cpv6nJYxA',
    projectId: 'smartretiree-f1684',
    messagingSenderId: '709606280714',
    appId: '1:709606280714:android:8c0656f64e352585ced9f3',
  );
}




// Explanation of Fields
// apiKey: The API key for your Firebase project.
// authDomain: The authentication domain for your Firebase project.
// projectId: The project ID for your Firebase project.
// storageBucket: The storage bucket for your Firebase project.
// messagingSenderId: The sender ID for Firebase Cloud Messaging.
// appId: The application ID for your Firebase project.
// measurementId: The measurement ID for Google Analytics (used only for web).
// iosBundleId: The bundle ID for the iOS app.