import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devseek/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatefulWidget {
  final User currentUser;

  const SearchView({Key key, this.currentUser}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool searched = false;

  Future<List<UserModel>> getSearchResults() async {
    CollectionReference colRef = firestore.collection('users');
    QuerySnapshot snap = await colRef.where("profilename", isGreaterThanOrEqualTo: _textEditingController.text).get();
    List<UserModel> myList = [];
    snap.docs.forEach((element) {
      myList.add(UserModel.fromDocument(element));
    });
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
          onSubmitted: (str) {
            setState(() {
              searched = true;
            });
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _textEditingController.clear();
                });
              }),
        ],
      ),
      body: (searched)
          ? FutureBuilder<List<UserModel>>(
              future: getSearchResults(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return buildListTile(snapshot.data[i].profilename, snapshot.data[i].username);
                    },
                    shrinkWrap: true,
                  );
                }
                return Text('No search results');
              },
            )
          : Text("Type in the search bar to start searching... "),
    );
  }

  Container buildListTile(String profilename, String username) {
    return Container(
      color: Colors.green[200],
      margin: EdgeInsets.all(16.w),
      child: ListTile(
        leading: CircleAvatar(),
        title: Text(
          profilename,
          style: TextStyle(fontSize: 40.sp),
        ),
        subtitle: Text(
          username,
          style: TextStyle(fontSize: 40.sp),
        ),
      ),
    );
  }
}
