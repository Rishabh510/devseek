import 'package:devseek/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Hero(tag: 'edit_profile', child: Text('Edit Profile')),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'profile_pic',
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blue,
                  ),
                  height: 0.4.wp,
                ),
              ),
              SizedBox(height: 50.h),
              Text(
                'Profile Name',
                style: TextStyle(fontSize: 50.sp),
              ),
              SizedBox(height: 20.h),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter new profile name',
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'About',
                style: TextStyle(fontSize: 50.sp),
              ),
              SizedBox(height: 20.h),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter new description',
                ),
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
