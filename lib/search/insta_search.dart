import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_body.dart';
import 'package:flutter_insta_clone/search/insta_search_content.dart';

class InstaSearch extends StatelessWidget {
  final topBar = new AppBar(
    backgroundColor: new Color(0xfff8faf8),
    centerTitle: true,
    elevation: 1.0,
    leading: new Icon(Icons.search),
    title: SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: new TextField(
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            labelText: "Search",
          ),
          textInputAction: TextInputAction.search,
//          decoration: InputDecoration(
//            filled: true,
//            border: InputBorder.none,
//            hintText: 'Search',
//          ),
        ),
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(Icons.whatshot),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: topBar, body: new InstaSearhContent());
  }
}
