import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_profile.dart';
import 'package:flutter_insta_clone/insta_stories.dart';
import 'package:flutter_insta_clone/models/PostObj.dart';
import 'package:flutter_insta_clone/models/TagObj.dart';
import 'package:flutter_insta_clone/util/Constans.dart';
import 'package:http/http.dart' as http;

class InstaFilters extends StatefulWidget {
//  static List<String> texts = [
//    "TV & Movies",
//    "Style",
//    "Auto",
//    "Shopping",
//    "Beuty",
//    "Travel",
//    "Nature",
//    "Science",
//    "Tech",
//    "Comics",
//  ];

  @override
  InstaFiltersState createState() {
    return new InstaFiltersState();
  }
}

class InstaFiltersState extends State<InstaFilters> {
  static List<tagObj> list = List();
  var isLoading = false;
  bool isSelected;
  var cur_inx;

  @override
  void initState() {
    super.initState();
    _fetchData();
    isSelected = false;
    cur_inx = 0;
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Constants.BASE_API_URL + Constants.filter_URL);
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new tagObj.fromJson(data))
          .toList();
//      Scaffold.of(context).showSnackBar(new SnackBar(
//        content: new Text(list[2].tag_name),
//      ));
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

//  final tags = new Expanded(
//    child: Center(
//      child: new Padding(
//        padding: const EdgeInsets.only(top: 2.0),
//        child: new ListView.builder(
//          scrollDirection: Axis.horizontal,
//          itemCount: list.length,
//          itemBuilder: (context, index) {
//            return new GestureDetector(
//              child: new Stack(
//                  alignment: Alignment.bottomRight,
//                  children: <Widget>[
//                    new Container(
//                      child: OutlineButton(
//                        textColor: Colors.black,
//                        child: Text(list[index].tag_name),
//                        onPressed: () {},
//                      ),
//                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                    ),
//                  ]),
//            );
//          },
//        ),
//      ),
//    ),
//  );

  @override
  Widget build(BuildContext context) {
    Color _myColor = Colors.white;

    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.all(3.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: new Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new ListTileItem(
                                title: list[index].tag_name,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}

class ListTileItem extends StatefulWidget {
  String title;

  ListTileItem({this.title});

  @override
  _ListTileItemState createState() => new _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  @override
  void initState() {
    super.initState();

    isSelected = false;
  }

  bool isSelected;
  int _itemCount = 0;

//&& index == cur_inx
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: RaisedButton(
        textColor: isSelected ? Colors.white : Colors.black,
        child: Text(widget.title),
        color: isSelected ? Colors.blue : Colors.white,
        onPressed: () {
          if (isSelected) {
            setState(() {
              isSelected = false;
            });
          } else {
            setState(() {
              isSelected = true;
            });
          }
        },
      ),
    );
  }
}
