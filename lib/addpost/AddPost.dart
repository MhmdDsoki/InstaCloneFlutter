import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/db/postservice.dart';
import 'package:flutter_insta_clone/models/PostObj.dart';
import 'package:flutter_insta_clone/util/authntication.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:location/location.dart';

class InstaAddPost extends StatefulWidget {
  @override
  _InstaAddPostState createState() => _InstaAddPostState();
}

class _InstaAddPostState extends State<InstaAddPost> {
  var _locationController;
  var _captionController;
  Future<File> imageFile;
  String nodeName = "posts";
  List<postObj> postsList = <postObj>[];
  FirebaseStorage _storage = FirebaseStorage.instance;
  final BaseAuth auth = new Auth();
  String _userId = "";
  String _userEmail = "";
  String _imageUrl = "";
  int _time = 0;
  String _defaultImageUrl = "";
  String _defaultFollowers = "";
  //var location = new Location();
  Map<String, double> currentLocation;
  String _lat, _long;

  //Position currentLocation1;

//  Future<Map<String, double>> _getLocation() async {
//    return await location.getLocation();
//  }
//
//  Future<Position> locateUser() async {
//    return Geolocator()
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//  }

//  getUserLocation() async {
//    currentLocation1 = await locateUser();
//    setState(() {
//      _lat = currentLocation1.latitude as String;
//      _long = currentLocation1.longitude as String;
//    });
//  }

  @override
  void initState() {
    super.initState();
//    getUserLocation();
//    _getLocation().then((onValue) {
//      setState(() {
//        currentLocation = onValue;
//      });
//    });
//
    _time = DateTime.now().millisecondsSinceEpoch;
    _locationController = TextEditingController();
    _captionController = TextEditingController();
    auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          _userEmail = user?.email;
          getUsers();
        }
      });
    });
  }

  void getUsers() async {
    String defaultImageUrl = "";

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
        });
      });
      setState(() {
        _defaultImageUrl = defaultImageUrl;
      });
    });
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
    _pickSaveImage().then((imageurl) {
      setState(() {
        if (imageurl != null) {
          _imageUrl = imageurl;
          postObj post = postObj(
              0,
              _userEmail,
              _defaultImageUrl,
              _imageUrl,
              ["654", "123", "456", "789"],
              _time,
              _captionController.text.toString(),
              _locationController.text.toString());
          PostService postService = PostService(post.toMap());
          postService.addPost();
          _changeVisibility(true);
          Navigator.pop(context);
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
          leading: InkWell(
            child: new IconButton(
              icon: Icon(Icons.close),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: SizedBox(
              child: Text("New Post", style: TextStyle(color: Colors.black))),
          actions: <Widget>[
            Center(
              child: InkWell(
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
                          color: Colors.blue, fontWeight: FontWeight.normal),
                    ),
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
                  Column(
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: RaisedButton.icon(
                          splashColor: Colors.blue[200],
                          shape: StadiumBorder(),
                          color: Colors.blue,
                          label: Text(
                            'Upload Image',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.cloud_upload,
                            color: Colors.white,
                          ),
                          onPressed: _showImageDialog,
                        )),
                      ),
                      showImage()
                    ],
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
                            hintText: 'Add Caption',
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
//              Container(
//                child: currentLocation1 == null
//                    ? Container(
//                        width: 250,
//                        height: 100,
//                        decoration: new BoxDecoration(
//                            color: Colors.grey[200],
//                            borderRadius: new BorderRadius.circular(10.0)),
//                        child: Row(
//                          children: <Widget>[
//                            SizedBox(
//                              width: 20,
//                            ),
//                            CircularProgressIndicator(),
//                            SizedBox(
//                              width: 20,
//                            ),
//                            Text(
//                              "Getting location...",
//                              style: TextStyle(
//                                  fontSize: 20,
//                                  color: Colors.black,
//                                  fontStyle: FontStyle.normal),
//                            )
//                          ],
//                        ))
//                    : Text("Location:" + _lat + " " + _long),
//              ),
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

  _pickImage(String action) {
    action == 'Gallery'
        ? setState(() {
            imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
          })
        : setState(() {
            imageFile = ImagePicker.pickImage(source: ImageSource.camera);
          });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 100,
            height: 100,
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

  Future<String> _pickSaveImage() async {
    var rng = new Random();
    StorageReference reference =
        _storage.ref().child(_userId + "@" + rng.nextDouble().toString() + "/");
    StorageUploadTask uploadTask = reference.putFile(await imageFile);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  _showImageDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Choose from Gallery'),
                onPressed: () {
                  _pickImage('Gallery');
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text('Take Photo'),
                onPressed: () {
                  _pickImage('Camera');
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }));
  }
}
