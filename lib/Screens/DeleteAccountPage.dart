import 'package:TODO_LOGIN_APPLICATION/GetX_Helper/FirebaseController.dart';
import 'package:TODO_LOGIN_APPLICATION/Models/maincolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountPage extends GetWidget<FirebaseController> {
  final TextEditingController email_c = TextEditingController();
  final TextEditingController pass_c = TextEditingController();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                                      "Delete Account",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                30,
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
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: TextFormField(
                                    controller: pass_c,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: mainColor,
                                      ),
                                      labelText: 'Password',
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 1 *
                                          (MediaQuery.of(context).size.height /
                                              20),
                                      width: 4 *
                                          (MediaQuery.of(context).size.width /
                                              10),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: RaisedButton(
                                        elevation: 5.0,
                                        color: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        onPressed: () {
                                          controller.deleteuseraccount(
                                              email_c.text, pass_c.text);
                                        },
                                        child: Text(
                                          "Delete Account",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 1 *
                                          (MediaQuery.of(context).size.height /
                                              20),
                                      width: 4 *
                                          (MediaQuery.of(context).size.width /
                                              10),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: RaisedButton(
                                        elevation: 5.0,
                                        color: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        onPressed: () => Get.back(),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
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
