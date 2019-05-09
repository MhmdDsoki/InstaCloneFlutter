import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_list.dart';
import 'package:flutter_insta_clone/insta_stories.dart';
import 'package:flutter_insta_clone/search/insta_list_search.dart';

class InstaSearhContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //InstaList()
        // Expanded(flex: 1, child: new InstaStories()),
        Flexible(child: InstaListSearch())
      ],
    );
  }
}
