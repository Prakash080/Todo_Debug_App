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
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                controller: ph_c,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone_android,
                                    color: mainColor,
                                  ),
                                  labelText: 'Phone Number',
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Mobile number is required';
                                  }
                                  if (!RegExp(
                                          r"^(\+91)?(-)?\s*?(91)?\s*?(\d{3})-?\s*?(\d{3})-?\s*?(\d{4})")
                                      .hasMatch(value)) {
                                    return 'Please enter a valid Mobile number';
                                  }
                                },
                                onSaved: (String value) {
                                  ph_c.text = value;
                                },
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
                                      if (!formkey.currentState.validate()) {
                                        return;
                                      }
                                      verifyPhoneNumber();
                                    },
                                    child: Text(
                                      "Send OTP",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                45,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                controller: _smsController,
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Enter OTP',
                                  prefixIcon: Icon(
                                    Icons.security,
                                    color: mainColor,
                                  ),
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
                                      if (_auth.currentUser != null) {
                                        Get.to(HomePage(
                                          uid: _auth.currentUser.uid,
                                        ));
                                        Get.snackbar(
                                            "Successfully signed in UID:",
                                            "${_auth.currentUser.uid}");
                                      } else {
                                        signInWithPhoneNumber();
                                      }
                                    },
                                    child: Text(
                                      "Sign-in",
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

  Future<void> verifyPhoneNumber() async {
    print('Phone verification started');
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      Get.snackbar("verification code:", "" + verificationId);
      this._verificationId = verificationId;
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      Get.snackbar(
          "Please check your phone for the verification code.", "OTP Sent");
      this._verificationId = verificationId;
    };
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      Get.snackbar("Phone number automatically verified", "");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      Get.snackbar(
          "Phone number verification failed. Code: ${authException.code}",
          "Message: ${authException.message}");
    };
    await _auth.verifyPhoneNumber(
        phoneNumber: ph_c.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<void> signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    print('User Id : ' + user.uid);
  }
}
