// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutterproject/screens/Profile.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          title: const Text("SGAroundU"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: new BorderRadius.all(Radius.circular(20))),
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 120,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: new BorderRadius.all(Radius.circular(20))),
                  child: Icon(
                    Icons.directions_bus,
                    size: 120,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: new BorderRadius.all(Radius.circular(20))),
                  child: Icon(
                    Icons.shopping_bag,
                    size: 120,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: new BorderRadius.all(Radius.circular(20))),
                  child: Icon(
                    Icons.hotel,
                    size: 120,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
