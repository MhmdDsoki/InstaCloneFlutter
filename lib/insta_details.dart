import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/_grid_screen.dart';
import 'package:flutter_insta_clone/InstaStoriesInDetails.dart';
import 'package:flutter_insta_clone/insta_list.dart';
import 'package:flutter_insta_clone/insta_stories.dart';

class InstaDetails extends StatelessWidget {
  static double _value = 0.5;

  static final textContainer = new Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new Row(
        children: <Widget>[
          Text(
            "M.Sayed",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
      new SizedBox(
        height: 15.0,
      ),
      new Row(
        children: <Widget>[
          Text(
            "Global Citizen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Image.asset("assets/images/earth.png")
        ],
      ),
      new Row(
        children: <Widget>[
          Text(
            "http://abc.com",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Image.asset("assets/images/earth.png")
        ],
      ),
      new SizedBox(
        height: 15.0,
      ),
      new Row(
        children: <Widget>[
          Text(
            "1,200 ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Followers",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          Text(
            "380 ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Following",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
      new Row(
        children: <Widget>[
          Text(
            "Followed by sadjskn and lkdjsan",
            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
          )
        ],
      ),
    ],
  );

  static final imageContainer = new Column(
    children: <Widget>[
      Center(
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(
                    "https://cdn.pixabay.com/photo/2016/03/09/15/10/man-1246508_960_720.jpg")),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
      )
    ],
  );

  final topView = Column(
    children: <Widget>[
      new Container(
        child: new Row(
          children: <Widget>[
            textContainer,
            Expanded(
              child: imageContainer,
            )
          ],
        ),
        padding: EdgeInsets.all(7.0),
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(5.0),
            child: RaisedButton(
              onPressed: () {},
              child: Text("Follow"),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          )),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: OutlineButton(
                      onPressed: () {},
                      child: Text("Message"),
                      color: Colors.black12,
                      textColor: Colors.black,
                      disabledTextColor: Colors.transparent,
                      highlightedBorderColor: Colors.blue,
                      highlightColor: Colors.transparent)))
        ],
      ),
      InstaStoriesInDetails(),
      Slider(
        value: _value,
        onChanged: (double newValue) {
          _value = newValue;
        },
      ),
      new Container(
        margin: const EdgeInsets.all(0.0),
        height: 220,
        child: MyTabsPage(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        topView,
      ]),
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
        length: 4,
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
                      new Tab(text: "Grid"),
                      new Tab(text: "Posts"),
                      new Tab(text: "IGTV"),
                      new Tab(text: "Tagged"),
                    ],
                    indicatorColor: Colors.white,
                  )
                ],
              )),
          body: new TabBarView(
            children: [
              FirstScreen(),
              new Icon(
                Icons.directions_transit,
                size: 50.0,
              ),
              new Icon(
                Icons.directions_bike,
                size: 50.0,
              ),
              new Icon(
                Icons.directions_bike,
                size: 50.0,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
