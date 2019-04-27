import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


///移动网状态下的播放自动播放
class PlayInMobileStatelessWidget extends StatelessWidget {
  final VideoPlayerController controller;

  PlayInMobileStatelessWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    controller.pause();
    return _buildPlayingWidget();
  }


  ///创建播放中的视频界面
  Widget _buildPlayingWidget() {
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

///移动网状态下的播放自动播放
class PlayInMobileStatefulWidget extends StatefulWidget {
  final VideoPlayerController controller;

  PlayInMobileStatefulWidget({this.controller});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlayInMobileState(controller: controller);
  }
}

class _PlayInMobileState extends State<PlayInMobileStatefulWidget> {
  final VideoPlayerController controller;

  VoidCallback _listener;
  bool isPauseByUser = false;

  _PlayInMobileState({@required this.controller}) {
    _listener = () {
      if (mounted) {
        return;
      }
      setState(() {
        print("------手机网络----" + controller.value.isPlaying.toString());
        if (controller.value.isPlaying && !isPauseByUser) {
          controller.pause();
        }
      });
    };
  }

  @override
  void initState() {
    super.initState();
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
