import 'package:devseek/views/homeView.dart';
import 'package:devseek/views/notificationsView.dart';
import 'package:devseek/views/postView.dart';
import 'package:devseek/views/profileView.dart';
import 'package:devseek/views/searchView.dart';
import 'package:flutter/material.dart';

class TabDeciderView extends StatefulWidget {
  @override
  _TabDeciderViewState createState() => _TabDeciderViewState();
}

class _TabDeciderViewState extends State<TabDeciderView> {
  int currIndex = 0;
  List<Widget> screens = [
    HomeView(),
    SearchView(),
    PostView(),
    NotificationsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currIndex,
        onTap: (idx) {
          setState(() {
            currIndex = idx;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            label: 'Notif',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
