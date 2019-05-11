import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_profile.dart';
import 'package:http/http.dart' as http;

import 'models/UserObj.dart';
import 'util/Constans.dart';

class InstaStories extends StatefulWidget {
//  static List<String> images = [
//    "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg",
//    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
//    "https://cdn.rheinmetall-automotive.com/fileadmin//_migrated/news_uploads/11.1_KSPG_Dr._Alexander_Sagel_02.jpg",
//    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
//    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg"
//  ];

  @override
  _InstaStoriesState createState() => _InstaStoriesState();
}

class _InstaStoriesState extends State<InstaStories> {
  static List<userObj> list = List();
  var isLoading = false;

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
          .map((data) => new userObj.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
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
    return new Stack(
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
    );
  }
  final stories = Expanded(
    child: new Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return new GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InstaProfile()),
              ),
              child: new Column(
                children: <Widget>[
                  setImage(index),

                ],
              ));
        },
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
