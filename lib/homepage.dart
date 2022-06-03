import 'package:avatar_glow/avatar_glow.dart';
import 'package:be_my_hear/main.dart';
import 'package:be_my_hear/realtime_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'auth.dart';
import 'history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? currentGif;
bool _isListening = false;
String text = 'Press the button and start speaking';
double _confidence = 1.0;
List<String> gifs = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? image;

  @override
  void initState() {
    super.initState();
    text = 'Press the button and start speaking';
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async { return false; },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          glowColor: appColor,
          endRadius: 90.0,
          repeat: true,
          showTwoGlows: true,
          animate: _isListening,
          child: FloatingActionButton(
            onPressed: () async {
              await _listen();
            },
            foregroundColor: Colors.white,
            backgroundColor: appColor,
            child: const Icon(Icons.mic),
          ),
        ),
        appBar: AppBar(
          backgroundColor: appColor,
          title: const Text('Homepage'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'History'){
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const HistoryPage()));
                }
                else if (value == 'Log out') {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=> const LoginPage()));
                }
              },
              itemBuilder: (BuildContext context) {
                return {'History', 'Log out'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Center(child: Text(text,style: const TextStyle(fontSize: 22, fontFamily: "roboto"),),),
    );
  }

  late stt.SpeechToText _speech;
  Future<String> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if (val == "done") {
            setState(() async {
              _isListening = false;
              Navigator.push(context, CupertinoPageRoute(builder: (context) => const RealtimeResults()));
            });
          }
          if (kDebugMode) {
            print('onStatus: $val');
          }
        },

        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
    return " ";
  }

}

