import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String token = '';

  @override
  void initState() {
    super.initState();
    fcmInitialize();
  }

  Future<void> fcmInitialize() async {
    token = await messaging.getToken();
    print(token);
  }

  Widget buildNotification(String label, String sub) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide()),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
          Colors.orange,
          Colors.yellow,
        ]),
      ),
      child: ListTile(
        leading: CircleAvatar(),
        title: Text(
          label,
          style: TextStyle(fontSize: 40.sp),
        ),
        subtitle: Text(
          sub,
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.w),
        children: [
          StreamBuilder(
            stream: FirebaseMessaging.onMessage,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
              RemoteMessage message = snapshot.data;
              return buildNotification(message.notification.title, message.notification.body);
            },
          ),
        ],
      ),
    );
  }
}
