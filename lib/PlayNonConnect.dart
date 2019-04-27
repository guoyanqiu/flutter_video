
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


///断网或者视频没有准备好处理:视频自动暂停
class PlayNonConnectStatelessWidget extends StatelessWidget{
  final VideoPlayerController controller;

  PlayNonConnectStatelessWidget({ @required this.controller});


  ///视频正在加载的界面
  Widget _buildInitingWidget(){
    print("------断网了-或者视频没有初始化-自动暂停--");
    controller.pause();
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
    // TODO: implement build
    return _buildInitingWidget();
  }
}

///断网或者视频没有准备好处理:视频自动暂停
class PlayNonConnectStateFulWidget extends StatefulWidget{
  final VideoPlayerController controller;

  PlayNonConnectStateFulWidget({ @required this.controller});
  @override
  State<StatefulWidget> createState() {
    return _PlayNonConnectState(controller: controller);
  }
}

class _PlayNonConnectState extends State<PlayNonConnectStateFulWidget>{
  final VideoPlayerController controller;

  VoidCallback listener;
  _PlayNonConnectState({ @required this.controller}){
    listener = () {
      if(!mounted){
        return;
      }
     setState(() {
        print("------断网了-或者视频没有初始化---"+controller.value.isPlaying.toString());
        if (controller.value.isPlaying) {
          controller.pause();
        }
      });
    };
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return _buildInitingWidget();
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
}