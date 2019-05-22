import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/_grid_screen.dart';
import 'package:flutter_insta_clone/db/userservice.dart';
import 'package:flutter_insta_clone/favorite/following_page.dart';
import 'package:flutter_insta_clone/favorite/you_page.dart';
import 'package:flutter_insta_clone/insta_body.dart';
import 'package:flutter_insta_clone/insta_details_silvers.dart';
import 'package:flutter_insta_clone/models/UserObj.dart';
import 'package:flutter_insta_clone/search/insta_search_content.dart';
import 'package:flutter_insta_clone/util/authntication.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InstaProfilePage extends StatefulWidget {
  InstaProfilePage({this.auth});

  final BaseAuth auth;

  @override
  _InstaProfilePageState createState() => _InstaProfilePageState();
}

class _InstaProfilePageState extends State<InstaProfilePage> {
  static String currentUserEmail = "";
  Future<File> imageFile;
  FirebaseStorage _storage = FirebaseStorage.instance;

  final BaseAuth auth = new Auth();
  String _userId = "";
  String _userEmail = "";
  String _imageUrl = "";

  @override
  void initState() {
    super.initState();

    auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          _userEmail = user?.email;
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverPadding(
                padding: new EdgeInsets.all(8.0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate([
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Stack(
                                        children: <Widget>[
                                          Container(
                                              width: 95.0,
                                              height: 95.0,
                                              decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: new NetworkImage(
                                                          "https://avatars0.githubusercontent.com/u/38107393?s=460&v=4")))),
                                              Container(
                                              width: 95.0,
                                              height: 95.0,
                                              child: showImage(),),
                                             Positioned(
                                              right: 5.0,
                                              bottom: 5.0,
                                              child: GestureDetector(
                                                onTap: () => {_chooseProfileImage('Gallery')},
                                                child: new CircleAvatar(
                                                  backgroundColor:
                                                      Colors.blueAccent,
                                                  radius: 10.0,
                                                  child: new Icon(
                                                    Icons.add,
                                                    size: 14.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                      new SizedBox(
                                        height: 15.0,
                                      ),
                                      new Text(
                                        "muhammad sayed",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "34",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Posts",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "313",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Followers",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "391",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Following",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Expanded(
                                            child: OutlineButton(
                                              onPressed: () {},
                                              child: Text("Edit Profile"),
                                              textColor: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
              new SliverPadding(
                padding: new EdgeInsets.all(8.0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate([
                    TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        new Tab(icon: new Icon(Icons.grid_on)),
                        new Tab(
                          icon: new Icon(Icons.list),
                        ),
                        new Tab(
                          icon: new Icon(Icons.person_pin),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: <Widget>[
              FirstScreen(),
              FirstScreen(),
              FirstScreen(),
            ],
          ),
        ),
      ),
    );
  }
_uploadImage(){
  _saveImage().then((imageurl) {
    setState(() {
      if (imageurl != null) {
        _imageUrl = imageurl;

        User user = User(
          _userId,
          "name",
          _userEmail,
          _imageUrl,
          "0",
          "0",
          "posts",
        );
        UserService postService = UserService(user.toMap(user),_userId);
        postService.addUser();
        //   _changeVisibility(true);
      }
    });
  });
}
  _chooseProfileImage(String action) {
    action == 'Gallery'
        ? setState(() {
            imageFile = ImagePicker.pickImage(source: ImageSource.gallery);

          })
        : setState(() {
            imageFile = ImagePicker.pickImage(source: ImageSource.camera);
          });
  }
  Future<String> _saveImage() async {
    //var rng = new Random();
    StorageReference reference = _storage.ref().child("users").child(_userId);
    StorageUploadTask uploadTask = reference.putFile(await imageFile);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {


          return Image.file(
            snapshot.data,
            width: 95,
            height: 95,

          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
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
