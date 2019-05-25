import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_profile.dart';
import 'package:flutter_insta_clone/insta_stories.dart';
import 'package:flutter_insta_clone/models/PostObj.dart';
import 'package:flutter_insta_clone/util/authntication.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

import 'util/Constans.dart';

class InstaList extends StatefulWidget {
  @override
  InstaListState createState() {
    return new InstaListState();
  }
}

class InstaListState extends State<InstaList> {
  static List<postObj> list = List();
  var isLoading = false;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "posts";
  List<postObj> postsList = <postObj>[];

  final BaseAuth auth = new Auth();
  String _userId = "";
  String _userEmail = "";
  String _defaultImageUrl = "";

  _childAdded(Event event) {
    setState(() {
      postsList.add(postObj.fromSnapshot(event.snapshot));
    });
  }

  @override
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    super.initState();
    auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          _userEmail = user?.email;
          getUsers();
        }
      });
    });
  }

  void getUsers() async {
    String defaultImageUrl = "";

    FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(_userId)
        .once()
        .then((DataSnapshot snapshot) {
      //here i iterate and create the list of objects
      Map<dynamic, dynamic> yearMap = snapshot.value;
      yearMap.forEach((key, value) {
        setState(() {
          defaultImageUrl = value['image'];
        });
      });
      setState(() {
        _defaultImageUrl = defaultImageUrl;
      });
    });
  }

  Widget _getPosts(Size deviceSize) {
    return FirebaseAnimatedList(
        query: _database.reference().child('posts'),
        itemBuilder:
            (_, DataSnapshot snap, Animation<double> animation, int index) {
          return index == 0
              ? new SizedBox(
                  child: new InstaStories(),
                  height: deviceSize.height * 0.15,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                child: new Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            postsList[index - 1]
                                                .creator_image)),
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InstaProfile(
                                              postsList[index - 1].creator_name,
                                              postsList[index - 1]
                                                  .creator_image)),
                                    ),
                              ),
                              new SizedBox(
                                width: 10.0,
                              ),
                              new Text(
                                postsList[index - 1].creator_name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          new IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: null,
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: new Image.network(
                        postsList[index - 1].post_image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Icon(
                                Icons.favorite,
                              ),
                              new SizedBox(
                                width: 16.0,
                              ),
                              new Icon(
                                Icons.comment,
                              ),
                              new SizedBox(
                                width: 16.0,
                              ),
                              new Icon(Icons.send),
                            ],
                          ),
                          new Icon(Icons.bookmark)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Text(postsList[index - 1].post_caption),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Text("Liked by "),
                          Row(children: liked_by(postsList[index - 1].liked_by))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(_defaultImageUrl)),
                            ),
                          ),
                          new SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: new TextField(
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Add a comment...",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                          timeago.format(DateTime.fromMillisecondsSinceEpoch(
                              postsList[index - 1].post_time)),
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[

                          Icon(Icons.location_on),
                          SizedBox(
                            width: 15,
                          ),
                          Text(postsList[index - 1].post_location,
                              style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    )
                  ],
                );
        });
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Constants.BASE_API_URL + Constants.posts_URL);
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new postObj.fromJson(data))
          .toList();

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        body: postsList.isEmpty
            ? Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              )
            : _getPosts(deviceSize));
  }

  List<Widget> liked_by(List<String> list) {
    List<Widget> arr = new List();
    for (int i = 0; i < list.length; i++) {
      arr.add(new Text(
        list[i] + ", ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
    }

    return arr;
  }
}
