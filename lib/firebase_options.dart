// Import necessary packages and dependencies
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// Class that provides default Firebase options for different platforms
class DefaultFirebaseOptions {
  // Returns FirebaseOptions based on the current platform
  static FirebaseOptions get currentPlatform {
    // Check if the platform is web
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // Return FirebaseOptions based on the target platform
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android; // Return Android-specific options
      case TargetPlatform.iOS:
        return ios; // Return iOS-specific options
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

  // FirebaseOptions for Android platform
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS-MygXJ9k-nCT4ZIFPUe9YN_N7GC4frs',
    appId: '1:1089291202108:android:2e30af1ebeeecf475edd39',
    messagingSenderId: '1089291202108',
    projectId: 'dllylas-ec27d',
    storageBucket: 'dllylas-ec27d.appspot.com',
  );

  // FirebaseOptions for iOS platform
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrd3RE9LY1-YCxMpSOEA9klOaBJsWcW80',
    appId: '1:1089291202108:ios:4a56330d94989da55edd39',
    messagingSenderId: '1089291202108',
    projectId: 'dllylas-ec27d',
    storageBucket: 'dllylas-ec27d.appspot.com',
    iosClientId:
        '1089291202108-dmf8fkom8bb7i105pef3ububtr8rcnu3.apps.googleusercontent.com',
    iosBundleId: 'com.market.dllylas',
  );
}
