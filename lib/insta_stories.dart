import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_profile.dart';

class InstaStories extends StatelessWidget {
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

  static List<String> images = [
    "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
    "https://cdn.rheinmetall-automotive.com/fileadmin//_migrated/news_uploads/11.1_KSPG_Dr._Alexander_Sagel_02.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg"
  ];

  final stories = Expanded(
    child: new Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  InstaProfile()),
                ),
            child: new Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                new Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(images[index])),
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
        },
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(3.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          topText,
          stories,
        ],
      ),
    );
  }
}
