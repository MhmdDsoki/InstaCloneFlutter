import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/models/imageObj.dart';
import 'package:flutter_insta_clone/search/insta_filters.dart';
import 'package:flutter_insta_clone/util/Constans.dart';
import 'package:http/http.dart' as http;

class InstaListSearch extends StatefulWidget {
  @override
  _InstaListSearchState createState() => _InstaListSearchState();
}

class _InstaListSearchState extends State<InstaListSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _silvers(context));
  }

  List<imageObj> list = List();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Constants.BASE_API_URL + Constants.GRID_URL);
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new imageObj.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Widget _silvers(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  child: new InstaFilters(),
                  height: deviceSize.height * 0.08,
                ),
                SizedBox(
                  height: deviceSize.height * 0.40,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            new Expanded(
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: ("assets/images/placeholder.png"),
                                image:
                                    "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_960_720.jpg",
                              ),
                            ),
                            new Expanded(
                                child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: ("assets/images/placeholder.png"),
                              image:
                                  "https://images4.alphacoders.com/899/899389.jpg",
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                          child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: ("assets/images/placeholder.png"),
                        image:
                            "https://isdb.pw/upload/250888886/1520870040902105012.jpg",
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.all(1),
                    child: FadeInImage.assetNetwork(
                        height: 70.0,
                        width: 70.0,
                        fit: BoxFit.cover,
                        placeholder: ("assets/images/placeholder.png"),
                        image: list[index].thumbnailUrl));
              },
              childCount: list.length,
            ),
          ),
        ],
      ),
    );
  }
}
