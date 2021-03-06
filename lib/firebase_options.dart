// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCAb6IzI5YA3KRwHMJC2HjCUQmtm6k3esA',
    appId: '1:87328541616:web:2a163ec5141d0447cda475',
    messagingSenderId: '87328541616',
    projectId: 'chrisander-pos',
    authDomain: 'chrisander-pos.firebaseapp.com',
    storageBucket: 'chrisander-pos.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtAdzL1hrhgFwRmNLOkIMa4hDgK6r8IDQ',
    appId: '1:87328541616:android:a87ab43ef2c85574cda475',
    messagingSenderId: '87328541616',
    projectId: 'chrisander-pos',
    storageBucket: 'chrisander-pos.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGsT1ku0iALh_9EIXvCiTlar2YOIQSAUk',
    appId: '1:87328541616:ios:90f86ca7a9e82008cda475',
    messagingSenderId: '87328541616',
    projectId: 'chrisander-pos',
    storageBucket: 'chrisander-pos.appspot.com',
    iosClientId: '87328541616-3o6q14pphpe0st2s65juuuq5fb9fa5jr.apps.googleusercontent.com',
    iosBundleId: 'com.chrisander.pos',
  );
}
