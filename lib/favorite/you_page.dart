import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/insta_profile.dart';
import 'package:flutter_insta_clone/insta_stories.dart';
import 'package:flutter_insta_clone/models/PostObj.dart';
import 'package:flutter_insta_clone/util/Constans.dart';
import 'package:http/http.dart' as http;

class YouPage extends StatefulWidget {
  @override
  InstaListState createState() {
    return new InstaListState();
  }
}

class InstaListState extends State<YouPage> {
  static List<String> images = [
    "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
    "https://cdn.rheinmetall-automotive.com/fileadmin//_migrated/news_uploads/11.1_KSPG_Dr._Alexander_Sagel_02.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
    "https://cdn.rheinmetall-automotive.com/fileadmin//_migrated/news_uploads/11.1_KSPG_Dr._Alexander_Sagel_02.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
    "https://cdn.rheinmetall-automotive.com/fileadmin//_migrated/news_uploads/11.1_KSPG_Dr._Alexander_Sagel_02.jpg",
    "https://petrieflom.law.harvard.edu/images/made/82e033b5d85a88b0/Cohen2015_people_300_300_85.jpg",
  ];

  Widget row(int index) {
    if (index % 2 == 0)
      return Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 60,
            height: 60,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 45.0,
                    height: 45.0,
                    decoration: new BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 2, style: BorderStyle.solid),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill, image: new NetworkImage(images[index])),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 45.0,
                    height: 45.0,
                    decoration: new BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 2, style: BorderStyle.solid),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill, image: new NetworkImage(images[2])),
                    ),

                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "ifbbpro_andy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "liked 8 photos",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                Text(
                  "55s",
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topCenter,
            width: 35.0,
            height: 35.0,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              image: new DecorationImage(
                  fit: BoxFit.fill, image: new NetworkImage(images[0])),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
        ),
      ]);
    else
      return Container(
        color: Colors.grey[200],
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topCenter,
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill, image: new NetworkImage(images[index])),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "ifbbpro_andy",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "liked 8 photos",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "55s",
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              alignment: Alignment.topCenter,
              width: 35.0,
              height: 35.0,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                    fit: BoxFit.fill, image: new NetworkImage(images[0])),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
            ),
          ),
        ]),
      );
  }

  Widget text(int index) {
    if (index == 0)
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          "This Week",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          "This Month",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
          body: ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) =>
                  index == 0 || index == 3 ? text(index) : row(index))),
    );

//    return Scaffold(
//        body: ListView.builder(
//            itemCount: 6,
//            itemBuilder: (context, index) => index == 0
//                ? Container(
//                    child: Row(
//                  children: <Widget>[
//                    Container(
//                      width: 60.0,
//                      height: 60.0,
//                      decoration: new BoxDecoration(
//                        border: Border.all(
//                            color: Colors.blue,
//                            width: 2,
//                            style: BorderStyle.solid),
//                        shape: BoxShape.circle,
//                        image: new DecorationImage(
//                            fit: BoxFit.fill,
//                            image: new NetworkImage(images[0])),
//                      ),
//                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                    ),
//                    Column(
//                      children: <Widget>[
//                        Row(
//                          children: <Widget>[
//                            Text(
//                              "ifbbpro_andy",
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                            Text(
//                              "liked 8 photos",
//                              style:
//                                  TextStyle(fontWeight: FontWeight.normal),
//                            ),
//                            Text(
//                              "55s",
//                              style: TextStyle(fontWeight: FontWeight.w200),
//                            ),
//                          ],
//                        ),
//                        ListView.builder(
//                            itemCount: 5,
//                            itemBuilder: (context, index) => Container(
//                                  child: Container(
//                                    width: 60.0,
//                                    height: 60.0,
//                                    decoration: new BoxDecoration(
//                                      shape: BoxShape.rectangle,
//                                      image: new DecorationImage(
//                                          fit: BoxFit.fill,
//                                          image: new NetworkImage(
//                                              images[index])),
//                                    ),
//                                    margin: const EdgeInsets.symmetric(
//                                        horizontal: 8.0),
//                                  ),
//                                ))
//                      ],
//                    ),
//                  ],
//                ))
//                : Container(child: Text(",nbfcvgbhjnmkjhjghfg"))));
  }
}
