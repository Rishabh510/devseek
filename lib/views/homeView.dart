import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'DevSeek',
          style: TextStyle(color: blue, fontSize: 60.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.yellow,
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Text(
                  'Get your daily quote',
                  style: TextStyle(fontSize: 36.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            buildPost(),
            buildPost(),
            buildPost(),
          ],
        ),
      ),
    );
  }

  Card buildPost() {
    return Card(
      color: Colors.pink[300],
      elevation: 16,
      margin: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: CircleAvatar(),
            title: Text('User Name'),
            subtitle: Text('Location'),
          ),
          Container(
            padding: EdgeInsets.all(0.02.hp),
            child: Text('Image description'),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.w),
              border: Border.all(color: Colors.black),
            ),
          ),
          Container(
            height: 0.4.hp,
            color: Colors.brown[300],
          ),
        ],
      ),
    );
  }
}
