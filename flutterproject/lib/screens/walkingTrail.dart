// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterproject/httpservices.dart';
import 'package:flutterproject/model/wtSearch.dart';
import 'package:flutterproject/screens/Profile.dart';
import 'package:html/parser.dart';

class wtJsonParse extends StatefulWidget {
  final String keyword;
  wtJsonParse({Key key, this.keyword}) : super(key: key);

  @override
  State<wtJsonParse> createState() => _wtJsonParseState();
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

String _parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

class _wtJsonParseState extends State<wtJsonParse> {
  final debouncer = Debouncer(msecond: 1000);
  List<Datum> _wt;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getWalkingTrial(widget.keyword).then((wt) {
      setState(() {
        _wt = wt;
        _loading = false;
      });
    });
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
                itemCount: null == _wt ? 0 : _wt.length,
                itemBuilder: (context, index) {
                  Datum walkingTrail = _wt[index];
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
                                  Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                      Center(
                                        child: FadeInImage(
                                            height: 190,
                                            placeholder: AssetImage(
                                                "images/transparent.png"),
                                            image: walkingTrail
                                                        .images.isEmpty !=
                                                    true
                                                ? NetworkImage(
                                                    "https://tih-api.stb.gov.sg/media/v1/download/uuid/" +
                                                        walkingTrail
                                                            .images[0].uuid +
                                                        "?apikey=54HJhzzqEWXL3wEnE2akYp83ZuL6WIxm")
                                                : AssetImage(
                                                    "images/blank.png"),
                                            fit: BoxFit.fill),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Description: ' +
                                        _parseHtmlString(walkingTrail.body),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 500,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                  SizedBox(height: 5.0),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Profile()));
                              },
                              icon: Icon(Icons.double_arrow))
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
