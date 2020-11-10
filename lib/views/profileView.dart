import 'dart:ui';
import 'package:devseek/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool grid = true;
  List<Widget> posts = [
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(32.w),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 0.2.hp,
                      decoration: BoxDecoration(
                        color: blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.05.wp,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(fontSize: 72.sp),
                                  ),
                                  Text(
                                    'Posts',
                                    style: TextStyle(fontSize: 36.sp),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(fontSize: 72.sp),
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(fontSize: 36.sp),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(fontSize: 72.sp),
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(fontSize: 36.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        OutlineButton(
                          onPressed: () {},
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(fontSize: 36.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DevSeek ID',
                      style: TextStyle(fontSize: 50.sp),
                    ),
                    Text(
                      'DevSeek User Name',
                      style: TextStyle(fontSize: 72.sp),
                    ),
                    Text(
                      'DevSeek Bio',
                      style: TextStyle(fontSize: 60.sp),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.grid_on, color: (grid) ? blue : Colors.grey),
                  onPressed: () {
                    setState(() {
                      grid = true;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.list, color: (grid) ? Colors.grey : blue),
                  onPressed: () {
                    setState(() {
                      grid = false;
                    });
                  },
                ),
              ],
            ),
            Divider(color: Colors.black, thickness: 0.5),
            (grid) ? createGridView() : createListView(),
          ],
        ),
      ),
    );
  }

  createGridView() {
    return Container(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, i) {
          return Container(
            child: posts[i],
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
      ),
    );
  }

  createListView() {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.all(8.w),
            width: double.infinity,
            height: 0.5.hp,
            child: posts[i],
          );
        },
      ),
    );
  }
}
