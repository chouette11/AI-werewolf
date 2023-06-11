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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCu7X7hJL9nG4WpcritHzQxVbD4tAs1G2I',
    appId: '1:632237526803:web:06bf149c7466fdcd3754e6',
    messagingSenderId: '632237526803',
    projectId: 'wordwolf-1f53d',
    authDomain: 'wordwolf-1f53d.firebaseapp.com',
    storageBucket: 'wordwolf-1f53d.appspot.com',
    measurementId: 'G-QL7SY684DP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4C2BMh84GgFWlHDQFDmBQX24SpiEDJzQ',
    appId: '1:632237526803:android:a196338799ea76ca3754e6',
    messagingSenderId: '632237526803',
    projectId: 'wordwolf-1f53d',
    storageBucket: 'wordwolf-1f53d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCurKg5Hx1JE0yxUXvkT3Fl2EV3UoeS3Ao',
    appId: '1:632237526803:ios:d632d8b73d6946063754e6',
    messagingSenderId: '632237526803',
    projectId: 'wordwolf-1f53d',
    storageBucket: 'wordwolf-1f53d.appspot.com',
    iosClientId: '632237526803-pk47ifbshkicepc9v68g5qvc1uqit80p.apps.googleusercontent.com',
    iosBundleId: 'com.example.wordwolf',
  );
}
