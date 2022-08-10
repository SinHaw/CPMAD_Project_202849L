import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final LocationData userLocation;
  final LatLng destination;
  MapPage({Key key, this.userLocation, this.destination}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  String googleAPiKey = "AIzaSyAoj_EJY0eOA07X-r8qlv4C_2sGObntv9g";
  List<LatLng> polylinecoordinates = [];
  LocationData currentlocation;

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

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(
            widget.userLocation.latitude, widget.userLocation.longitude),
        PointLatLng(widget.destination.latitude, widget.destination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylinecoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _currentPos = CameraPosition(
      bearing: 0.0, //compass direction – 90 degree orients east up
      target: LatLng(currentlocation.latitude, currentlocation.longitude),
      tilt: 0.0, //title angle – 60 degree looks ahead towards the horizon
      zoom: 20, //zoom level – a middle value of 11 shows city-level
    );
    return Scaffold(
      appBar: AppBar(),
      body: currentlocation == null
          ? Center(child: Text("loading"))
          : GoogleMap(
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
              markers: {
                Marker(
                  markerId: MarkerId('source'),
                  position: LatLng(widget.userLocation.latitude,
                      widget.userLocation.longitude),
                ),
                Marker(
                  markerId: MarkerId('destination'),
                  position: LatLng(widget.destination.latitude,
                      widget.destination.longitude),
                ),
              },
              mapType: MapType.terrain,
              myLocationEnabled: true,
              initialCameraPosition: _currentPos,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
