import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devseek/constants.dart';
import 'package:devseek/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileView extends StatefulWidget {
  final UserModel myProfile;
  final String docId;
  const EditProfileView({Key key, this.myProfile, this.docId}) : super(key: key);
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference colRef;
  TextEditingController _profileNameController;
  TextEditingController _bioController;

  @override
  void initState() {
    colRef = firestore.collection('users');
    _profileNameController = TextEditingController(text: widget.myProfile.profilename);
    _bioController = TextEditingController(text: widget.myProfile.bio);
    super.initState();
  }

  Future<void> saveDetails() async {
    await colRef.doc(widget.docId).update({
      'profilename': _profileNameController.text,
      'bio': _bioController.text,
    });
    Navigator.pop(context);
  }

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
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                saveDetails();
              }),
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
                  child: Image.network(widget.myProfile.url),
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
                controller: _profileNameController,
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
                controller: _bioController,
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
