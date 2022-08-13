// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutterproject/screens/routeMap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

class showRoute extends StatefulWidget {
  final LocationData userLocation;
  showRoute({Key key, this.userLocation}) : super(key: key);

  @override
  State<showRoute> createState() => _showRouteState();
}

class _showRouteState extends State<showRoute> {
  final keyword = TextEditingController();
  List<Location> locations;
  void clearText() {
    keyword.clear();
  }

  @override
  _getLocation() async {
    locations = await locationFromAddress(keyword.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                  Icons.add_road,
                  size: 180,
                ),
                TextField(
                  controller: keyword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Destination'),
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
                        _getLocation();
                        locations != null
                            ? Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => routeMap(
                                      userLocation: widget.userLocation,
                                      Destination: LatLng(locations[0].latitude,
                                          locations[0].longitude),
                                    )))
                            : null;
                      },
                      child: Text("Search"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
