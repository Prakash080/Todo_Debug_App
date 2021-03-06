import 'package:TODO_LOGIN_APPLICATION/Models/Todo.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/HomePage.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/LoginPage.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/VerifyPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseController extends GetxController {
  CollectionReference taskcollections =
      FirebaseFirestore.instance.collection('Todos');
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Rx<User> _firebaseUser = Rx<User>();

  String get user => _firebaseUser.value?.email;
  String get imageurl => _firebaseUser.value?.photoURL;
  String get displayname => _firebaseUser.value?.displayName;
  String get uid => _firebaseUser.value?.uid;

  // function to createuser, login and sign out user
  void createUser(String fullname, String email, String password) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("Users");

    Map<String, String> userdata = {
      "Full Name": fullname,
      "Email": email,
      "Password": password
    };

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      reference.add(userdata).then(
        (value) {
          _auth.currentUser.sendEmailVerification();
          Get.offAll(VerifyPage());
        },
      );
      Get.snackbar("Verification link sent to your mail", "Check Your mail");
    }).catchError(
      (onError) =>
          Get.snackbar("Error while creating account ", onError.message),
    );
  }

  void login(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      User user = _auth.currentUser;
      Get.offAll(HomePage(uid: user.uid));
      Get.snackbar("Login ", "Successful");
    }).catchError((onError) =>
            Get.snackbar("Error while Logging in", onError.message));
  }

  Future<bool> signout() async {
    User user = await _auth.currentUser;
    print(user.providerData[1].providerId);
    if (user.providerData[1].providerId == 'google.com') {
      await googleSignIn.disconnect();
    }
    await _auth.signOut();
    return Future.value(true);
  }

  void sendpasswordresetemail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.offAll(LoginPage());
      Get.snackbar("Password Reset email link is been sent", "Success");
    }).catchError(
        (onError) => Get.snackbar("Error In Email Reset", onError.message));
  }

  void deleteuseraccount(String email, String pass) async {
    User user = _auth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);

    await user.reauthenticateWithCredential(credential).then((value) {
      value.user.delete().then((res) {
        Get.offAll(LoginPage());
        Get.snackbar("User Account Deleted ", "Success");
      });
    }).catchError((onError) => Get.snackbar("Credential Error", "Failed"));
  }

  Future<bool> google_signIn() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await _auth.signInWithCredential(credential);

      User user = await _auth.currentUser;
      print(user.uid);

      return Future.value(true);
    }
  }

  Future<void> addTodo(String content, String uid) async {
    try {
      await _firestore.collection("Users").doc(uid).collection("todos").add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
      Get.to(HomePage(uid: _auth.currentUser.uid));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<Todo>> todoStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Todo> retVal = List();
      query.docs.forEach((element) {
        retVal.add(Todo.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteTodo(String uid, String todoId) async {
    try {
      taskcollections.doc(uid).collection("todos").doc(todoId).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
