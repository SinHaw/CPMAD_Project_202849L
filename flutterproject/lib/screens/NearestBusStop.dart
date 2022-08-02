// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterproject/httpservices.dart';
import 'package:flutterproject/model/busStopLocation.dart';

class BSLJsonParse extends StatefulWidget {
  BSLJsonParse({Key key}) : super(key: key);

  @override
  State<BSLJsonParse> createState() => _BSLJsonParseState();
  final location = "1.4447, 103.7962";
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

class _BSLJsonParseState extends State<BSLJsonParse> {
  final debouncer = Debouncer(msecond: 1000);
  List<Datum> _bsl;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getBusStop(widget.location).then((bsl) {
      setState(() {
        _bsl = bsl;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Bus Stop'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: null == _bsl ? 0 : _bsl.length,
                itemBuilder: (context, index) {
                  Datum busStopLocation = _bsl[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bus Code: ' + busStopLocation.code,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'Location: ' + busStopLocation.description,
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black87),
                          ),
                          Text(
                            'Street: ' + busStopLocation.roadName,
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black87),
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
