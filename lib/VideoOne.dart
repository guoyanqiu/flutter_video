import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
///
/// 当加载好视频之后自动播放,仅提供
/// 播放功能，不提供暂停等控制事件
///
class VideoAutoPlayWhenReady extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoState();
  }
}

class _VideoState extends State<VideoAutoPlayWhenReady> {
  VideoPlayerController controller;
  bool _isInit = false;
  _VideoState() {
    controller=VideoPlayerController.asset(
      'videos/butterfly.mp4',
      package: 'flutter_gallery_assets',
    );
    controller.setLooping(true);
    controller.setVolume(0.0);
    ///随着播放会一直调用
//    controller.addListener(() {
//      if (!mounted) {
//        return;
//      }
//    });
    //还没准备好的时候没有不会播放
    controller.play();
  }
  @override
  void initState() {
    super.initState();
    controller.initialize().then((value){
        setState(() {
          _isInit = controller.value.initialized;

        });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  ///创建播放中的视频界面
  Widget _buildPlayingWidget(){
    return AspectRatio(
        aspectRatio: 3 / 2,
        child:  GestureDetector(
          onTap: (){
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          },
          child: VideoPlayer(controller),
        ));
  }

  ///视频正在加载的界面
  Widget _buildInitingWidget(){
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Stack(
        children: <Widget>[
          VideoPlayer(controller),
          const Center(child: CircularProgressIndicator()),
        ],
        fit: StackFit.expand,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('点击视频可暂停和播放'),
      ),
      body:  Center(
        child: _isInit
            ? _buildPlayingWidget()
        :_buildInitingWidget()
      ),
    );

  }
}
