// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterproject/httpservices.dart';
import 'package:flutterproject/model/wtDetails.dart' as details;
import 'package:url_launcher/url_launcher.dart';

class wtDetails extends StatefulWidget {
  final String uuid;
  wtDetails({Key key, this.uuid}) : super(key: key);

  @override
  State<wtDetails> createState() => _wtDetailsState();
}

class Debouncer {
  final int msecond;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.msecond});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: msecond), action);
  }
}

class _wtDetailsState extends State<wtDetails> {
  final debouncer = Debouncer(msecond: 1000);
  List<details.Datum> _wtd;
  bool _loading;
  String waypoint = "";
  List<String> alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getWalkingTrialDetails(widget.uuid).then((wtd) {
      setState(() {
        _wtd = wtd;
        _loading = false;
      });
    });
  }

  _launchURL() async {
    for (var i = 1; i < _wtd.length - 1; i++) {
      waypoint += _wtd[i].location.latitude.toString() +
          "," +
          _wtd[i].location.longitude.toString() +
          "|";
    }
    String url = "https://www.google.com/maps/dir/?api=1&origin=" +
        _wtd[0].location.latitude.toString() +
        "," +
        _wtd[0].location.longitude.toString() +
        "&destination=" +
        _wtd[_wtd.length - 1].location.latitude.toString() +
        "," +
        _wtd[_wtd.length - 1].location.longitude.toString() +
        "&waypoints=" +
        waypoint +
        "&travelmode=walking&dir_action=navigate";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Walking Trial'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: null == _wtd ? 0 : _wtd.length,
                itemBuilder: (context, index) {
                  details.Datum walkingTrailDetails = _wtd[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Route: ' + alphabet[index],
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.grey),
                                  ),
                                  Text(
                                    'Address: ' +
                                        walkingTrailDetails.formattedAddress,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                  Text(
                                    'Name: ' + walkingTrailDetails.name,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            RaisedButton(onPressed: _launchURL, child: Text("Show Route"))
          ],
        ),
      ),
    );
  }
}
