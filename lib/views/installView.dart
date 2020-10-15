import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstallView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset('images/logo.png'),
                ),
                Text(
                  'For the developers who seek',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            RaisedButton(
              color: Colors.blue.withOpacity(0.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
              onPressed: () {},
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
