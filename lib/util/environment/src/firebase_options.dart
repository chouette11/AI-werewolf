import 'package:firebase_core/firebase_core.dart';

import 'firebase_options_dev.dart' as dev;
import 'firebase_options_prod.dart' as prod;
import 'flavor.dart';

FirebaseOptions firebaseOptionsWithFlavor(Flavor flavor) {
  switch (flavor) {
    case Flavor.dev:
      return dev.DefaultFirebaseOptions.currentPlatform;
    case Flavor.stg:
      return dev.DefaultFirebaseOptions.currentPlatform;
    case Flavor.prod:
      return prod.DefaultFirebaseOptions.currentPlatform;
    case Flavor.tes:
      return dev.DefaultFirebaseOptions.currentPlatform;
  }
}
