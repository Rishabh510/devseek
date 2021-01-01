import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devseek/constants.dart';
import 'package:devseek/models/postModel.dart';
import 'package:devseek/models/userModel.dart';
import 'package:devseek/views/editProfileView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatefulWidget {
  final User currentUser;

  const ProfileView({Key key, this.currentUser}) : super(key: key);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool grid = true;
  String docId = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference colRef;
  UserModel myProfile;

  List<String> posts = [];

  @override
  void initState() {
    docId = widget.currentUser.uid;
    colRef = firestore.collection('users');
    super.initState();
  }

  Future<DocumentSnapshot> getCurrentUser() async {
    DocumentSnapshot docSnap = await colRef.doc(docId).get();
    return docSnap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: FutureBuilder(
          future: getCurrentUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            myProfile = UserModel.fromDocument(snapshot.data);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(32.w),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Hero(
                            tag: 'profile_pic',
                            child: Container(
                              child: Image.network(myProfile.url),
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
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfileView(
                                                myProfile: myProfile,
                                                docId: docId,
                                              )));
                                },
                                child: Hero(
                                  tag: 'edit_profile',
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(fontSize: 36.sp),
                                  ),
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
                            myProfile.username,
                            style: TextStyle(fontSize: 50.sp),
                          ),
                          Text(
                            myProfile.profilename,
                            style: TextStyle(fontSize: 72.sp),
                          ),
                          Text(
                            myProfile.bio,
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
                            posts = [];
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.list, color: (grid) ? Colors.grey : blue),
                        onPressed: () {
                          setState(() {
                            grid = false;
                            posts = [];
                          });
                        },
                      ),
                    ],
                  ),
                  Divider(color: Colors.black, thickness: 0.5),
                  FutureBuilder(
                    future: getPosts(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                      return (grid) ? createGridView(snapshot.data) : createListView(snapshot.data);
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future<List<String>> getPosts() async {
    posts = [];
    CollectionReference postRef = firestore.collection('posts');
    QuerySnapshot snap = await postRef.where('ownerId', isEqualTo: docId).get();
    snap.docs.forEach((element) {
      posts.add(PostModel.fromDocument(element).url);
    });
    return posts;
  }

  createGridView(List<String> posts) {
    return Container(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, i) {
          return Container(
            child: Image.network(posts[i]),
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

  createListView(List<String> posts) {
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
            child: Image.network(posts[i]),
          );
        },
      ),
    );
  }
}
