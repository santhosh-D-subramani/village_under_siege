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
    apiKey: 'AIzaSyAzfEvIgJB088fVWnTD20u9LQRTfh7yaJw',
    appId: '1:1080779752145:web:0d49dbf2674e5568a6bbf0',
    messagingSenderId: '1080779752145',
    projectId: 'village-in-siege',
    authDomain: 'village-in-siege.firebaseapp.com',
    databaseURL: 'https://village-in-siege-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'village-in-siege.firebasestorage.app',
    measurementId: 'G-HR5LMJKLX6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCk0Ed6S1NpzFSUsSSfkGiD40GzletRoJ4',
    appId: '1:1080779752145:android:392cc611a8cf8c00a6bbf0',
    messagingSenderId: '1080779752145',
    projectId: 'village-in-siege',
    databaseURL: 'https://village-in-siege-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'village-in-siege.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKrH7JRm7rQqpi-VouV4uiEMJGV3Qvqtw',
    appId: '1:1080779752145:ios:419174293191d921a6bbf0',
    messagingSenderId: '1080779752145',
    projectId: 'village-in-siege',
    databaseURL: 'https://village-in-siege-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'village-in-siege.firebasestorage.app',
    iosClientId: '1080779752145-9tvfp7ns5nk7fnluk40v09snufk41v9i.apps.googleusercontent.com',
    iosBundleId: 'com.l2c.villageUnderSiege',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKrH7JRm7rQqpi-VouV4uiEMJGV3Qvqtw',
    appId: '1:1080779752145:ios:419174293191d921a6bbf0',
    messagingSenderId: '1080779752145',
    projectId: 'village-in-siege',
    databaseURL: 'https://village-in-siege-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'village-in-siege.firebasestorage.app',
    iosClientId: '1080779752145-9tvfp7ns5nk7fnluk40v09snufk41v9i.apps.googleusercontent.com',
    iosBundleId: 'com.l2c.villageUnderSiege',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAzfEvIgJB088fVWnTD20u9LQRTfh7yaJw',
    appId: '1:1080779752145:web:733c5ec5d62a5979a6bbf0',
    messagingSenderId: '1080779752145',
    projectId: 'village-in-siege',
    authDomain: 'village-in-siege.firebaseapp.com',
    databaseURL: 'https://village-in-siege-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'village-in-siege.firebasestorage.app',
    measurementId: 'G-1SK2PWNFPC',
  );

}