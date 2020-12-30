import 'package:devseek/views/homeView.dart';
import 'package:devseek/views/notificationsView.dart';
import 'package:devseek/views/postView.dart';
import 'package:devseek/views/profileView.dart';
import 'package:devseek/views/searchView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TabDeciderView extends StatefulWidget {
  final User currentUser;

  const TabDeciderView({Key key, this.currentUser}) : super(key: key);

  @override
  _TabDeciderViewState createState() => _TabDeciderViewState();
}

class _TabDeciderViewState extends State<TabDeciderView> {
  int currIndex = 0;
  User myUser;
  List<Widget> screens;

  @override
  void initState() {
    screens = [
      HomeView(),
      SearchView(
        currentUser: widget.currentUser,
      ),
      PostView(
        currentUser: widget.currentUser,
      ),
      NotificationsView(),
      ProfileView(currentUser: widget.currentUser),
    ];
    super.initState();
  }

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
          buildBottomNavigationBarItem(Icons.home, 'Home'),
          buildBottomNavigationBarItem(Icons.search, 'Search'),
          buildBottomNavigationBarItem(Icons.add_circle_outline, 'New'),
          buildBottomNavigationBarItem(Icons.favorite, 'Notif'),
          buildBottomNavigationBarItem(Icons.account_circle, 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      label: label,
    );
  }
}
