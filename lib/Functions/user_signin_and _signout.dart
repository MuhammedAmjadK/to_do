import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Model/user_model.dart';
import 'package:to_do/Parameters/common_parameters.dart';
import 'package:to_do/Screens/home_screen.dart';
import 'package:to_do/Screens/login_screen.dart';

final _auth = FirebaseAuth.instance;

loginUser(String email, String password, BuildContext context) async {
  try {
    var res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    userID = res.user!.uid;
    userEmail = email;

    var doc =
        await FirebaseFirestore.instance.collection('user').doc(userID).get();

    UserModel _user = UserModel.fromJson(doc.data()!);

    userName = _user.name;

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((ctx) => const HomeScreen())));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'wrong-password') {
      passWordError = 'Wrong Password';
      loginFormkey.currentState!.validate();
    } else if (e.code == 'user-not-found') {
      emailError = 'Invalid Email/User not found';
      loginFormkey.currentState!.validate();
    } else if (e.code == 'too-many-requests') {
      passWordError = 'Too many attempts. Try later';
      loginFormkey.currentState!.validate();
    } else if (e.code == 'network-request-failed') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Network connection failed')));
    }
  }
}

registerUser(
    String name, String email, String password, BuildContext context) async {
  try {
    var emailInfo = await _auth.fetchSignInMethodsForEmail(email);
    if (emailInfo.isEmpty) {
      var res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      userID = res.user!.uid;
      userEmail = email;
      userName = name;

      UserModel user = UserModel(id: userID!, name: name, email: email);

      final reference =
          FirebaseFirestore.instance.collection('user').doc(userID);

      await reference.set(user.toJson());

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((ctx) => const HomeScreen())),
          (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'This email address is already registered, Please go to login')));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'network-request-failed') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Network connection failed')));
    }
  }
}

checkUserLoggedIn(BuildContext context) async {
  var user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  } else {
    userID = user.uid;
    userEmail = user.email;

    var doc =
        await FirebaseFirestore.instance.collection('user').doc(userID).get();

    UserModel _user = UserModel.fromJson(doc.data()!);

    userName = _user.name;

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}

signOutUser(BuildContext context) async {
  _auth.signOut();
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}
