 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components.dart';

class PreviewPage extends StatefulWidget {
  final vidURL, originalVideo;
  const PreviewPage({Key? key, this.vidURL, this.originalVideo}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    if (kDebugMode) {
      print(aspect);
    }
    if (kDebugMode) {
      print(s);
    }
    return Scaffold(
      body: Center(
        child: Container(
          width: s.width,
          height: s.width/aspect,
          alignment: Alignment.center,
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: s.width,
                height: s.width/aspect,
                child: VideoPlayerW(vid: widget.originalVideo,)),
              Align(
                alignment: Alignment.bottomLeft,
                widthFactor: s.width,
                child: Container(
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                    color: const Color(0x55FFFFFF),
                      image:  DecorationImage(image: NetworkImage(widget.vidURL))
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
