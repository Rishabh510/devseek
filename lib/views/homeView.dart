import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devseek/models/postModel.dart';
import 'package:devseek/services/quote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool quoteLoaded = false;
  final _firestore = FirebaseFirestore.instance;
  CollectionReference postRef;
  List<PostModel> posts = [];
  DocumentSnapshot endingDocument;

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<List<PostModel>> getPosts() async {
    List<DocumentSnapshot> documents = [];
    QuerySnapshot snap;
    if (posts.isEmpty) {
      snap = await postRef.orderBy("postId", descending: true).get();
    } else {
      snap = await postRef.orderBy("postId", descending: true).endBeforeDocument(endingDocument).get();
    }
    documents = snap.docs;
    if (documents.isNotEmpty) {
      endingDocument = documents.first;
      for (int i = documents.length - 1; i >= 0; i--) {
        posts.insert(0, PostModel.fromDocument(documents[i]));
      }
    }
    return posts;
  }

  @override
  void initState() {
    postRef = _firestore.collection('posts');
    super.initState();
  }

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
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder(
              future: (quoteLoaded) ? getRandomQuote() : null,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Card(
                    color: Colors.yellow,
                    child: Padding(
                      padding: EdgeInsets.all(0.04.wp),
                      child: Text(
                        '" ' + snapshot.data + ' "',
                        style: TextStyle(fontSize: 40.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        quoteLoaded = true;
                      });
                    },
                    child: Card(
                      color: Colors.yellow,
                      child: Padding(
                        padding: EdgeInsets.all(0.04.wp),
                        child: Text(
                          'Fetch a quote!',
                          style: TextStyle(fontSize: 40.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
              },
            ),
            FutureBuilder(
              future: getPosts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: posts.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return buildPost(posts[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Card buildPost(PostModel post) {
    return Card(
      color: Colors.pink[300],
      elevation: 16,
      margin: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                post.ownerPhotoUrl,
                height: 0.1.wp,
                width: 0.1.wp,
              ),
            ),
            title: Text(post.username),
            subtitle: Text(post.location),
          ),
          Container(
            padding: EdgeInsets.all(0.02.hp),
            child: Text(post.description),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.w),
              border: Border.all(color: Colors.black),
            ),
          ),
          Container(
            color: Colors.brown[300],
            height: 0.4.hp,
            child: Image.network(post.url),
          ),
        ],
      ),
    );
  }
}
