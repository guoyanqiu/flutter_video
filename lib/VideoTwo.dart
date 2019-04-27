import 'package:flutter/material.dart';
import 'package:flutter_video/ConnectWidget.dart';
import 'package:flutter_video/PlayInMobile.dart';
import 'package:flutter_video/PlayInWifi.dart';
import 'package:flutter_video/PlayNonConnect.dart';
import 'package:video_player/video_player.dart';
///
///添加WiFi网络控制
class VideoMonitorConnect extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoState();
  }
}

class _VideoState extends State<VideoMonitorConnect> {
  VideoPlayerController controller;
  bool _isInit = false;
  _VideoState() {
    controller=VideoPlayerController.asset(
      'videos/butterfly.mp4',
      package: 'flutter_gallery_assets',
    );
    controller.setLooping(true);
    controller.setVolume(0.0);
    controller.play();
  }
  @override
  void initState() {
    super.initState();
    controller.initialize().then((value){
      setState(() {

        _isInit = controller.value.initialized;
        print("---视频加载完毕---"+_isInit.toString());
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('监听网络变化'),
      ),
      body:  Center(
          child: _isInit?ConnectWidget(
               wifiConnectWidget:PlayInWifiStatelessWidget(controller: controller,),
               mobileConnectWidget: PlayInMobileStatelessWidget(controller: controller,),
               noneConnectWidget: PlayNonConnectStatelessWidget(controller: controller,)
          ):PlayNonConnectStatelessWidget(controller: controller,)
      ),
    );
  }
}


