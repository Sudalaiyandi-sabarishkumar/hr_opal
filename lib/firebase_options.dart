import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;
 
import 'flavors.dart';
 
class FlavorFirebaseOptions {
  static late Flavor flavor;
 
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web not configured');
    }
 
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _android;
      case TargetPlatform.iOS:
        return _ios;
      case TargetPlatform.fuchsia:
        throw UnimplementedError();
      case TargetPlatform.linux:
        throw UnimplementedError();
      case TargetPlatform.macOS:
        throw UnimplementedError();
      case TargetPlatform.windows:
        throw UnimplementedError();
    }
  }
 
  static FirebaseOptions get _android {
    switch (flavor) {
      case Flavor.dev:
        return _androidDev;
      case Flavor.staging:
        return _androidStaging;
      case Flavor.prod:
        return _androidProd;
    }
  }
 
  static FirebaseOptions get _ios {
    switch (flavor) {
      case Flavor.dev:
        return _iosDev;
      case Flavor.staging:
        return _iosStaging;
      case Flavor.prod:
        return _iosProd;
    }
  }
 
  // ===== DEV =====
  static const FirebaseOptions _androidDev = FirebaseOptions(
    apiKey: 'AIzaSyDxu4TWnqrIPB_YRSEOMKB9IrRzS84m9z0',
    appId: '1:404765026055:android:3f97b5fe195e834cc107a2',
    messagingSenderId: '404765026055',
    projectId: 'elixir-hropal',
    storageBucket: 'elixir-hropal.firebasestorage.app',
  );
 
  static const FirebaseOptions _iosDev = FirebaseOptions(
    apiKey: 'AIzaSyCS0fuR46YpYGq7ye_egU7RiIi8QqcXZls',
    appId: '1:404765026055:ios:9144f854939e9e44c107a2',
    messagingSenderId: '404765026055',
    projectId: 'elixir-hropal',
    storageBucket: 'elixir-hropal.firebasestorage.app',
    iosBundleId: 'com.hropal.app.dev',
  );
 
  // ===== STAGING =====
  static const FirebaseOptions _androidStaging = FirebaseOptions(
    apiKey: 'AIzaSyDxu4TWnqrIPB_YRSEOMKB9IrRzS84m9z0',
    appId: '1:404765026055:android:32c8480e7de81ebac107a2',
    messagingSenderId: '404765026055',
    projectId: 'elixir-hropal',
    storageBucket: 'elixir-hropal.firebasestorage.app',
  );
 
  static const FirebaseOptions _iosStaging = FirebaseOptions(
    apiKey: 'AIzaSyCS0fuR46YpYGq7ye_egU7RiIi8QqcXZls',
    appId: '1:404765026055:ios:981344b727286c6fc107a2',
    messagingSenderId: '404765026055',
    projectId: 'elixir-hropal',
    storageBucket: 'elixir-hropal.firebasestorage.app',
    iosBundleId: 'com.hropal.app.staging',
  );
 
  // ===== PROD =====
  static const FirebaseOptions _androidProd = FirebaseOptions(
    apiKey: 'AIzaSyDxu4TWnqrIPB_YRSEOMKB9IrRzS84m9z0',
    appId: '1:404765026055:android:3f5a92783b8cbb78c107a2',
    messagingSenderId: '404765026055',
    projectId: 'elixir-hropal',
    storageBucket: 'elixir-hropal.firebasestorage.app',
  );
 
  static const FirebaseOptions _iosProd = FirebaseOptions(
    apiKey: 'AIzaSyCS0fuR46YpYGq7ye_egU7RiIi8QqcXZls',
    appId: '1:404765026055:ios:7db63f209392955fc107a2',
    messagingSenderId: '404765026055',
    projectId: 'elixir-hropal',
    storageBucket: 'elixir-hropal.firebasestorage.app',
    iosBundleId: 'com.hropal.app',
  );
}