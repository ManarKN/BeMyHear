import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  checkAuthState;
  runApp(const MyApp());
}

const appColor = Color(0xfff44141);
final storage = FirebaseStorage.instance;
final storageRef = FirebaseStorage.instance.ref();
var authState = false; ///false = Signed Out \\ true = Signed In
var checkAuthState = FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
  if (user == null) {
    print('User is currently signed out!');
    authState = false;
  } else {
    print('User is signed in!');
    authState = true;
  }
});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authState ? const HomePage() : const RegisterPage(),
    );
  }
}


