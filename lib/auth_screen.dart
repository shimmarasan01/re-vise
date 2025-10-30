import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:test/functions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void submitAuthForm(String email, String password, bool isRegister) async {
    final auth = FirebaseAuth.instance;
    try {
      if (isRegister == true) {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromRGBO(244, 67, 54, 1),
          content: Text(e.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  bool isContainerMoved = false;
  String toggleText = "Register";
  bool isRegister = true;
  bool showPassword = false;

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            color: const Color.fromRGBO(121, 85, 72, 1),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0,
                              color: const Color.fromRGBO(0, 150, 136, 1)),
                          color: const Color.fromRGBO(0, 150, 136, 1),
                          borderRadius: BorderRadius.circular(10)),
                      width: 200,
                      height: 200,
                      child: const Icon(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          size: 200,
                          MaterialCommunityIcons.alpha_r),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 40,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (isContainerMoved == false) {
                            isContainerMoved = true;
                            toggleText = "Login";
                            isRegister = false;
                          } else {
                            isContainerMoved = false;
                            toggleText = "Register";
                            isRegister = true;
                          }
                          setState(() {});
                        },
                        child: Container(
                          height: 48,
                          width: 240,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0,
                                color: const Color.fromRGBO(255, 255, 255, 1)),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeInOut,
                                left: isContainerMoved ? 120 : 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0,
                                        color: const Color.fromRGBO(
                                            0, 150, 136, 1)),
                                    color: const Color.fromRGBO(0, 150, 136, 1),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  width: 120,
                                  height: 48,
                                  child: Center(
                                      child: Text(toggleText,
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 48,
                            width: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 150, 136, 1),
                                border: Border.all(
                                    width: 0,
                                    color:
                                        const Color.fromRGBO(0, 150, 136, 1))),
                            child: const Icon(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                size: 20,
                                MaterialCommunityIcons.email),
                          ),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                border: Border.all(
                                    width: 0,
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 1))),
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 0, left: 10, right: 10),
                            child: Theme(
                              data: ThemeData(
                                textSelectionTheme:
                                    const TextSelectionThemeData(
                                        cursorColor:
                                            Color.fromRGBO(121, 85, 72, 1),
                                        selectionColor:
                                            Color.fromRGBO(121, 85, 72, 0.2)),
                              ),
                              child: TextField(
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  selectionControls: CustomColorSelectionHandle(
                                      const Color.fromRGBO(0, 150, 136, 1)),
                                  magnifierConfiguration:
                                      TextMagnifierConfiguration.disabled,
                                  onTap: () {},
                                  enableInteractiveSelection: true,
                                  onTapOutside: (PointerDownEvent a) {
                                    emailFocusNode.unfocus();
                                  },
                                  decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Color.fromRGBO(121, 85, 72, 1),
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  readOnly: false),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 48,
                            width: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 150, 136, 1),
                                border: Border.all(
                                    width: 0,
                                    color:
                                        const Color.fromRGBO(0, 150, 136, 1))),
                            child: const Icon(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                size: 20,
                                MaterialCommunityIcons.key),
                          ),
                          Container(
                            width: 250,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                border: Border.all(
                                    width: 0,
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 1))),
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 0, left: 10, right: 0),
                            child: Theme(
                              data: ThemeData(
                                textSelectionTheme:
                                    const TextSelectionThemeData(
                                        cursorColor:
                                            Color.fromRGBO(121, 85, 72, 1),
                                        selectionColor:
                                            Color.fromRGBO(121, 85, 72, 0.2)),
                              ),
                              child: TextField(
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  obscureText:
                                      showPassword == false ? true : false,
                                  selectionControls: CustomColorSelectionHandle(
                                      const Color.fromRGBO(0, 150, 136, 1)),
                                  magnifierConfiguration:
                                      TextMagnifierConfiguration.disabled,
                                  onTap: () {},
                                  enableInteractiveSelection: true,
                                  onTapOutside: (PointerDownEvent a) {
                                    setState(() {});
                                    passwordFocusNode.unfocus();
                                  },
                                  decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Color.fromRGBO(121, 85, 72, 1),
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  readOnly: false),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                border: Border.all(
                                    width: 0,
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 1))),
                            child: SizedBox(
                              height: 48,
                              width: 50,
                              child: GestureDetector(
                                onTapCancel: () {
                                  showPassword = false;
                                  setState(() {});
                                },
                                onTapDown: (TapDownDetails a) {
                                  showPassword = true;
                                  setState(() {});
                                },
                                child: ElevatedButton(
                                    onPressed: () {
                                      showPassword = false;
                                      setState(() {});
                                    },
                                    style: const ButtonStyle(
                                        elevation: MaterialStatePropertyAll(0),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromRGBO(0, 0, 0, 0))),
                                    child: const Icon(
                                        color: Color.fromRGBO(121, 85, 72, 1),
                                        size: 20,
                                        MaterialCommunityIcons.eye)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 240,
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: GestureDetector(
                            onTap: () async {
                              try {
                                final result =
                                    await InternetAddress.lookup('example.com');
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {
                                  signInWithGoogle();
                                }
                              } on SocketException catch (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor:
                                        Color.fromRGBO(244, 67, 54, 1),
                                    content: Text("No internet connection"),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 48,
                              width: 115,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  border: Border.all(
                                      width: 0,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1))),
                              child: const Icon(
                                  color: Color.fromRGBO(0, 150, 136, 1),
                                  size: 20,
                                  MaterialCommunityIcons.google),
                            ),
                          )),
                          Flexible(
                              child: GestureDetector(
                            onTap: () async {
                              submitAuthForm(emailController.text.trim(),
                                  passwordController.text.trim(), isRegister);
                              /*
                                  try {
                                    final result = await InternetAddress.lookup(
                                        'example.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                      submitAuthForm(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                          isRegister);
                                    }
                                  } on SocketException catch (_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromRGBO(244, 67, 54, 1),
                                        content: Text("No internet connection"),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                  */
                            },
                            child: Container(
                              height: 48,
                              width: 115,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 150, 136, 1),
                                  border: Border.all(
                                      width: 0,
                                      color: const Color.fromRGBO(
                                          0, 150, 136, 1))),
                              child: const Icon(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  size: 25,
                                  MaterialCommunityIcons.arrow_right_bold),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ]),
            )));
  }
}
