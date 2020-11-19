import 'package:devseek/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountView extends StatefulWidget {
  @override
  _CreateAccountViewState createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final _formKey = GlobalKey<FormState>();
  String _username, _bio;

  void saveAccount() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pop(context, [_username, _bio]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'User Name',
                  style: TextStyle(fontSize: 50.sp),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your username',
                  ),
                  validator: (val) {
                    if (val.isEmpty || val.length < 6) {
                      return "Please enter username with minimum 6 characters";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      _username = val;
                    });
                  },
                ),
                SizedBox(height: 40.h),
                Text(
                  'About',
                  style: TextStyle(fontSize: 50.sp),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter new bio',
                  ),
                  maxLines: 5,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please do not leave this field empty";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      _bio = val;
                    });
                  },
                ),
                SizedBox(height: 40.h),
                RaisedButton(
                  color: Colors.green,
                  child: Text('Continue'),
                  onPressed: () {
                    saveAccount();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
