import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/profilepage/insta_profile_page.dart';
import 'package:flutter_insta_clone/util/SharedPrefsHelper.dart';
import 'package:flutter_insta_clone/util/authntication.dart';

class InstaProfileTaab extends StatefulWidget {
  InstaProfileTaab({this.userId, this.auth, this.onSignedOut});

  final String userId;
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _InstaProfileTaabState createState() => _InstaProfileTaabState();
}

class _InstaProfileTaabState extends State<InstaProfileTaab> {
  String currentUserEmail = "";
  String _userId = "";
  String _userEmail = "";
  String _imageUrl = "";
  String _defaultImageUrl = "";
  String _defaultFollowers = "";
  String _defaultFollowing = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          currentUserEmail = user?.email;
          _userId = user?.uid;
          _getDefaultImage();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: new Color(0xfff8faf8),
          centerTitle: true,
          elevation: 1.0,
          titleSpacing: 0.0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(currentUserEmail),
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
            GestureDetector(
              onTap: () {
                _signOut();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        body: new InstaProfilePage());
  }

  _signOut() async {
    try {
      SharedPreferencesHelper.setUserLoggedOut();
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  void getUsers() async {
    String defaultImageUrl = "";
    String defaultFollowers = "";
    String defaultFollowing = "";

    FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(_userId)
        .once()
        .then((DataSnapshot snapshot) {
      //here i iterate and create the list of objects
      Map<dynamic, dynamic> yearMap = snapshot.value;
      yearMap.forEach((key, value) {
        setState(() {
          defaultImageUrl = value['image'];
          defaultFollowers = value['followers'];
          defaultFollowing = value['following'];
        });
      });
      setState(() {
        _defaultImageUrl = defaultImageUrl;
        _defaultFollowers = defaultFollowers;
        _defaultFollowing = defaultFollowing;
      });
    });
  }

  void _getDefaultImage() {
    getUsers();
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
                                Stack(
                                  children: <Widget>[
                                    Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(
                                                    "https://agostini.com/wp-content/uploads/2018/09/pp.png")))),
                                    Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(
                                                    _defaultImageUrl)))),
                                  ],
                                ),
                                new SizedBox(
                                  width: 15,
                                ),
                                new Text(
                                  currentUserEmail,
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
                                child: OutlineButton.icon(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  onPressed: () {},
                                  icon: Container(
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          Text(_defaultFollowers),
                                        ],
                                      ),
                                    ),
                                  ),
                                  textColor: Colors.black,
                                  label: Text("Followers"),
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
