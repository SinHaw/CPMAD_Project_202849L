// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutterproject/screens/NearestBusStop.dart';
import 'package:flutterproject/screens/Profile.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var location = new Location();
  LocationData userLocation;
  Future<LocationData> _getLocation() async {
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getLocation().then((value) {
              setState(() {
                userLocation = value;
              });
            }));
  }

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
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  }).catchError((e) => print('${e.error}'));
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Profile()));
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
                onTap: () {
                  userLocation != null
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BSLJsonParse(userLocation: userLocation)))
                      : DoNothingAction();
                },
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
                    Icons.announcement,
                    size: 120,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
