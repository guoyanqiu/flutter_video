import 'package:flutter/cupertino.dart';
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
  bool goOn=false;

  void _showDemoDialog({BuildContext context, Widget child}) {
    showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((bool value) {
      if (value != null) {
        setState(() { goOn = value; });
      }
    });
  }


  _PlayInMobileState({@required this.controller}) {
    _listener = () {
      if (!mounted) {
        return;
      }
//      _showDemoDialog(
//        context: context,
//        child: CupertinoAlertDialog(
//          title: const Text('Discard draft?'),
//          actions: <Widget>[
//            CupertinoDialogAction(
//              child: const Text('播放'),
//              isDestructiveAction: true,
//              onPressed: () {
//                Navigator.pop(context, true);
//              },
//            ),
//            CupertinoDialogAction(
//              child: const Text('暂停'),
//              isDefaultAction: true,
//              onPressed: () {
//                Navigator.pop(context, false);
//              },
//            ),
//          ],
//        ),
//      );
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
//            child:VideoPlayer(controller),
          child: Stack(
            children: <Widget>[
              VideoPlayer(controller),
              _alertWidget()
            ],
          )
        ));
  }

  Widget _alertWidget(){
   return Center(
      child: Container(
          child:Column(
             children: <Widget>[
               Text("当前为移动网络，继续播放？"),
               Center(child:Row(
                 children: <Widget>[
                   GestureDetector(
                     child: Text("播放"),
                   ),
                   GestureDetector(
                     child: Text("暂停"),
                   ),
                 ],
               ))
             ],
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildPlayingWidget();
  }
}
