// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCXDvDz8unL_nmx6MmWX8xNHaGbTPR2xxg',
    appId: '1:616008436968:web:4f5d6f5d633f9151364d5d',
    messagingSenderId: '616008436968',
    projectId: 'fir-speed-zones',
    authDomain: 'fir-speed-zones.firebaseapp.com',
    storageBucket: 'fir-speed-zones.appspot.com',
    measurementId: 'G-1TCL6KMCWX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTY591hZTNJDbZGUekknjAAMV6Zh_MQBU',
    appId: '1:616008436968:android:ab45a7e4f6618c7c364d5d',
    messagingSenderId: '616008436968',
    projectId: 'fir-speed-zones',
    storageBucket: 'fir-speed-zones.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAo_MP3pUnEkyHQTBBvx8VIMxEWDD_pKSE',
    appId: '1:616008436968:ios:4bdd2ef1d925e9bb364d5d',
    messagingSenderId: '616008436968',
    projectId: 'fir-speed-zones',
    storageBucket: 'fir-speed-zones.appspot.com',
    iosBundleId: 'com.example.demoSpeedZones',
  );
}
