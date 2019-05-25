import 'package:firebase_database/firebase_database.dart';

class postObj {
  int id;
  String key;
  String creator_name;
  String creator_image;
  String post_image;
  List<String> liked_by;
  int post_time;
  String post_caption;
  String post_location;

  postObj(
    this.id,
    this.creator_name,
    this.creator_image,
    this.post_image,
    this.liked_by,
    this.post_time,
    this.post_caption,
    this.post_location,
  );

  postObj._({
    this.id,
    this.creator_name,
    this.creator_image,
    this.post_image,
    this.liked_by,
    this.post_time,
    this.post_caption,
    this.post_location,
  });

  factory postObj.fromJson(Map<String, dynamic> json) {
    return new postObj._(
        id: json['id'],
        creator_name: json['creator_name'],
        creator_image: json['creator_image'],
        post_image: json['post_image'],
        post_time: json['post_time'],
        post_caption: json['post_caption'],
        post_location: json['post_location'],
        liked_by: (json['liked_by'] as List).map((map) => "$map").toList());
  }

  postObj.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key,
        this.creator_name = snap.value["creator_name"],
        this.creator_image = snap.value["creator_image"],
        this.post_time = snap.value["post_time"],
        this.post_caption = snap.value["post_caption"],
        this.post_location = snap.value["post_location"],
        this.liked_by = List.from(snap.value['liked_by']),
        this.post_image = snap.value["post_image"];

  Map toMap() {
    return {
      "id": id,
      "creator_name": creator_name,
      "creator_image": creator_image,
      "post_image": post_image,
      "post_time": post_time,
      "post_caption": post_caption,
      "post_location": post_location,
      "liked_by": liked_by,
    };
  }
}
