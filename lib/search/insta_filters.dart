import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_profile.dart';

class InstaFilters extends StatelessWidget {
  static List<String> texts = [
    "TV & Movies",
    "Style",
    "Auto",
    "Shopping",
    "Beuty",
    "Travel",
    "Nature",
    "Science",
    "Tech",
    "Comics",
  ];

  final tags = Expanded(
    child: new Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstaProfile()),
                ),
            child:
                new Stack(alignment: Alignment.bottomRight, children: <Widget>[
              new Container(
                height: 30.0,
                child: OutlineButton(
                  textColor: Colors.black,
                  child: Text(texts[index]), onPressed: () {},
                ),

                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ]),
          );
        },
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(3.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          tags,
        ],
      ),
    );
  }
}
