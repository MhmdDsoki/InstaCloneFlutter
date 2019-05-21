import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_insta_clone/util/authntication.dart';

class StoryService {
  String nodeName = "stories";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map story;

  StoryService(this.story) {
    _databaseReference = database.reference();
  }

  addStory() {
    _databaseReference.child(nodeName).push().set(story);
    //this is going to give a reference to the posts node
  }

//  deleteStory() {
//    _databaseReference.child('$nodeName/${story['key']}').remove();
//  }
//
//  updateStory() {
//    _databaseReference.child('$nodeName/${story['key']}').update(
//        {"title": story['title'], "body": story['body'], "date": story['date']});
//  }
}
