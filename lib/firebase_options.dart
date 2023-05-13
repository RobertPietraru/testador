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
    apiKey: 'AIzaSyBDObcs3GlQjsvW_sDBwYD-C_vUrv7siWQ',
    appId: '1:40369619488:web:98b99bee44454d09e0f245',
    messagingSenderId: '40369619488',
    projectId: 'skeleton-a3bd2',
    authDomain: 'skeleton-a3bd2.firebaseapp.com',
    storageBucket: 'skeleton-a3bd2.appspot.com',
    measurementId: 'G-R8414YD0JP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtA1oWFif2z4fkbgNBtdWw9JXI5YmUddM',
    appId: '1:40369619488:android:aad3b5301728fe7fe0f245',
    messagingSenderId: '40369619488',
    projectId: 'skeleton-a3bd2',
    storageBucket: 'skeleton-a3bd2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyChretJh2zeOMO7FXwyMa-QPRj0Hkdsg',
    appId: '1:40369619488:ios:c7f5a17343592098e0f245',
    messagingSenderId: '40369619488',
    projectId: 'skeleton-a3bd2',
    storageBucket: 'skeleton-a3bd2.appspot.com',
    iosClientId:
        '40369619488-6r708l2qspaivcjci1fgtn6jc3jiorct.apps.googleusercontent.com',
    iosBundleId: 'com.example.testador',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyChretJh2zeOMO7FXwyMa-QPRj0Hkdsg',
    appId: '1:40369619488:ios:c7f5a17343592098e0f245',
    messagingSenderId: '40369619488',
    projectId: 'skeleton-a3bd2',
    storageBucket: 'skeleton-a3bd2.appspot.com',
    iosClientId:
        '40369619488-6r708l2qspaivcjci1fgtn6jc3jiorct.apps.googleusercontent.com',
    iosBundleId: 'com.example.testador',
  );
}
