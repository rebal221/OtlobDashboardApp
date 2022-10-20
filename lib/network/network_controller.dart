import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../lanugage/app_get.dart';

class NetworkController extends GetxController {
  late var connectionStatus = 3.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  AppGet appGet = Get.find();
  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      debugPrint(e.toString());
    }
    return _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        debugPrint(connectionStatus.toString());

        debugPrint('ConnectivityResult.wifi');
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        debugPrint(connectionStatus.toString());
        debugPrint('ConnectivityResult.mobile');
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        debugPrint(connectionStatus.toString());
        debugPrint('ConnectivityResult.none');
        break;
      default:
        Get.snackbar("مشكلة بالاتصال", "هناك مشكلة بالاتصال ");
        break;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
