import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ConnectionProvider extends ChangeNotifier {
  ConnectionProvider() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_updateStatus);
  }

  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final BehaviorSubject<bool> _isConnected = BehaviorSubject<bool>.seeded(false);
  final Connectivity _connectivity = Connectivity();

  Stream<bool> get isConnected => _isConnected.stream;

  void _updateStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile) {
      print("3G/4G");
      changeIsConnectedStatus(true);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      String wifiName = await _connectivity.getWifiName();
      String wifiSsid = await _connectivity.getWifiBSSID();
      String wifiIp = await _connectivity.getWifiIP();
      print("Wi-Fi\n$wifiName\n$wifiSsid\n$wifiIp");
      changeIsConnectedStatus(true);
    } else {
      print('Nao conectado');
      changeIsConnectedStatus(false);
    }
  }

  void changeIsConnectedStatus(bool status) {
    _isConnected.sink.add(status);
    notifyListeners();
  }

  bool get getIsConnectedStatus => _isConnected.value;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _isConnected.close();
    super.dispose();
  }
}
