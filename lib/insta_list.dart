import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_profile.dart';
import 'package:flutter_insta_clone/insta_stories.dart';
import 'package:flutter_insta_clone/models/PostObj.dart';
import 'package:http/http.dart' as http;
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
//    const _baseColors = <ColorSwatch>[
//      ColorSwatch(0xffffffff, {'color1': Color(0xFFFFFFF),'color2': Color(0xFFFFFFF)})
//    ];
//   var _color = _baseColors[0];
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length + 1,
                itemBuilder: (context, index) => index == 0
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
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 16.0, 8.0, 16.0),
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
                                                  list[index - 1].creator_image)),
                                        ),
                                      ),onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          InstaProfile( list[index-1].creator_name,list[index-1].creator_image)),
                                    ),
                                    ),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    new Text(

                                      list[index - 1].creator_name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                              list[index - 1].post_image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: <Widget>[
                                Text("Liked by "),
                                Row(
                                    children:
                                        liked_by(list[index - 1].liked_by))
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
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
                                        image: new NetworkImage(
                                            list[index - 1].creator_image)),
                                  ),
                                ),
                                new SizedBox(
                                  width: 10.0,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(list[index - 1].post_time,
                                style: TextStyle(color: Colors.grey)),
                          )
                        ],
                      ),
        ));
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
