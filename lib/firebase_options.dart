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
    apiKey: 'AIzaSyBOREjyC1ArM8E6j3VbzepMnqB7SP7fXeE',
    appId: '1:662993512175:web:1f5cd8af6d9bc8e63b5d1a',
    messagingSenderId: '662993512175',
    projectId: 'iot-control-e9084',
    authDomain: 'iot-control-e9084.firebaseapp.com',
    storageBucket: 'iot-control-e9084.appspot.com',
    measurementId: 'G-QYRLS0NLXL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOAVlrdOX0_DT_EiA3pHzzsHrlC0sj3R4',
    appId: '1:662993512175:android:6ab662658ebd10f63b5d1a',
    messagingSenderId: '662993512175',
    projectId: 'iot-control-e9084',
    storageBucket: 'iot-control-e9084.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7wERieaJXfCJ54sBrysoeb9d9-HC_QZU',
    appId: '1:662993512175:ios:828abaca64ff4ece3b5d1a',
    messagingSenderId: '662993512175',
    projectId: 'iot-control-e9084',
    storageBucket: 'iot-control-e9084.appspot.com',
    iosBundleId: 'mx.tecnm.cdhidalgo.iotControl',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7wERieaJXfCJ54sBrysoeb9d9-HC_QZU',
    appId: '1:662993512175:ios:828abaca64ff4ece3b5d1a',
    messagingSenderId: '662993512175',
    projectId: 'iot-control-e9084',
    storageBucket: 'iot-control-e9084.appspot.com',
    iosBundleId: 'mx.tecnm.cdhidalgo.iotControl',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBOREjyC1ArM8E6j3VbzepMnqB7SP7fXeE',
    appId: '1:662993512175:web:29a0e8eaf1c609143b5d1a',
    messagingSenderId: '662993512175',
    projectId: 'iot-control-e9084',
    authDomain: 'iot-control-e9084.firebaseapp.com',
    storageBucket: 'iot-control-e9084.appspot.com',
    measurementId: 'G-C2SJT5SC6X',
  );
}
