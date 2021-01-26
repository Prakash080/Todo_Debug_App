import 'package:TODO_LOGIN_APPLICATION/GetX_Helper/FirebaseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecoverPasswordPage extends GetWidget<FirebaseController> {
  var mainColor = Color(0xff2470c7);
  final TextEditingController email_c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Color(0xfff2f3f7),
            body: SingleChildScrollView(
                child: Stack(children: <Widget>[
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
              Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 70),
                      child: Text(
                        'To-Do',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 30,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                controller: email_c,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: mainColor,
                                    ),
                                    labelText: 'E-mail'),
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
                                    onPressed: () => controller
                                        .sendpasswordresetemail(email_c.text),
                                    child: Text(
                                      "Get Link",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1.5,
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
                      ))
                ])
              ])
            ]))));
  }
}
