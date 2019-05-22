import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_insta_clone/util/authntication.dart';

class UserService {
  String nodeName = "users";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map user;
  String userid;

  UserService(this.user, this.userid) {
    _databaseReference = database.reference();
  }

  addUser() {
    _databaseReference.child(nodeName).child(userid).push().set(user);
  }

//  deletePost() {
//    _databaseReference.child('$nodeName/${post['key']}').remove();
//  }
//
//  updatePost() {
//    _databaseReference.child('$nodeName/${post['key']}').update(
//        {"title": post['title'], "body": post['body'], "date": post['date']});
//  }
}
