import 'package:devseek/services/quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool quoteLoaded = false;
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
                }
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
