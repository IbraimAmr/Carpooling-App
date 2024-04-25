// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCenBYBMzAp9rS-nRHdFJr3VB4IYMuOFeY',
    appId: '1:695546650176:web:734ba024849c926644c9a5',
    messagingSenderId: '695546650176',
    projectId: 'projectx-824c7',
    authDomain: 'projectx-824c7.firebaseapp.com',
    databaseURL: 'https://projectx-824c7-default-rtdb.firebaseio.com',
    storageBucket: 'projectx-824c7.appspot.com',
    measurementId: 'G-6J98JPWYE3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3g-QJ_hOlSCKpC31nqHfx5YFkHTuuc_8',
    appId: '1:695546650176:android:5362273daa46031344c9a5',
    messagingSenderId: '695546650176',
    projectId: 'projectx-824c7',
    databaseURL: 'https://projectx-824c7-default-rtdb.firebaseio.com',
    storageBucket: 'projectx-824c7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3OlNCg-jD1B_os_i1f297H7qUO9vG4t4',
    appId: '1:695546650176:ios:73cc72e35d4697b344c9a5',
    messagingSenderId: '695546650176',
    projectId: 'projectx-824c7',
    databaseURL: 'https://projectx-824c7-default-rtdb.firebaseio.com',
    storageBucket: 'projectx-824c7.appspot.com',
    iosBundleId: 'com.example.finalProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3OlNCg-jD1B_os_i1f297H7qUO9vG4t4',
    appId: '1:695546650176:ios:56ee242c221d561744c9a5',
    messagingSenderId: '695546650176',
    projectId: 'projectx-824c7',
    databaseURL: 'https://projectx-824c7-default-rtdb.firebaseio.com',
    storageBucket: 'projectx-824c7.appspot.com',
    iosBundleId: 'com.example.finalProject.RunnerTests',
  );
}