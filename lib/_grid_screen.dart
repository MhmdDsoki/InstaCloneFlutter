import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone/models/imageObj.dart';
import 'package:http/http.dart' as http;
import 'util/Constans.dart';

class FirstScreen extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<FirstScreen> {
  List<imageObj> list = List();
  var isLoading = false;

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

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 3,
              children: List.generate(
                list.length,
                (index) {
                  return Container(
                      padding: EdgeInsets.all(1),
                      child: FadeInImage.assetNetwork(
                          height: 70.0,
                          width: 70.0,
                          fit: BoxFit.cover,
                          placeholder: ("assets/images/placeholder.png"),
                          image: list[index].thumbnailUrl));
                },
              )),
    ));
  }
}
