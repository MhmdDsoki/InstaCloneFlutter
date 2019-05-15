import 'package:flutter/material.dart';

class FollowingPage extends StatefulWidget {
  @override
  InstaListState createState() {
    return new InstaListState();
  }
}

class InstaListState extends State<FollowingPage> {
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

  Widget row_with_images(int index) {
    return Container(
      color: Colors.grey[200],
      child: Row(children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
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
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "ifbbpro_andy",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " liked",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    Flexible(
                      child: Text(
                        "55s",
                        style: TextStyle(fontWeight: FontWeight.w200),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      child: SizedBox(
                        width:double.infinity,
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
//                              shrinkWrap: true,
//                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                    child: Container(
                                      width: 35.0,
                                      height: 35.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image:
                                                new NetworkImage(images[index])),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                    ),
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
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
        )
      ]),
    );
  }

  Widget row(int index) {
    if (index % 2 == 0)
      return Row(children: <Widget>[
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
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
        ]),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) =>
                index == 3 ? row_with_images(index) : row(index)));

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
