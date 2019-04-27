import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayInWifiStatelessWidget extends StatelessWidget {
  final VideoPlayerController controller;

  PlayInWifiStatelessWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildPlayingWidget();
  }
  Widget _buildPlayingWidget() {
    controller.play();
    return AspectRatio(
        aspectRatio: 3 / 2,
        child: GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          },
          child: VideoPlayer(controller),
        ));
  }
}


///wifi状态下的播放自动播放
class PlayInWifiStatefulWidget extends StatefulWidget {
  final VideoPlayerController controller;

  PlayInWifiStatefulWidget({this.controller});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayInWifiState(controller: controller);
  }
}

class _PlayInWifiState extends State<PlayInWifiStatefulWidget> {
  final VideoPlayerController controller;

  VoidCallback _listener;
  bool isPauseByUser = false;

  _PlayInWifiState({@required this.controller}) {
    _listener = () {
      if (!mounted) {
        return;
      }
      setState(() {
        print("------村通网了----");
//        if (!controller.value.isPlaying && !isPauseByUser) {
//          controller.play();
//        }
      });
    };
  }

  @override
  void initState() {
    super.initState();
    controller.play();
    controller.addListener(_listener);
  }

  @override
  void deactivate() {
    controller.removeListener(_listener);
    super.deactivate();
  }

  ///创建播放中的视频界面
  Widget _buildPlayingWidget() {
    return AspectRatio(
        aspectRatio: 3 / 2,
        child: GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
              isPauseByUser = true;
            } else {
              controller.play();
            }
          },
          child: VideoPlayer(controller),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildPlayingWidget();
  }
}
