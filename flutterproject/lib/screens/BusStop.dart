// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, missing_return

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterproject/httpservices.dart';
import 'package:flutterproject/model/bus.dart';
import 'package:flutterproject/screens/Profile.dart';
import 'package:flutterproject/screens/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class BusStopJsonParse extends StatefulWidget {
  final String buscode;
  final LocationData userLocation;
  final LatLng busStopLocation;
  BusStopJsonParse(
      {Key key, this.buscode, this.userLocation, this.busStopLocation})
      : super(key: key);

  @override
  State<BusStopJsonParse> createState() => _BusStopJsonParseState();
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

class _BusStopJsonParseState extends State<BusStopJsonParse> {
  final debouncer = Debouncer(msecond: 1000);
  List<Datum> _bus;
  bool _loading;
  final currentTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getBus(widget.buscode).then((bs) {
      setState(() {
        _bus = bs;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _loading ? 'Loading...' : "Bus Stop",
          style: TextStyle(color: Colors.white),
        ),
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
                itemCount: null == _bus ? 0 : _bus.length,
                itemBuilder: (context, index) {
                  Datum busStop = _bus[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bus No: ' + busStop.serviceNo,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Estimated Wait time: ' +
                                    currentTime
                                        .difference(busStop
                                            .nextBus.estimatedArrival
                                            .toLocal())
                                        .inMinutes
                                        .abs()
                                        .toString() +
                                    ',' +
                                    currentTime
                                        .difference(busStop
                                            .nextBus2.estimatedArrival
                                            .toLocal())
                                        .inMinutes
                                        .abs()
                                        .toString() +
                                    ',' +
                                    currentTime
                                        .difference(busStop
                                            .nextBus3.estimatedArrival
                                            .toLocal())
                                        .inMinutes
                                        .abs()
                                        .toString() +
                                    ' Minutes',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                              RaisedButton(
                                child: Text("Show Route"),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => (MapPage(
                                            userLocation: widget.userLocation,
                                            destination: widget.busStopLocation,
                                          ))));
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
