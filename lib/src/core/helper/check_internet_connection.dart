import 'dart:io';

import '../core.dart';

/// Check if user has data connection
/// return Future [bool]
///
/// true: - if internet is connected
/// false: - if not connected
Future<bool> hasInternetConnection() async {
  try {
    final result = await InternetAddress.lookup("www.example.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    logger.e(e.toString());
    return false;
  }
}
