import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devseek/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class PostView extends StatefulWidget {
  final User currentUser;

  const PostView({Key key, this.currentUser}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final imagePicker = ImagePicker();
  File file;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  final _firebaseStorage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> pickImage(bool isCamera) async {
    PickedFile imageFile = await imagePicker.getImage(source: (isCamera) ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      file = File(imageFile.path);
    });
  }

  Widget showImage() {
    return Image.file(file);
  }

  Future<void> getLocation() async {
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await GeocodingPlatform.instance.placemarkFromCoordinates(pos.latitude, pos.longitude);
    String loc = "${placemarks[0].administrativeArea}, ${placemarks[0].country}";
    print(loc);
    _locationController.text = loc;
  }

  Future<void> uploadToFirebaseStorage() async {
    showSnackBar('Uploading in progress. Please Wait!');
    Reference postRef = _firebaseStorage.ref().child('posts');
    String postId = DateTime.now().toIso8601String();
    TaskSnapshot task = await postRef.child("$postId.jpg").putFile(file);
    String url = await task.ref.getDownloadURL();
    print(url);
    await uploadToFirestore(url, postId);
    reset();
  }

  void reset() {
    setState(() {
      file = null;
    });
    _descriptionController.clear();
    _locationController.clear();
    showSnackBar('Posted Successfully!');
  }

  void showSnackBar(String label) {
    SnackBar snackBar = SnackBar(
      content: Text(label),
      elevation: 8,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> uploadToFirestore(String url, String postId) async {
    CollectionReference postRef = _firestore.collection('posts');
    CollectionReference userRef = _firestore.collection('users');
    String docId = widget.currentUser.uid;
    DocumentSnapshot docSnap = await userRef.doc(docId).get();
    UserModel currentUser = UserModel.fromDocument(docSnap);
    await postRef.doc(postId).set({
      'postId': postId,
      'ownerId': docId,
      'ownerPhotoUrl': currentUser.url,
      'username': currentUser.username,
      'description': _descriptionController.text,
      'location': _locationController.text,
      'url': url,
      'likes': [],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Post'),
        actions: [
          IconButton(
              icon: Icon(Icons.send),
              onPressed: (file == null)
                  ? null
                  : () {
                      uploadToFirebaseStorage();
                    }),
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
                child: (file != null)
                    ? showImage()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Upload a photo',
                            style: TextStyle(fontSize: 40.sp),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            pickImage(true);
                                          }),
                                      Text(
                                        'from Camera',
                                        style: TextStyle(fontSize: 40.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.all(0.02.wp),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                              ),
                              Container(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            pickImage(false);
                                          }),
                                      Text(
                                        'from Gallery',
                                        style: TextStyle(fontSize: 40.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.all(0.02.wp),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              SizedBox(height: 40.h),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 40.h),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Location',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      getLocation();
                    },
                  ),
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
