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
    apiKey: 'AIzaSyCSv5JbmfVdea5I3ZYc69h38klnZbLq-iY',
    appId: '1:412845107477:web:3568a0d75bf4d690db211c',
    messagingSenderId: '412845107477',
    projectId: 'student-data-76fb6',
    authDomain: 'student-data-76fb6.firebaseapp.com',
    storageBucket: 'student-data-76fb6.appspot.com',
    measurementId: 'G-YR5R2Q82J3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZYyJoytF0FhgDpvSmFcbQ7ZBhl4hkRVI',
    appId: '1:412845107477:android:d5a3632b9c0813afdb211c',
    messagingSenderId: '412845107477',
    projectId: 'student-data-76fb6',
    storageBucket: 'student-data-76fb6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAB-Wg2gDvoU81oPttyrQxUEk6UHBnNcko',
    appId: '1:412845107477:ios:883a58288d607df9db211c',
    messagingSenderId: '412845107477',
    projectId: 'student-data-76fb6',
    storageBucket: 'student-data-76fb6.appspot.com',
    iosBundleId: 'com.example.studentRecord',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAB-Wg2gDvoU81oPttyrQxUEk6UHBnNcko',
    appId: '1:412845107477:ios:7ba0de57e00857f0db211c',
    messagingSenderId: '412845107477',
    projectId: 'student-data-76fb6',
    storageBucket: 'student-data-76fb6.appspot.com',
    iosBundleId: 'com.example.studentRecord.RunnerTests',
  );
}
