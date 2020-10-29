import 'package:devseek/constants.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        title: Text('Edit Profile'),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: blue,
                ),
                height: 140,
              ),
              SizedBox(height: 20),
              Text('Profile Name'),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter new profile name',
                ),
              ),
              SizedBox(height: 20),
              Text('About'),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter new description',
                ),
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
