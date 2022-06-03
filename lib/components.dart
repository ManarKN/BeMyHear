import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerW extends StatefulWidget {
  final vid;
  const VideoPlayerW({Key? key, this.vid}) : super(key: key);

  @override
  VideoPlayerWState createState() => VideoPlayerWState();
}
var aspect = 1.577777;
class VideoPlayerWState extends State<VideoPlayerW> {
  late VideoPlayerController vidCont;

  @override
  void initState() {
    super.initState();
    File file = File(widget.vid.path);

    vidCont = VideoPlayerController.file(file);

    vidCont.addListener(() {
      setState(() {});
    });
    vidCont.setLooping(false);
    vidCont.initialize().then((_) => setState(() {}));
    vidCont.play();
  }
  @override
  Widget build(BuildContext context) {
    aspect = vidCont.value.aspectRatio;
    return vidCont.value.isInitialized
          ? AspectRatio(
        aspectRatio: vidCont.value.aspectRatio,
        child: VideoPlayer(vidCont),
      )
          : Container();
  }
}
