import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/db/postservice.dart';
import 'package:flutter_insta_clone/models/PostObj.dart';

class InstaAddPost extends StatefulWidget {
  @override
  _InstaAddPostState createState() => _InstaAddPostState();
}

class _InstaAddPostState extends State<InstaAddPost> {
  var _locationController;
  var _captionController;

  String nodeName = "posts";
  List<postObj> postsList = <postObj>[];

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _captionController = TextEditingController();
  }

  bool _visibility = true;

  void _changeVisibility(bool visibility) {
    setState(() {
      _visibility = visibility;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _locationController?.dispose();
    _captionController?.dispose();
  }

  void insertPost() {
    postObj post = postObj(
      0,
      "mohamed sayed abu",
      "https://avatars0.githubusercontent.com/u/38107393?s=460&v=4",
      "https://avatars0.githubusercontent.com/u/38107393?s=460&v=4",
      ["ahmed", "mo351hamed", "ali6486", "kgysldbas"],
      _captionController.text.toString(),
    );
    PostService postService = PostService(post.toMap());
    postService.addPost();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: new Color(0xfff8faf8),
          centerTitle: true,
          elevation: 1.0,
          leading: new Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          title: SizedBox(
              child: Text("New Post", style: TextStyle(color: Colors.black))),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  onTap: () {
                    _changeVisibility(false);
                    insertPost();
                  },
                  child: Text(
                    "Share",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/placeholder.png")),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 100.0,
                      child: TextField(
                          controller: _captionController,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Add location',
                          ),
                          onChanged: ((value) {
                            setState(() {
                              //   _captionController.text = value;
                            });
                          })),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                    controller: _locationController,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Add location',
                    ),
                    onChanged: ((value) {
                      setState(() {
                        // _locationController.text = value;
                      });
                    })),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Offstage(
                  child: CircularProgressIndicator(),
                  offstage: _visibility,
                ),
              )
            ],
          ),
        ));
  }
}
