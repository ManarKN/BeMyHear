import 'package:be_my_hear/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'functions.dart';
import 'homepage.dart';

class RealtimeResults extends StatefulWidget {
  const RealtimeResults({Key? key}) : super(key: key);

  @override
  _RealtimeResultsState createState() => _RealtimeResultsState();
}

String processingImageURL = (
    "https://firebasestorage.googleapis.com/v0/b/be-my-hear.appspot.com/o/processing.png?alt=media&token=f50b855a-89c0-42b1-8ec1-80137499ed5d");
class _RealtimeResultsState extends State<RealtimeResults> {

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    print(i);
    if(i<gifs.length)
      gifSeq();
    print("***********************************************************************************************");
    print(i);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Results"),
            SizedBox(height: 20,),
            Container(
              height: s.width/aspect,
              width: s.width,
              decoration: BoxDecoration(
                color: const Color(0x55FFFFFF),
                image:  DecorationImage(image: NetworkImage(currentGif ?? processingImageURL),fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
  int i = 0;
  final gifs = text.split(' ');
  

  void gifSeq () async {
    if(gifs.contains("how")) {
      gifs.removeWhere((element) => element=="are");
      gifs.removeWhere((element) => element=="you");
    }

    currentGif = await getGif( gifs[i]);

    if (i<gifs.length-1) {
      i++;
    }
    else if (i>gifs.length-1) {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.push(context, CupertinoPageRoute(builder: (context) => const HomePage()));
      i=0;
    }
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      print(gifs);
    });
  }
}
