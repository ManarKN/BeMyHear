import 'package:be_my_hear/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var emailCont = TextEditingController(), passCont = TextEditingController();
  var emailError = false;
  var passError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text('Create New Account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2,),
              TextField(
                controller: emailCont,
                decoration:  InputDecoration(
                  labelText: "Email Address",
                  errorText:  emailError ? "You can not use this Email" : null,
                ),
              ),
              const Spacer(flex: 4,),
              TextField(
                controller: passCont,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: passError ?  'The password is too weak.' : null,
                ),
              ),

              const Spacer(flex: 15,),
              Flexible(
                flex: 5,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailCont.text,
                        password: passCont.text,
                      );
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => const HomePage()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        if (kDebugMode) {
                          print('The password provided is too weak.');
                        }
                        setState(() {
                          passError = true;
                        });
                      } else {
                        passError = false;
                      }

                      if (e.code == 'email-already-in-use' ) {
                        if (kDebugMode) {
                          print('The account already exists for that email.');
                        }
                        setState(() {
                          emailError = true;
                        });
                      }
                      else if (e.code == "invalid-email") {
                        if (kDebugMode) {
                          print('Invalid Email.');
                        }
                        setState(() {
                          emailError = true;
                        });
                      } else {
                        emailError = false;
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }

                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: appColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                  ),

                ),
              ),
              const Spacer(flex: 1,),
              Flexible(
                flex: 5,
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    "Do you have account already?",
                    style: TextStyle(
                      color: appColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailCont = TextEditingController(), passCont = TextEditingController();
  var error = false;
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text('Sign into existing account'),
      ),
      body: Stack(
        children: [
          Container(
            width: s.width,
            height: s.height,
            decoration: const BoxDecoration(
              color: Colors.white
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 24.0),
              child: Column(
                children: [
                  const Spacer(flex: 2,),
                  TextField(
                    controller: emailCont,
                    decoration:  InputDecoration(
                      labelText: "Email Address",
                      errorText:  error ? "The Email is wrong" : null,
                    ),
                  ),
                  const Spacer(flex: 4,),
                  TextField(
                    controller: passCont,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: error ?  'Or the password is wrong.' : null,
                    ),
                  ),

                  const Spacer(flex: 15,),
                  Flexible(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailCont.text,
                            password: passCont.text,
                          );
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => const HomePage()));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'wrong-password') {
                            if (kDebugMode) {
                              print('The password provided is too weak.');
                            }
                            setState(() {
                              error = true;
                            });
                          }

                          if (e.code == 'user-not-found' ) {
                            if (kDebugMode) {
                              print('The account already exists for that email.');
                            }
                            setState(() {
                              error = true;
                            });
                          }
                          else if (e.code == "invalid-email") {
                            if (kDebugMode) {
                              print('Invalid Email.');
                            }
                            setState(() {
                              error = true;
                            });
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        }

                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        alignment: Alignment.center,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),

                    ),
                  ),


                  const Spacer(flex: 1,),
                  Flexible(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => const RegisterPage()));
                      },
                      child: const Text(
                        "Do you want to create account?",
                        style: TextStyle(
                          color: appColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
