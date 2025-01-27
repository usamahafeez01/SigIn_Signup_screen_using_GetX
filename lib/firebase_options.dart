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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBPZmewuD3aMAz_qNhR9BjfSv77TOlJDME',
    appId: '1:14856725952:web:00af7b89c52f7e7f921425',
    messagingSenderId: '14856725952',
    projectId: 'fir-9d8bf',
    authDomain: 'fir-9d8bf.firebaseapp.com',
    storageBucket: 'fir-9d8bf.firebasestorage.app',
    measurementId: 'G-PTE7Q4PMWZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuKbFMuotaRVJHJhCJrkwBGzgwCn8kqIY',
    appId: '1:14856725952:android:535ff8a5c557194e921425',
    messagingSenderId: '14856725952',
    projectId: 'fir-9d8bf',
    storageBucket: 'fir-9d8bf.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYvUHDa85ot2FQL3b3OvOuzL30xemRjp4',
    appId: '1:14856725952:ios:20ed1b2be35b929d921425',
    messagingSenderId: '14856725952',
    projectId: 'fir-9d8bf',
    storageBucket: 'fir-9d8bf.firebasestorage.app',
    iosBundleId: 'com.jantrahtech.demo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYvUHDa85ot2FQL3b3OvOuzL30xemRjp4',
    appId: '1:14856725952:ios:20ed1b2be35b929d921425',
    messagingSenderId: '14856725952',
    projectId: 'fir-9d8bf',
    storageBucket: 'fir-9d8bf.firebasestorage.app',
    iosBundleId: 'com.jantrahtech.demo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBPZmewuD3aMAz_qNhR9BjfSv77TOlJDME',
    appId: '1:14856725952:web:ff0129be79164147921425',
    messagingSenderId: '14856725952',
    projectId: 'fir-9d8bf',
    authDomain: 'fir-9d8bf.firebaseapp.com',
    storageBucket: 'fir-9d8bf.firebasestorage.app',
    measurementId: 'G-51K95LQLW4',
  );
}
