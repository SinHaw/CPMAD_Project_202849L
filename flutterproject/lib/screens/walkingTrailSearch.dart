// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutterproject/screens/walkingTrail.dart';

class wtSearch extends StatefulWidget {
  wtSearch({Key key}) : super(key: key);

  @override
  State<wtSearch> createState() => _wtSearchState();
}

class _wtSearchState extends State<wtSearch> {
  final keyword = TextEditingController();
  void clearText() {
    keyword.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
              ),
              Icon(
                Icons.nordic_walking,
                size: 180,
              ),
              TextField(
                controller: keyword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Keyword... eg.Food,Art,Events,Shops'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: clearText,
                    child: Text(
                      "Clear",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              wtJsonParse(keyword: keyword.text)));
                    },
                    child: Text("Search"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
