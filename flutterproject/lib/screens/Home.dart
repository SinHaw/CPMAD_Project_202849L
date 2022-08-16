// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutterproject/screens/NearestBusStop.dart';
import 'package:flutterproject/screens/Profile.dart';
import 'package:flutterproject/screens/about.dart';
import 'package:flutterproject/screens/routeSearch.dart';
import 'package:flutterproject/screens/walkingTrailSearch.dart';
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
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            showRoute(userLocation: userLocation)));
                  },
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius:
                            new BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Icon(
                          Icons.edit_road,
                          size: 120,
                        ),
                        Text(
                          "Experential Route",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
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
                        borderRadius:
                            new BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Icon(
                          Icons.directions_bus,
                          size: 120,
                        ),
                        Text(
                          "Nearby Buses",
                          style: TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => wtSearch()));
                  },
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius:
                            new BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Icon(
                          Icons.nordic_walking,
                          size: 120,
                        ),
                        Text(
                          "Walking Trail",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 1,
                mainAxisSpacing: 2,
                crossAxisCount: 2,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _getLocation().then((value) {
                          setState(() {
                            userLocation = value;
                          });
                        }).catchError((e) => print('${e.error}'));
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Icon(
                              Icons.account_circle_rounded,
                              size: 120,
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(fontSize: 30),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => about()));
                      },
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Icon(
                              Icons.announcement,
                              size: 120,
                            ),
                            Text(
                              "About",
                              style: TextStyle(fontSize: 30),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
