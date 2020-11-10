import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Post'),
        actions: [
          IconButton(icon: Icon(Icons.send), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 0.4.hp,
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon: Icon(Icons.add), onPressed: () {}),
                      Text(
                        'Upload a photo',
                        style: TextStyle(fontSize: 50.sp),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
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
