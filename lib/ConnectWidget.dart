
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
class ConnectWidget extends StatefulWidget {
  final Widget wifiConnectWidget;
  final Widget mobileConnectWidget;
  final Widget noneConnectWidget;
  const ConnectWidget({  this.wifiConnectWidget,this.mobileConnectWidget,this.noneConnectWidget});
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<ConnectWidget> {
  ConnectivityResult _connectivityResult=ConnectivityResult.none;
  Stream<ConnectivityResult> connectChangeListener() async* {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult previousResult = await connectivity.checkConnectivity();
    yield previousResult;
    await for (ConnectivityResult result
    in connectivity.onConnectivityChanged) {
      if (result != previousResult) {
        yield result;
        previousResult = result;
      }
    }
  }
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    connectivitySubscription = connectChangeListener().listen( (ConnectivityResult connectivityResult) {
        if (!mounted) {
          return;
        }
        setState(() {
          _connectivityResult = connectivityResult;
        });
      },
    );
  }
  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("----- 网络状态---" + _connectivityResult.toString());
     if(_connectivityResult==ConnectivityResult.wifi){
       return widget.wifiConnectWidget;
     }else if(_connectivityResult==ConnectivityResult.mobile){
       return widget.mobileConnectWidget;
     }else{
       return widget.noneConnectWidget;
     }
  }
}
