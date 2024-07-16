import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyA5SnGX0aUBIk_BZ-pFV8FM4AteqJ6zOyc',
  appId: '1:1018581439591:android:244d926456d404e6b470c2',
  projectId: 'goodchat-99715',
  messagingSenderId: '1018581439591',
  storageBucket: 'goodchat-99715.appspot.com',
  );
}