import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/_grid_screen.dart';
import 'package:flutter_insta_clone/search/insta_filters.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_insta_clone/insta_stories.dart';

class InstaListSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => index == 0
          ? new SizedBox(
              child: new InstaFilters(),
              height: deviceSize.height * 0.08,
            )
          : index == 1
              ? new SizedBox(
                  height: deviceSize.height * 0.40,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          children: <Widget>[
                            new Expanded(
                              child: Image.network(
                                  "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_960_720.jpg"),
                            ),
                            new Expanded(
                              child: Image.network(
                                  "https://images4.alphacoders.com/899/899389.jpg"),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Image.network(
                            "https://isdb.pw/upload/250888886/1520870040902105012.jpg"),
                      ),
                    ],
                  ),
                )
              : new SizedBox(
                  child: new FirstScreen(),
                  height: deviceSize.height * 0.35,
                ),
    );
  }
}
