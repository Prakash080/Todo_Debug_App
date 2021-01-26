import 'package:TODO_LOGIN_APPLICATION/GetX_Helper/FirebaseController.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/DeleteAccountPage.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home_drawer extends GetWidget<FirebaseController> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  var mainColor = Color(0xff2470c7);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: mainColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      child: Icon(Icons.home_filled),
                      margin: EdgeInsets.only(top: 50),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      )),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.assignment),
              title: Text("Your Todos",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: MediaQuery.of(context).size.height / 40,
                  )),
              onTap: () {
                User user = _auth.currentUser;
                Get.to(HomePage(uid: user.uid));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Delete Account",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: MediaQuery.of(context).size.height / 40,
                  )),
              onTap: () => Get.to(DeleteAccountPage()),
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: MediaQuery.of(context).size.height / 40,
                    )),
                onTap: () {
                  controller.signout();
                }),
          )
        ],
      ),
    );
  }
}
