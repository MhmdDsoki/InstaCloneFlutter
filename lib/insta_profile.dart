import 'package:flutter/material.dart';

import 'insta_details_silvers.dart';

class InstaProfile extends StatelessWidget {
  topBar(BuildContext context) {
    return new AppBar(
      backgroundColor: new Color(0xfff8faf8),
      centerTitle: true,
      elevation: 1.0,
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: new Text("Muhammad Sayed"),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(Icons.more_horiz),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: topBar(context),
      body: InstaDetailsSilvers(),
    );
  }
}
