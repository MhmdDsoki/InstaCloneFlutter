import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/favorite/following_page.dart';
import 'package:flutter_insta_clone/favorite/you_page.dart';
import 'package:flutter_insta_clone/insta_body.dart';
import 'package:flutter_insta_clone/search/insta_search_content.dart';

class InstaFavorite extends StatelessWidget {
  final topBar = new AppBar(
      backgroundColor: new Color(0xfff8faf8),
      centerTitle: true,
      elevation: 1.0,
      titleSpacing: 0.0,
      flexibleSpace: new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new TabBar(
            tabs: [
              new Tab(text: "FOLLOWING"),
              new Tab(text: "YOU"),
            ],
            indicatorColor: Colors.black,
          )
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          primaryIconTheme: IconThemeData(color: Colors.black),
          primaryTextTheme: TextTheme(
              title: TextStyle(color: Colors.blue, fontFamily: "Aveny")),
          textTheme: TextTheme(title: TextStyle(color: Colors.grey))),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "FOLLOWING"),
                Tab(text: "YOU"),
              ],
              indicatorColor: Colors.black,
            ),
          ),
          body: TabBarView(
            children: [
              FollowingPage(),
              YouPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          primaryIconTheme: IconThemeData(color: Colors.black),
          primaryTextTheme: TextTheme(
              title: TextStyle(color: Colors.blue, fontFamily: "Aveny")),
          textTheme: TextTheme(title: TextStyle(color: Colors.grey))),
      home: new Scaffold(
          body: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
              titleSpacing: 0.0,
              flexibleSpace: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new TabBar(
                    tabs: [
                      new Tab(text: "FOLLOWING"),
                      new Tab(text: "YOU"),
                    ],
                    indicatorColor: Colors.black,
                  )
                ],
              )),
          body: new TabBarView(
            children: [
              FollowingPage(),
              FollowingPage(),
            ],
          ),
        ),
      )),
    );
  }
}
