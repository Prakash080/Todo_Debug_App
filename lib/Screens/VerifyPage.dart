import 'package:TODO_LOGIN_APPLICATION/GetX_Helper/FirebaseController.dart';
import 'package:TODO_LOGIN_APPLICATION/Models/maincolor.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPage extends GetWidget<FirebaseController> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController ph_c = TextEditingController();
  TextEditingController _smsController = TextEditingController();
  String _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Color(0xfff2f3f7),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(70),
                        bottomRight: const Radius.circular(70),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 70),
                          child: Text(
                            'Verification',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Form(
                      key: formkey,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Verify Your E-mail",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 40,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Email Verification link sent to your mail",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 50,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 1 *
                                      (MediaQuery.of(context).size.height / 20),
                                  width: 4 *
                                      (MediaQuery.of(context).size.width / 10),
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    color: mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    onPressed: () {
                                      CircularProgressIndicator();
                                      _auth.currentUser.reload();
                                      if (_auth.currentUser.emailVerified) {
                                        Get.to(HomePage(
                                            uid: _auth.currentUser.uid));
                                        Get.snackbar("Login", "Successful");
                                      } else
                                        Get.snackbar("Verify Email",
                                            "Plese Verify yor email to login");
                                      _auth.currentUser.reload();
                                    },
                                    child: Text(
                                      "Done",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                40,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
