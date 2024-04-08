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
    apiKey: 'AIzaSyCvtt8EiOEpSon3TxjtXKKvuLeTDhDVOF0',
    appId: '1:580739260981:web:da22f44cff10a6e932c77c',
    messagingSenderId: '580739260981',
    projectId: 'bsfd-7a1f7',
    authDomain: 'bsfd-7a1f7.firebaseapp.com',
    storageBucket: 'bsfd-7a1f7.appspot.com',
    measurementId: 'G-EDF5P42JTF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVTEtgZb39ExbS3zzzKwl2Hg2YMyKm9rc',
    appId: '1:580739260981:android:f451bcb5ae218a6632c77c',
    messagingSenderId: '580739260981',
    projectId: 'bsfd-7a1f7',
    storageBucket: 'bsfd-7a1f7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkcqBj3kSNiQQMldNadeDIFC9OlMZ9XoU',
    appId: '1:580739260981:ios:495ace10fdbe658632c77c',
    messagingSenderId: '580739260981',
    projectId: 'bsfd-7a1f7',
    storageBucket: 'bsfd-7a1f7.appspot.com',
    iosClientId: '580739260981-i2mb47mkq0bb1ekmjmagt1qaq5v3g342.apps.googleusercontent.com',
    iosBundleId: 'com.example.bsf',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkcqBj3kSNiQQMldNadeDIFC9OlMZ9XoU',
    appId: '1:580739260981:ios:993bcb40f43e4d8432c77c',
    messagingSenderId: '580739260981',
    projectId: 'bsfd-7a1f7',
    storageBucket: 'bsfd-7a1f7.appspot.com',
    iosClientId: '580739260981-8ln3ick64ktpubdt2bjq9tf84dcj4r4n.apps.googleusercontent.com',
    iosBundleId: 'com.example.bsf.RunnerTests',
  );
}