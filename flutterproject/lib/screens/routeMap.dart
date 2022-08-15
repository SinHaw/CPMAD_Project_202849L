// ignore_for_file: avoid_function_literals_in_foreach_calls, file_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutterproject/httpservices.dart';
import 'package:flutterproject/model/routeDetails.dart' as rd;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class routeMap extends StatefulWidget {
  final LatLng Destination;
  final LocationData userLocation;

  routeMap({Key key, this.Destination, this.userLocation}) : super(key: key);

  @override
  State<routeMap> createState() => _routeMapState();
}

class _routeMapState extends State<routeMap> {
  rd.Data _rd;
  List<dynamic> _pois;
  Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polylinecoordinates = [];
  LocationData currentlocation;
  BitmapDescriptor SIcon;
  BitmapDescriptor WIcon;
  final Set<Marker> listmarkers = {};
  List<PointLatLng> result;
  bool _isVisible = false;

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) => currentlocation = location);
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((newloc) {
      currentlocation = newloc;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 20, target: LatLng(newloc.latitude, newloc.longitude))));
      setState(() {});
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    result = polylinePoints
        .decodePolyline(_rd.routes[0].overviewPolyline.points.toString());
    for (var i = 0; i < result.length; i++) {
      polylinecoordinates.add(LatLng(result[i].latitude, result[i].longitude));
    }
    setState(() {});
  }

  Future<BitmapDescriptor> _setLocalCustomMarker() async {
    SIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "images/home-map-pin.png");
    return SIcon;
  }

  Future<BitmapDescriptor> _setWaypointCustomMarker() async {
    WIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "images/waypointpin.png");
    return WIcon;
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
    HttpService.getRoutePois(
            widget.userLocation.latitude.toString(),
            widget.userLocation.longitude.toString(),
            widget.Destination.latitude.toString(),
            widget.Destination.longitude.toString())
        .then((pois) {
      setState(() {
        _pois = pois;
        HttpService.getRouteDetails(
                widget.userLocation.latitude.toString(),
                widget.userLocation.longitude.toString(),
                widget.Destination.latitude.toString(),
                widget.Destination.longitude.toString())
            .then((rd) {
          setState(() {
            _rd = rd;
            print("asdasd");
            print(_rd);
            getPolyPoints();
            _setLocalCustomMarker().then((value) => listmarkers.add(Marker(
                markerId: MarkerId("Source"),
                position: LatLng(
                  result[0].latitude,
                  result[0].longitude,
                ),
                icon: value,
                infoWindow: InfoWindow(title: 'CurrentLocation'))));
            _setWaypointCustomMarker().then((value) {
              for (var i = 0; i < _pois.length - 1; i++) {
                listmarkers.add(Marker(
                    markerId: MarkerId(i.toString()),
                    position: LatLng(
                      _pois[i]['location']['latitude'],
                      _pois[i]['location']['longitude'],
                    ),
                    infoWindow: InfoWindow(title: 'Pois'),
                    icon: WIcon));
              }
            });
            listmarkers.add(Marker(
                markerId: MarkerId("Destination"),
                position: LatLng(result[result.length - 1].latitude,
                    result[result.length - 1].longitude),
                infoWindow: InfoWindow(title: 'Destination')));
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _currentPos = CameraPosition(
      bearing: 0.0, //compass direction – 90 degree orients east up
      target: currentlocation != null
          ? LatLng(currentlocation.latitude, currentlocation.longitude)
          : LatLng(widget.userLocation.latitude, widget.userLocation.longitude),
      tilt: 0.0, //title angle – 60 degree looks ahead towards the horizon
      zoom: 20, //zoom level – a middle value of 11 shows city-level
    );
    return Scaffold(
      appBar: AppBar(),
      body: _rd == null
          ? Center(child: Text("No Experential Route"))
          : Stack(children: <Widget>[
              GoogleMap(
                polylines: {
                  Polyline(
                    polylineId: PolylineId('route'),
                    points: polylinecoordinates,
                    color: Colors.blue,
                    width: 8,
                    patterns: [
                      PatternItem.dash(8),
                    ],
                  )
                },
                markers: Set.from(listmarkers),
                mapType: MapType.terrain,
                myLocationEnabled: true,
                initialCameraPosition: _currentPos,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_isVisible == false) {
                      _isVisible = true;
                    } else {
                      _isVisible = false;
                    }
                  });
                },
                child: Text('Show Pois'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              ),
              Visibility(
                visible: _isVisible,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 180,
                      child: ListView.builder(
                        itemCount: null == _pois ? 0 : _pois.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                              Center(
                                                child: FadeInImage(
                                                    height: 100,
                                                    placeholder: AssetImage(
                                                        "images/transparent.png"),
                                                    image: _pois[index]
                                                                    ['images']
                                                                .isEmpty !=
                                                            true
                                                        ? NetworkImage(
                                                            "https://tih-api.stb.gov.sg/media/v1/download/uuid/" +
                                                                _pois[index][
                                                                        'images']
                                                                    [
                                                                    0]['uuid'] +
                                                                "?apikey=54HJhzzqEWXL3wEnE2akYp83ZuL6WIxm")
                                                        : AssetImage(
                                                            "images/blank.png"),
                                                    fit: BoxFit.fill),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Name: ' + _pois[index]['name'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 500,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'Ratings: ' +
                                                _pois[index]['rating']
                                                    .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 500,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'Block: ' +
                                                _pois[index]['address']['block']
                                                    .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 500,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'StreetName: ' +
                                                _pois[index]['address']
                                                        ['streetName']
                                                    .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 500,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            'postalCode: ' +
                                                _pois[index]['address']
                                                        ['postalCode']
                                                    .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 500,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black),
                                          ),
                                          _pois[index]['address']['floorNumber']
                                                  .isNotEmpty
                                              ? _pois[index]['address']
                                                          ['unitNumber']
                                                      .isNotEmpty
                                                  ? Text(
                                                      'Unit Number: ' +
                                                          _pois[index][
                                                                      'address']
                                                                  [
                                                                  'floorNumber']
                                                              .toString() +
                                                          "-" +
                                                          _pois[index][
                                                                      'address']
                                                                  ['unitNumber']
                                                              .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 500,
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.black),
                                                    )
                                                  : Text(
                                                      'Floor Number: ' +
                                                          _pois[index][
                                                                      'address']
                                                                  [
                                                                  'floorNumber']
                                                              .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 500,
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.black),
                                                    )
                                              : Text(""),
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
                  ],
                ),
              ),
            ]),
    );
  }
}
