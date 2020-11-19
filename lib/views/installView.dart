import 'package:devseek/constants.dart';
import 'package:devseek/views/createAccountView.dart';
import 'package:devseek/views/homeView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InstallView extends StatefulWidget {
  @override
  _InstallViewState createState() => _InstallViewState();
}

class _InstallViewState extends State<InstallView> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addAccount(User user) async {
    CollectionReference colRef = firestore.collection('users');
    DocumentSnapshot docSnap = await colRef.doc(user.uid).get();
    if (docSnap.exists) return;
    List<String> details = await Navigator.push(context, MaterialPageRoute(builder: (ctx) => CreateAccountView()));
    await colRef.doc(user.uid).set({
      'id': user.uid,
      'username': details[0],
      'profilename': user.displayName,
      'bio': details[1],
      'photo': user.photoURL,
      'email': user.email,
    });
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    await addAccount(result.user);
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => HomeView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset(logoPath),
                ),
                Text(
                  'For the developers who seek',
                  style: TextStyle(
                    fontSize: 60.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            RaisedButton(
              color: blue.withOpacity(0.7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.w)),
              padding: EdgeInsets.symmetric(horizontal: 200.w, vertical: 50.h),
              onPressed: () {
                signInWithGoogle();
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 60.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
