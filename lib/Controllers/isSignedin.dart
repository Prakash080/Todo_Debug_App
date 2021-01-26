import 'package:TODO_LOGIN_APPLICATION/Screens/HomePage.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../GetX_Helper/FirebaseController.dart';

class IsSignedIn extends GetWidget<FirebaseController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      User user = FirebaseAuth.instance.currentUser;
      return Get.find<FirebaseController>().user != null
          ? HomePage(
              uid: user.uid,
            )
          : LoginPage();
    });
  }
}
