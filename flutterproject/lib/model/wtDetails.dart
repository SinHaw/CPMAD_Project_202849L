// To parse this JSON data, do
//
//     final wtDetails = wtDetailsFromJson(jsonString);

import 'dart:convert';

WtDetails wtDetailsFromJson(String str) => WtDetails.fromJson(json.decode(str));

String wtDetailsToJson(WtDetails data) => json.encode(data.toJson());

class WtDetails {
  WtDetails({
    this.status,
    this.data,
  });

  Status status;
  List<Datum> data;

  factory WtDetails.fromJson(Map<String, dynamic> json) => WtDetails(
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
    this.metadata,
    this.uuid,
    this.thumbnails,
    this.images,
    this.rating,
    this.contact,
    this.formattedAddress,
    this.parentUuid,
    this.officialWebsite,
    this.videos,
    this.documents,
    this.tags,
    this.source,
    this.description,
    this.name,
    this.location,
    this.type,
  });

  Metadata metadata;
  String uuid;
  List<dynamic> thumbnails;
  List<dynamic> images;
  int rating;
  Contact contact;
  String formattedAddress;
  String parentUuid;
  String officialWebsite;
  List<dynamic> videos;
  List<dynamic> documents;
  List<dynamic> tags;
  String source;
  String description;
  String name;
  Location location;
  String type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        metadata: Metadata.fromJson(json["metadata"]),
        uuid: json["uuid"],
        thumbnails: List<dynamic>.from(json["thumbnails"].map((x) => x)),
        images: List<dynamic>.from(json["images"].map((x) => x)),
        rating: json["rating"],
        contact: Contact.fromJson(json["contact"]),
        formattedAddress: json["formattedAddress"],
        parentUuid: json["parentUuid"],
        officialWebsite: json["officialWebsite"],
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        source: json["source"],
        description: json["description"],
        name: json["name"],
        location: Location.fromJson(json["location"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "uuid": uuid,
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x)),
        "images": List<dynamic>.from(images.map((x) => x)),
        "rating": rating,
        "contact": contact.toJson(),
        "formattedAddress": formattedAddress,
        "parentUuid": parentUuid,
        "officialWebsite": officialWebsite,
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "documents": List<dynamic>.from(documents.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "source": source,
        "description": description,
        "name": name,
        "location": location.toJson(),
        "type": type,
      };
}

class Contact {
  Contact({
    this.primaryContactNo,
    this.secondaryContactNo,
    this.otherContactNo,
  });

  String primaryContactNo;
  String secondaryContactNo;
  String otherContactNo;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        primaryContactNo: json["primaryContactNo"],
        secondaryContactNo: json["secondaryContactNo"],
        otherContactNo: json["otherContactNo"],
      );

  Map<String, dynamic> toJson() => {
        "primaryContactNo": primaryContactNo,
        "secondaryContactNo": secondaryContactNo,
        "otherContactNo": otherContactNo,
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

class Metadata {
  Metadata({
    this.createdDate,
    this.updatedDate,
  });

  DateTime createdDate;
  DateTime updatedDate;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "createdDate": createdDate.toIso8601String(),
        "updatedDate": updatedDate.toIso8601String(),
      };
}

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
