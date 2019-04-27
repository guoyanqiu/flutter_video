import 'package:flutter/material.dart';
import 'package:flutter_video/VideoOne.dart';
import 'package:flutter_video/VideoTwo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: AnimationHome(),
    );
  }
}


class AnimationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("视频播放系列demo"),
      ),
//      body:DebugDump(),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,position){
            return   ListTile(
              title: Text(list[position].name),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder:list[position].builder));
              },
            );
          }
      ),
    );
  }
}

class _RouterInfo {
  String name;
  WidgetBuilder builder;
  _RouterInfo({this.name, this.builder});
}

final List<_RouterInfo> list = <_RouterInfo>[
  _RouterInfo(name: "播放视频第一版", builder: (context) => VideoAutoPlayWhenReady()),
  _RouterInfo(name: "添加网络环境切换", builder: (context) => VideoMonitorConnect()),

];