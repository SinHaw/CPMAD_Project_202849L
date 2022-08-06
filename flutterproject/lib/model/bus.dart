// To parse this JSON data, do
//
//     final bus = busFromJson(jsonString);

import 'dart:convert';

Bus busFromJson(String str) => Bus.fromJson(json.decode(str));

String busToJson(Bus data) => json.encode(data.toJson());

class Bus {
  Bus({
    this.status,
    this.data,
  });

  Status status;
  List<Datum> data;

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.serviceNo,
    this.datumOperator,
    this.nextBus,
    this.nextBus2,
    this.nextBus3,
  });

  String serviceNo;
  String datumOperator;
  NextBus nextBus;
  NextBus nextBus2;
  NextBus nextBus3;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serviceNo: json["ServiceNo"],
        datumOperator: json["Operator"],
        nextBus: NextBus.fromJson(json["NextBus"]),
        nextBus2: NextBus.fromJson(json["NextBus2"]),
        nextBus3: NextBus.fromJson(json["NextBus3"]),
      );

  Map<String, dynamic> toJson() => {
        "ServiceNo": serviceNo,
        "Operator": datumOperator,
        "NextBus": nextBus.toJson(),
        "NextBus2": nextBus2.toJson(),
        "NextBus3": nextBus3.toJson(),
      };
}

class NextBus {
  NextBus({
    this.originCode,
    this.destinationCode,
    this.estimatedArrival,
    this.latitude,
    this.longitude,
    this.visitNumber,
    this.load,
    this.feature,
    this.type,
  });

  String originCode;
  String destinationCode;
  DateTime estimatedArrival;
  String latitude;
  String longitude;
  String visitNumber;
  String load;
  String feature;
  String type;

  factory NextBus.fromJson(Map<String, dynamic> json) => NextBus(
        originCode: json["OriginCode"],
        destinationCode: json["DestinationCode"],
        estimatedArrival: DateTime.parse(json["EstimatedArrival"]),
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        visitNumber: json["VisitNumber"],
        load: json["Load"],
        feature: json["Feature"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "OriginCode": originCode,
        "DestinationCode": destinationCode,
        "EstimatedArrival": estimatedArrival.toIso8601String(),
        "Latitude": latitude,
        "Longitude": longitude,
        "VisitNumber": visitNumber,
        "Load": load,
        "Feature": feature,
        "Type": type,
      };
}

class Status {
  Status({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
