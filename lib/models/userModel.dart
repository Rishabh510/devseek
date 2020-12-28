import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String username;
  final String profilename;
  String bio;
  final String url;
  final String email;

  UserModel(this.id, this.username, this.profilename, this.bio, this.url, this.email);

  factory UserModel.fromDocument(QueryDocumentSnapshot docsnap) {
    return UserModel(
      docsnap.data()['id'],
      docsnap.data()['username'],
      docsnap.data()['profilename'],
      docsnap.data()['bio'],
      docsnap.data()['photo'],
      docsnap.data()['email'],
    );
  }
}
