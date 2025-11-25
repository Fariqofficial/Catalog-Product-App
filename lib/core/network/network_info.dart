import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:developer';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  const NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    log('Detailed connectivity: $result');
    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.ethernet)) {
      return true;
    }
    return false;
  }
}
