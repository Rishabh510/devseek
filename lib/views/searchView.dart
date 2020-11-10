import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatefulWidget {
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
      body: ListView(
        children: [
          buildListTile(),
          buildListTile(),
          buildListTile(),
          buildListTile(),
          buildListTile(),
        ],
        shrinkWrap: true,
      ),
    );
  }

  Container buildListTile() {
    return Container(
      color: Colors.green[200],
      margin: EdgeInsets.all(16.w),
      child: ListTile(
        leading: CircleAvatar(),
        title: Text(
          'User Name',
          style: TextStyle(fontSize: 40.sp),
        ),
        subtitle: Text(
          'user id',
          style: TextStyle(fontSize: 40.sp),
        ),
      ),
    );
  }
}
