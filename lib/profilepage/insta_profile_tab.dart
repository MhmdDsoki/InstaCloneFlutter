import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/favorite/following_page.dart';
import 'package:flutter_insta_clone/favorite/you_page.dart';
import 'package:flutter_insta_clone/insta_body.dart';
import 'package:flutter_insta_clone/profilepage/insta_profile_page.dart';
import 'package:flutter_insta_clone/search/insta_search_content.dart';

class InstaProfileTaab extends StatelessWidget {
  Widget topBar(BuildContext context) {
    return new AppBar(
      backgroundColor: new Color(0xfff8faf8),
      centerTitle: true,
      elevation: 1.0,
      titleSpacing: 0.0,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text("mohamedsayed"),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              onPressed: () {
                _settingModalBottomSheet(context);
              },
            )
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.history),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.menu),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: topBar(context), body: new InstaProfilePage());
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return new Container(
              color: Colors.transparent,
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0))),
                child: new Container(
                  child: new Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: new Container(
                            width: 40.0,
                            height: 3.0,
                            decoration: new BoxDecoration(
                                border:
                                    Border.all(width: 1.0, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                shape: BoxShape.rectangle,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(
                                                "https://avatars0.githubusercontent.com/u/38107393?s=460&v=4")))),
                                new SizedBox(
                                  width: 15,
                                ),
                                new Text(
                                  "Muhammad Sayed",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            new CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              radius: 10.0,
                              child: new Icon(
                                Icons.check,
                                size: 14.0,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlineButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  onPressed: () {},
                                  child: Text("313 Followers"),
                                  textColor: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlineButton(
                                  onPressed: () {},
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  child: Text("0 Close freinds"),
                                  textColor: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        height: 60,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.add),
                            ),
                            new Text(
                              "Add Acccount",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
