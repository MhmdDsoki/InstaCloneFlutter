import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_insta_clone/util/authntication.dart';

class PostService {
  String nodeName = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map post;
  Auth auth;

  PostService(this.post) {
    _databaseReference = database.reference();
    auth = new Auth();
  }

  addPost() {
    _databaseReference.child(nodeName).push().set(post);
  }

  deletePost() {
    _databaseReference.child('$nodeName/${post['key']}').remove();
  }

  updatePost() {
    _databaseReference.child('$nodeName/${post['key']}').update(
        {"title": post['title'], "body": post['body'], "date": post['date']});
  }
}
