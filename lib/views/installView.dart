import 'package:devseek/constants.dart';
import 'package:devseek/services/newUser.dart';
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
                signInWithGoogle(context);
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
