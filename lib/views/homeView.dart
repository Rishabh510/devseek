import 'dart:async';

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
  final User currentUser;

  const HomeView({Key key, this.currentUser}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool quoteLoaded = false, postsLoaded = false;
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
    setState(() {
      postsLoaded = true;
    });
    return posts;
  }

  @override
  void initState() {
    postRef = _firestore.collection('posts');
    super.initState();
  }

  Future<void> refresh() async {
    setState(() {
      postsLoaded = false;
    });
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
      body: RefreshIndicator(
        onRefresh: () {
          return refresh();
        },
        child: SingleChildScrollView(
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
                future: (postsLoaded) ? null : getPosts(),
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
      ),
    );
  }

  bool heartShow = false, liked = false;

  Future<void> changeLikeStatus(PostModel post, bool liked) async {
    CollectionReference postRef = _firestore.collection('posts');
    String docId = widget.currentUser.uid;
    List<dynamic> oldData = post.likes;
    List<dynamic> newData = [];
    if (liked) {
      newData.add(docId);
    } else {
      oldData.remove(docId);
      newData = oldData;
    }
    postRef.doc(post.postId).update({
      'likes': newData,
    });
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
          GestureDetector(
            onDoubleTap: () {
              liked = !liked;
              changeLikeStatus(post, liked);
              setState(() {
                heartShow = true;
              });
              Timer(Duration(seconds: 1), () {
                setState(() {
                  heartShow = false;
                });
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.brown[300],
                  height: 0.4.hp,
                  child: Image.network(post.url),
                ),
                AnimatedCrossFade(
                  duration: Duration(seconds: 1),
                  firstChild: Icon(
                    Icons.favorite,
                    color: (liked) ? Colors.red : Colors.black,
                    size: 0.2.wp,
                  ),
                  secondChild: Icon(
                    Icons.favorite,
                    color: Colors.transparent,
                    size: 0.2.wp,
                  ),
                  crossFadeState: (heartShow) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(0.02.hp),
            child: Text("${post.likes.length} likes"),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
