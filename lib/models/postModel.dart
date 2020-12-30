import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String ownerId;
  final String username;
  final String description;
  final String location;
  final String url;
  List<String> likes;

  PostModel(this.postId, this.ownerId, this.username, this.description, this.location, this.url, this.likes);

  factory PostModel.fromDocument(DocumentSnapshot docsnap) {
    return PostModel(
      docsnap.data()['postId'],
      docsnap.data()['ownerId'],
      docsnap.data()['username'],
      docsnap.data()['description'],
      docsnap.data()['location'],
      docsnap.data()['url'],
      docsnap.data()['likes'],
    );
  }
}
