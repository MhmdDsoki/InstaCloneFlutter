import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/favorite/insta_favorite.dart';
import 'package:flutter_insta_clone/insta_home.dart';
import 'package:flutter_insta_clone/profilepage/insta_profile_tab.dart';
import 'package:flutter_insta_clone/rootPage.dart';
import 'package:flutter_insta_clone/search/insta_search.dart';
import 'package:flutter_insta_clone/util/InstaColors.dart';
import 'package:flutter_insta_clone/util/authntication.dart';

import 'addpost/AddPost.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appName = 'Instagram';

    return new MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: true,
        theme: _buildThemeData(),
        home: new RootPage(auth: new Auth()));
  }
}

ThemeData _buildThemeData() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: primaryColor,
    accentColor: accentColor,
    canvasColor: Colors.transparent,
    textTheme: _buildTextTheme(base.textTheme, Colors.black),
    primaryIconTheme: IconThemeData(color: Colors.black),
    buttonTheme: _buildButtonTheme(base.buttonTheme, accentColor),
    primaryTextTheme: _buildTextTheme(base.textTheme, Colors.black),
  );
}

_buildButtonTheme(ButtonThemeData base, Color color) {
  return base.copyWith(
      buttonColor: color,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.5)),
      ));
}

_buildTextTheme(TextTheme base, Color color) {
  return base
      .copyWith(
        headline: base.headline.copyWith(),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(fontSize: 14.0),
      )
      .apply(fontFamily: 'Aveny', displayColor: color, bodyColor: color);
}

class InstaHomeState extends StatefulWidget {
  InstaHomeState({this.userId, this.auth, this.onSignedOut});

  final String userId;
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  State createState() => new _InstaHomeState();
}

class _InstaHomeState extends State<InstaHomeState> {
  List<Widget> _pages;
  Widget _selectedContent;
  int _bottomIndex;

  @override
  void initState() {
    _bottomIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _definePages();

    return Scaffold(
        body: _selectedContent ?? _pages[_bottomIndex],
        bottomNavigationBar: new Container(
          color: Colors.white,
          height: 50.0,
          alignment: Alignment.center,
          child: new BottomAppBar(
            child: new Row(
              // alignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  icon: Icon(
                    Icons.home,
                  ),
                  onPressed: () {
                    _onTabTapped(0);
                  },
                ),
                new IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    _onTabTapped(1);
                  },
                ),
                new IconButton(
                  icon: Icon(
                    Icons.add_box,
                  ),
                  onPressed: () {
                    _onTabTapped(2);
                  },
                ),
                new IconButton(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  onPressed: () {
                    _onTabTapped(3);
                  },
                ),
                new IconButton(
                  icon: Icon(
                    Icons.account_box,
                  ),
                  onPressed: () {
                    _onTabTapped(4);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  _definePages() {
    _pages = [
      InstaHome(),
      InstaSearch(),
      InstaAddPost(),
      InstaFavorite(),
      InstaProfileTaab(
          userId: widget.userId,
          auth: widget.auth,
          onSignedOut: widget.onSignedOut),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _bottomIndex = index;
      _selectedContent = _pages[index];
    });
  }
}
