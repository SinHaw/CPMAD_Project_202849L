import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterproject/model/busStopLocation.dart';

class HttpService {
  static Future<List<Datum>> getBusStop(String location) async {
    try {
      final response = await http.get(Uri.parse(
          'https://tih-api.stb.gov.sg/transport/v1/bus_stop?apikey=54HJhzzqEWXL3wEnE2akYp83ZuL6WIxm&location=' +
              location +
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
  } //getCarparks
}
