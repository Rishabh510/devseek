import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'DevSeek',
          style: TextStyle(color: Colors.blue, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Get your daily quote',
                  textAlign: TextAlign.center,
                ),
              ),
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
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: CircleAvatar(),
            title: Text('User Name'),
            subtitle: Text('Location'),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text('Image description'),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.black),
            ),
          ),
          Container(
            height: 300,
            color: Colors.brown[300],
          ),
        ],
      ),
    );
  }
}
