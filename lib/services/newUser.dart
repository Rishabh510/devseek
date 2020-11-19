import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devseek/views/createAccountView.dart';
import 'package:devseek/views/homeView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> addAccount(User user, BuildContext context) async {
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

Future<void> signInWithGoogle(BuildContext context) async {
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
  await addAccount(result.user, context);
}
