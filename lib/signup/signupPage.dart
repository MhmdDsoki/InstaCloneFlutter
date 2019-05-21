// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseUser;
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/util/authntication.dart';
import 'dart:async';

import '../app.dart';

class SignupPage extends StatefulWidget {
  SignupPage({this.auth, this.onSignedUp});

  final BaseAuth auth;
  final VoidCallback onSignedUp;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      if (user != null) {
        // send the user to the home page
        widget.onSignedUp();
      }
    });
  }

  Widget _getContent() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "English (United Stated)",
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey[200],
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset(
                        'assets/images/insta_logo.png',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
                SizedBox(height: 20.0),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _usernameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black)),
                  obscureText: true,
                ),
                SizedBox(height: 12.0),
                OutlineButton(
                  child: Text("Sign Up"),
                  textColor: Colors.grey[200],
                  onPressed: () {
                    signUpWithEmail();
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Colors.green[200],
                    Colors.blue[200],
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.1, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: _getContent() /* add child content here */,
          ),
        ),
      ],
    );
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  String userId = "";

  void signUpWithEmail() async {
    userId = await widget.auth
        .signUp(_usernameController.text, _passwordController.text);
    if (userId.length > 0 && userId != null) {
      Navigator.pop(context);
      print('Signed in: $userId');
    }
  }
}
