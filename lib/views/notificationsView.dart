import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.symmetric(horizontal: BorderSide()),
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                Colors.orange,
                Colors.yellow,
              ]),
            ),
            child: ListTile(
              leading: CircleAvatar(),
              title: Text('bla bal abla has started following you'),
            ),
          ),
        ],
      ),
    );
  }
}
