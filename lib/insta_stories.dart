import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'db/storyservice.dart';
import 'models/UserObj.dart';
import 'util/Constans.dart';

class InstaStories extends StatefulWidget {
  @override
  _InstaStoriesState createState() => _InstaStoriesState();
}

class _InstaStoriesState extends State<InstaStories> {
  static List<User> list = List();
  var isLoading = false;

//  static final databaseReference = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Constants.BASE_API_URL + Constants.users_URL);
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new User.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  _addStory() {
    User story = User(
        0,
        "abualgait@gmail.com",
        "post",
        "mo sayed",
        "https://avatars0.githubusercontent.com/u/38107393?s=460&v=4",
        "62",
        "15");

    StoryService storyService = StoryService(story.toMap(story));
    storyService.addStory();
  }

  final topText = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        "Stories",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      new Row(
        children: <Widget>[
          new Icon(Icons.play_arrow),
          new Text("Watch All", style: TextStyle(fontWeight: FontWeight.bold))
        ],
      )
    ],
  );

  static setImage(int index) {
    return GestureDetector(
      onTap: () => {},
      child: new Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          new Container(
            width: 60.0,
            height: 60.0,
            decoration: new BoxDecoration(
              border: Border.all(
                  color: Colors.blue, width: 2, style: BorderStyle.solid),
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill, image: new NetworkImage(list[index].image)),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          index == 0
              ? Positioned(
                  right: 10.0,
                  child: new CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    radius: 10.0,
                    child: new Icon(
                      Icons.add,
                      size: 14.0,
                      color: Colors.white,
                    ),
                  ))
              : new Container()
        ],
      ),
    );
  }

//  static void createRecord() {
//    databaseReference.child("1").set({
//      'title': 'Mastering EJB',
//      'description': 'Programming Guide for J2EE'
//    });
//    databaseReference.child("2").set({
//      'title': 'Flutter in Action',
//      'description': 'Complete Programming Guide to learn Flutter'
//    });
//  }

  final stories = Expanded(
    child: new Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return new GestureDetector(
              child: new Column(
            children: <Widget>[
              setImage(index),
            ],
          ));
        },
      ),
    ),
  );
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: topText,
                  ),
                  stories,
                ],
              ));
  }
}
