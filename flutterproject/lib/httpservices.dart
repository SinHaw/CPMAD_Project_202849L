import 'package:flutter/material.dart';
import 'package:flutterproject/model/bus.dart' as bus;
import 'package:flutterproject/model/routeDetails.dart';
import 'package:flutterproject/model/wtDetails.dart' as details;
import 'package:flutterproject/model/wtSearch.dart' as wt;
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
              buscode +
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

  static Future<List<wt.Datum>> getWalkingTrial(String keyword) async {
    try {
      final response = await http.get(Uri.parse(
          'https://tih-api.stb.gov.sg/content/v1/walking-trail/search?apikey=54HJhzzqEWXL3wEnE2akYp83ZuL6WIxm&keyword=' +
              keyword));
      if (response.statusCode == 200) {
        final wt.WtSearch cp = wt.wtSearchFromJson(response.body);
        return cp.data;
      } else {
        return List<wt.Datum>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<wt.Datum>();
    }
  }

  static Future<List<details.Datum>> getWalkingTrialDetails(String uuid) async {
    try {
      final response = await http.get(Uri.parse(
          'https://tih-api.stb.gov.sg/content/v1/walking-trail/uuid/' +
              uuid +
              '/detail?apikey=54HJhzzqEWXL3wEnE2akYp83ZuL6WIxm'));
      if (response.statusCode == 200) {
        final details.WtDetails cp = details.wtDetailsFromJson(response.body);
        return cp.data;
      } else {
        return List<details.Datum>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<details.Datum>();
    }
  }

  static Future<Data> getRouteDetails(String Olatitude, String Olongitude,
      String Dlatitude, String Dlongitude) async {
    try {
      final response = await http.get(Uri.parse(
          'https://tih-api.stb.gov.sg/map/v1.1/experiential_route/default?origin=' +
              Olatitude +
              "," +
              Olongitude +
              '&destination=' +
              Dlatitude +
              "," +
              Dlongitude +
              '&apikey=54HJhzzqEWXL3wEnE2akYp83ZuL6WIxm'));
      if (response.statusCode == 200) {
        final RouteDetails cp = routeDetailsFromJson(response.body);
        return cp.data;
      } else {
        return Data();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Data();
    }
  }

  static Future<List<dynamic>> getRoutePois(String Olatitude, String Olongitude,
      String Dlatitude, String Dlongitude) async {
    try {
      final response = await http.get(Uri.parse(
          'https://tih-api.stb.gov.sg/map/v1.1/experiential_route/default?origin=' +
              Olatitude +
              "," +
              Olongitude +
              '&destination=' +
              Dlatitude +
              "," +
              Dlongitude +
              '&apikey=54HJhzzqEWXL3wEnE2akYp83ZuL6WIxm'));
      if (response.statusCode == 200) {
        final RouteDetails cp = routeDetailsFromJson(response.body);
        return cp.pois;
      } else {
        return List<dynamic>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<dynamic>();
    }
  }
}
