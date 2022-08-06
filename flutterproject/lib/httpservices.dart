import 'package:flutter/material.dart';
import 'package:flutterproject/model/bus.dart' as bus;
import 'package:http/http.dart' as http;
import 'package:flutterproject/model/busStopLocation.dart';

class HttpService {
  static Future<List<Datum>> getBusStop(
      double latitude, double longitude) async {
    try {
      final response = await http.get(Uri.parse(
          'https://tih-api.stb.gov.sg/transport/v1/bus_stop?apikey=54HJhzzqEWXL3wEnE2akYp83ZuL6WIxm&location=' +
              latitude.toString() +
              ',' +
              longitude.toString() +
              '&radius=1'));
      if (response.statusCode == 200) {
        final BusStopLocation cp = busStopLocationFromJson(response.body);
        return cp.data;
      } else {
        return List<Datum>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<Datum>();
    }
  }

  static Future<List<bus.Datum>> getBus(String buscode) async {
    try {
      final response = await http.get(Uri.parse(
          'https://tih-api.stb.gov.sg/transport/v1/bus_arrival/bus_stop/' +
              buscode.toString() +
              '?apikey=54HJhzzqEWXL3wEnE2akYp83ZuL6WIxm'));
      if (response.statusCode == 200) {
        final bus.Bus cp = bus.busFromJson(response.body);
        return cp.data;
      } else {
        return List<bus.Datum>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<bus.Datum>();
    }
  }
}
