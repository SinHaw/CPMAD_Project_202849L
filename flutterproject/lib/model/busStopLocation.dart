// To parse this JSON data, do
//
//     final busStopLocation = busStopLocationFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

BusStopLocation busStopLocationFromJson(String str) =>
    BusStopLocation.fromJson(json.decode(str));

String busStopLocationToJson(BusStopLocation data) =>
    json.encode(data.toJson());

class BusStopLocation {
  BusStopLocation({
    this.data,
    this.status,
  });

  List<Datum> data;
  Status status;

  factory BusStopLocation.fromJson(Map<String, dynamic> json) =>
      BusStopLocation(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status.toJson(),
      };
}

class Datum {
  Datum({
    this.code,
    this.roadName,
    this.description,
    this.location,
  });

  String code;
  String roadName;
  String description;
  Location location;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        code: json["code"],
        roadName: json["roadName"],
        description: json["description"],
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "roadName": roadName,
        "description": description,
        "location": location.toJson(),
      };
}

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Status {
  Status({
    this.code,
    this.errorDetail,
    this.message,
  });

  int code;
  String errorDetail;
  String message;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        errorDetail: json["errorDetail"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "errorDetail": errorDetail,
        "message": message,
      };
}
