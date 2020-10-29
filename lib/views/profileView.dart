import 'dart:ui';
import 'package:devseek/constants.dart';
import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text('Posts'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text('Followers'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text('Following'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        OutlineButton(
                          onPressed: () {},
                          child: Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DevSeek ID'),
                    Text(
                      'DevSeek User Name',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      'DevSeek Bio',
                      style: TextStyle(fontSize: 20),
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
            padding: EdgeInsets.all(4),
            width: double.infinity,
            height: 250,
            child: posts[i],
          );
        },
      ),
    );
  }
}
