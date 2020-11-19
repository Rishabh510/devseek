import 'package:devseek/views/createAccountView.dart';
import 'package:devseek/views/editProfileView.dart';
import 'package:devseek/views/homeView.dart';
import 'package:devseek/views/installView.dart';
import 'package:devseek/views/tabDeciderView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ScreenUtil.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevSeek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InstallView(),
    );
  }
}
