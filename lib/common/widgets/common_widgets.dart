import 'package:flutter/foundation.dart';

printDebug({required value}) {
  if (kDebugMode) {
    print(value);
  }
}
