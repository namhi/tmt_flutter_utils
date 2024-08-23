import 'dart:io';

class InternetUtils {
  InternetUtils._();

  //The test to actually see if there is a connection
  static Future<bool> checkConnection({String host = 'google.com'}) async {
    bool hasConnection = false;

    try {
      final result = await InternetAddress.lookup(host);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    return hasConnection;
  }
}
