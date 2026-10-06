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
    apiKey: 'AIzaSyCV-OsMEiqWOMi4wIN5vaMfuMWlIKhCPtg',
    appId: '1:256627936922:ios:c0feedb87f4aaf7fddd923',
    messagingSenderId: '256627936922',
    projectId: 'vuka-dev-89a61',
    storageBucket: 'vuka-dev-89a61.firebasestorage.app',
    iosBundleId: 'com.vuka.app',
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
    apiKey: 'AIzaSyDOg96VXWJxybJFMPJ-d7xYrsU0Vf0NTwo',
    appId: '1:560756357406:ios:25dafb3ebe264242e2310f',
    messagingSenderId: '560756357406',
    projectId: 'vuka-staging',
    storageBucket: 'vuka-staging.firebasestorage.app',
    iosBundleId: 'com.vuka.app.staging',
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
    apiKey: 'AIzaSyDy5IH1uk662jBaVD-74axmzfi7IrJ-rag',
    appId: '1:463821756854:ios:4494edfbef71332f348917',
    messagingSenderId: '463821756854',
    projectId: 'vuka-51c9b',
    storageBucket: 'vuka-51c9b.firebasestorage.app',
    iosBundleId: 'com.vuka.app',
  );
}