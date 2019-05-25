import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/pages/login.dart';
import 'package:flutter_insta_clone/util/SharedPrefsHelper.dart';
import 'package:flutter_insta_clone/util/authntication.dart';

import 'app.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus { NOT_DETERMINED, NOT_LOGGED_IN, LOGGED_IN, SIGNED_UP }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
      isLoggedIn=false;
    });
  }

  void _onSignedUp() {
    setState(() {
      authStatus = AuthStatus.SIGNED_UP;
      _userId = "";
    });
  }

  Widget _buildSplashScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset(
                  'assets/images/insta_logo.png',
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper.getUserLoggedIn().then((onValue) {
      setState(() {
        this.isLoggedIn = onValue;
      });
    });
    if (isLoggedIn) {
      return new InstaHomeState(
          userId: _userId, auth: widget.auth, onSignedOut: _onSignedOut);
    } else {
      return new LoginPage(
        auth: widget.auth,
        onSignedIn: _onLoggedIn,
      );
    }
//    switch (authStatus) {
//      case AuthStatus.NOT_DETERMINED:
//        return _buildSplashScreen();
//        break;
//      case AuthStatus.NOT_LOGGED_IN:
//        return new LoginPage(
//          auth: widget.auth,
//          onSignedIn: _onLoggedIn,
//        );
//        break;
//      case AuthStatus.SIGNED_UP:
//        return new LoginPage(
//          auth: widget.auth,
//          onSignedIn: _onSignedUp,
//          onSignedUp: _onSignedUp,
//        );
//        break;
//      case AuthStatus.LOGGED_IN:
//        if (_userId.length > 0 && _userId != null) {
//
//
//          return new InstaHomeState(
//              userId: _userId, auth: widget.auth, onSignedOut: _onSignedOut);
//        } else
//          return _buildSplashScreen();
//        break;
//      default:
//        return _buildSplashScreen();
//    }
  }
}
