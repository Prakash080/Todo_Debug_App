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

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Rx<User> _firebaseUser = Rx<User>();

  String get user => _firebaseUser.value?.email;
  String get imageurl => _firebaseUser.value?.photoURL;
  String get displayname => _firebaseUser.value?.displayName;
  String get uid => _firebaseUser.value?.uid;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());

    print(" Auth Change :   ${_auth.currentUser}");
  }

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

  void signout() async {
    await _auth.signOut().then((value) {
      Get.offAll(LoginPage());
      Get.snackbar("Logout ", "Successful");
    });
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

  void google_signIn() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    // ignore: unused_local_variable
    final result = (await _auth.signInWithCredential(credential).then((value) {
      User user = _auth.currentUser;
      print(user.uid);
      Get.offAll(HomePage(uid: user.uid));
      Get.snackbar("Login ", "Successful");
    }));
  }

  void add_todo(String todos, String uid) async {
    taskcollections.doc(uid).collection('Todos').add({
      'Task': todos,
      'Created Time': DateTime.now(),
    });
  }

  void delete_todo(String todos, String uid) async {
    final todoid = taskcollections.doc(uid).collection('Todos').doc().id;
    taskcollections.doc(uid).collection('Todos').doc(todoid).delete();
  }

  void update_todo(String todos, String uid) async {
    taskcollections.doc(uid).collection('Todos').doc(todos).update({
      'Task': todos,
      'Created Time': DateTime.now(),
    });
  }
}
