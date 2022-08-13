// To parse this JSON data, do
//
//     final routeDetails = routeDetailsFromJson(jsonString);

import 'dart:convert';

RouteDetails routeDetailsFromJson(String str) =>
    RouteDetails.fromJson(json.decode(str));

String routeDetailsToJson(RouteDetails data) => json.encode(data.toJson());

class RouteDetails {
  RouteDetails({
    this.status,
    this.data,
    this.pois,
    this.poweredBy,
  });

  Status status;
  Data data;
  List<dynamic> pois;
  String poweredBy;

  factory RouteDetails.fromJson(Map<String, dynamic> json) => RouteDetails(
        status: Status.fromJson(json["status"]),
        data: Data.fromJson(json["data"]),
        pois: List<dynamic>.from(json["pois"].map((x) => x)),
        poweredBy: json["poweredBy"],
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
        "pois": List<dynamic>.from(pois.map((x) => x)),
        "poweredBy": poweredBy,
      };
}

class Data {
  Data({
    this.distance,
    this.routes,
    this.duration,
  });

  int distance;
  List<Route> routes;
  int duration;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        distance: json["distance"],
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "duration": duration,
      };
}

class Route {
  Route({
    this.legs,
    this.overviewPolyline,
    this.bounds,
  });

  List<Leg> legs;
  Polyline overviewPolyline;
  Bounds bounds;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        overviewPolyline: Polyline.fromJson(json["overview_polyline"]),
        bounds: Bounds.fromJson(json["bounds"]),
      );

  Map<String, dynamic> toJson() => {
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
        "overview_polyline": overviewPolyline.toJson(),
        "bounds": bounds.toJson(),
      };
}

class Bounds {
  Bounds({
    this.northeast,
    this.southwest,
  });

  Northeast northeast;
  Northeast southwest;

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
        northeast: Northeast.fromJson(json["northeast"]),
        southwest: Northeast.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}

class Northeast {
  Northeast({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Northeast.fromJson(Map<String, dynamic> json) => Northeast(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Leg {
  Leg({
    this.distance,
    this.startLocation,
    this.steps,
    this.arrivalTime,
    this.departureTime,
    this.endLocation,
    this.duration,
    this.startAddress,
    this.endAddress,
  });

  int distance;
  Northeast startLocation;
  List<Step> steps;
  String arrivalTime;
  String departureTime;
  Northeast endLocation;
  int duration;
  String startAddress;
  String endAddress;

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        distance: json["distance"],
        startLocation: Northeast.fromJson(json["startLocation"]),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
        arrivalTime: json["arrivalTime"],
        departureTime: json["departureTime"],
        endLocation: Northeast.fromJson(json["endLocation"]),
        duration: json["duration"],
        startAddress: json["startAddress"],
        endAddress: json["endAddress"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "startLocation": startLocation.toJson(),
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
        "arrivalTime": arrivalTime,
        "departureTime": departureTime,
        "endLocation": endLocation.toJson(),
        "duration": duration,
        "startAddress": startAddress,
        "endAddress": endAddress,
      };
}

class Step {
  Step({
    this.polyline,
    this.distance,
    this.startLocation,
    this.steps,
    this.maneuver,
    this.endLocation,
    this.duration,
    this.transitDetail,
    this.htmlInstructions,
    this.travelMode,
  });

  Polyline polyline;
  int distance;
  Northeast startLocation;
  dynamic steps;
  Maneuver maneuver;
  Northeast endLocation;
  int duration;
  dynamic transitDetail;
  String htmlInstructions;
  TravelMode travelMode;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        polyline: Polyline.fromJson(json["polyline"]),
        distance: json["distance"],
        startLocation: Northeast.fromJson(json["startLocation"]),
        steps: json["steps"],
        maneuver: maneuverValues.map[json["maneuver"]],
        endLocation: Northeast.fromJson(json["endLocation"]),
        duration: json["duration"],
        transitDetail: json["transitDetail"],
        htmlInstructions: json["htmlInstructions"],
        travelMode: travelModeValues.map[json["travelMode"]],
      );

  Map<String, dynamic> toJson() => {
        "polyline": polyline.toJson(),
        "distance": distance,
        "startLocation": startLocation.toJson(),
        "steps": steps,
        "maneuver": maneuverValues.reverse[maneuver],
        "endLocation": endLocation.toJson(),
        "duration": duration,
        "transitDetail": transitDetail,
        "htmlInstructions": htmlInstructions,
        "travelMode": travelModeValues.reverse[travelMode],
      };
}

enum Maneuver { EMPTY, TURN_RIGHT, TURN_LEFT, TURN_SLIGHT_LEFT }

final maneuverValues = EnumValues({
  "": Maneuver.EMPTY,
  "turn-left": Maneuver.TURN_LEFT,
  "turn-right": Maneuver.TURN_RIGHT,
  "turn-slight-left": Maneuver.TURN_SLIGHT_LEFT
});

class Polyline {
  Polyline({
    this.points,
  });

  String points;

  factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "points": points,
      };
}

enum TravelMode { WALKING }

final travelModeValues = EnumValues({"WALKING": TravelMode.WALKING});

class Status {
  Status({
    this.code,
    this.message,
    this.errorDetail,
  });

  int code;
  String message;
  String errorDetail;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
        errorDetail: json["errorDetail"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "errorDetail": errorDetail,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
