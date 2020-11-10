import 'package:devseek/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstallView extends StatelessWidget {
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
              onPressed: () {},
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
