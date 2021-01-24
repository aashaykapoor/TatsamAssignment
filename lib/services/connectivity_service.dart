import 'dart:async';

import 'package:connectivity/connectivity.dart';

///Custom Enum used to define connectionStatus
enum ConnectivityStatus { Cellular, Wifi, Offline }

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionController =
      StreamController<ConnectivityStatus>();

  /// Function to determing connectivity status based on ConnectivityResult
  ConnectivityStatus _getConnectivityStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;

        break;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;

        break;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;

        break;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  /// Connectivity Subscriber
  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((connectionStatus) {
      var connection = _getConnectivityStatus(connectionStatus);
      connectionController.add(connection);
    });
  }
}
