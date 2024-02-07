import 'package:connectivity/connectivity.dart';

class InternetService {
  static Future<bool> isInternetAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false; // No internet connection
    } else {
      return true; // Internet connection available
    }
  }
}
