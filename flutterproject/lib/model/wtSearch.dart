// To parse this JSON data, do
//
//     final wtSearch = wtSearchFromJson(jsonString);

import 'dart:convert';

WtSearch wtSearchFromJson(String str) => WtSearch.fromJson(json.decode(str));

String wtSearchToJson(WtSearch data) => json.encode(data.toJson());

class WtSearch {
  WtSearch({
    this.status,
    this.data,
    this.nextToken,
  });

  Status status;
  List<Datum> data;
  String nextToken;

  factory WtSearch.fromJson(Map<String, dynamic> json) => WtSearch(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        nextToken: json["nextToken"],
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "nextToken": nextToken,
      };
}

class Datum {
  Datum({
    this.metadata,
    this.uuid,
    this.companyDisplayName,
    this.categoryDescription,
    this.body,
    this.dataset,
    this.thumbnails,
    this.images,
    this.supportedLanguage,
    this.contact,
    this.officialEmail,
    this.staYear,
    this.officialWebsite,
    this.videos,
    this.documents,
    this.tags,
    this.source,
    this.description,
    this.group,
    this.name,
    this.type,
  });

  Metadata metadata;
  String uuid;
  CompanyDisplayName companyDisplayName;
  CategoryDescription categoryDescription;
  String body;
  Dataset dataset;
  List<Image> thumbnails;
  List<Image> images;
  List<SupportedLanguage> supportedLanguage;
  Contact contact;
  OfficialEmail officialEmail;
  String staYear;
  String officialWebsite;
  List<dynamic> videos;
  List<dynamic> documents;
  List<String> tags;
  CompanyDisplayName source;
  String description;
  Group group;
  String name;
  String type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        metadata: Metadata.fromJson(json["metadata"]),
        uuid: json["uuid"],
        companyDisplayName:
            companyDisplayNameValues.map[json["companyDisplayName"]],
        categoryDescription:
            categoryDescriptionValues.map[json["categoryDescription"]],
        body: json["body"],
        dataset: datasetValues.map[json["dataset"]],
        thumbnails:
            List<Image>.from(json["thumbnails"].map((x) => Image.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        supportedLanguage: List<SupportedLanguage>.from(
            json["supportedLanguage"]
                .map((x) => supportedLanguageValues.map[x])),
        contact: Contact.fromJson(json["contact"]),
        officialEmail: officialEmailValues.map[json["officialEmail"]],
        staYear: json["staYear"],
        officialWebsite: json["officialWebsite"],
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        tags: List<String>.from(json["tags"].map((x) => x)),
        source: companyDisplayNameValues.map[json["source"]],
        description: json["description"],
        group: groupValues.map[json["group"]],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "uuid": uuid,
        "companyDisplayName":
            companyDisplayNameValues.reverse[companyDisplayName],
        "categoryDescription":
            categoryDescriptionValues.reverse[categoryDescription],
        "body": body,
        "dataset": datasetValues.reverse[dataset],
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "supportedLanguage": List<dynamic>.from(
            supportedLanguage.map((x) => supportedLanguageValues.reverse[x])),
        "contact": contact.toJson(),
        "officialEmail": officialEmailValues.reverse[officialEmail],
        "staYear": staYear,
        "officialWebsite": officialWebsite,
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "documents": List<dynamic>.from(documents.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "source": companyDisplayNameValues.reverse[source],
        "description": description,
        "group": groupValues.reverse[group],
        "name": name,
        "type": type,
      };
}

enum CategoryDescription { WALKING_TRAIL }

final categoryDescriptionValues =
    EnumValues({"Walking Trail": CategoryDescription.WALKING_TRAIL});

enum CompanyDisplayName { STB, ONE_KAMPONG_GELAM, NATIONAL_HERITAGE_BOARD }

final companyDisplayNameValues = EnumValues({
  "National Heritage Board": CompanyDisplayName.NATIONAL_HERITAGE_BOARD,
  "One Kampong Gelam": CompanyDisplayName.ONE_KAMPONG_GELAM,
  "stb": CompanyDisplayName.STB
});

class Contact {
  Contact({
    this.primaryContactNo,
    this.secondaryContactNo,
  });

  String primaryContactNo;
  String secondaryContactNo;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        primaryContactNo: json["primaryContactNo"],
        secondaryContactNo: json["secondaryContactNo"],
      );

  Map<String, dynamic> toJson() => {
        "primaryContactNo": primaryContactNo,
        "secondaryContactNo": secondaryContactNo,
      };
}

enum Dataset { WALKING_TRAIL }

final datasetValues = EnumValues({"walking_trail": Dataset.WALKING_TRAIL});

enum Group { EMPTY, WELLNESS }

final groupValues = EnumValues({"": Group.EMPTY, "Wellness": Group.WELLNESS});

class Image {
  Image({
    this.url,
    this.uuid,
    this.libraryUuid,
    this.primaryFileMediumUuid,
  });

  String url;
  String uuid;
  String libraryUuid;
  PrimaryFileMediumUuid primaryFileMediumUuid;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        uuid: json["uuid"],
        libraryUuid: json["libraryUuid"],
        primaryFileMediumUuid:
            primaryFileMediumUuidValues.map[json["primaryFileMediumUuid"]],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "uuid": uuid,
        "libraryUuid": libraryUuid,
        "primaryFileMediumUuid":
            primaryFileMediumUuidValues.reverse[primaryFileMediumUuid],
      };
}

enum PrimaryFileMediumUuid {
  EMPTY,
  THE_107_F28_EB9_D8_BDD44_DB59_E2_C3_DABAA146_AAA,
  THE_1016_E74555_CC0_EA44_D1_B5_B08_BDE95_F7_F4_DB
}

final primaryFileMediumUuidValues = EnumValues({
  "": PrimaryFileMediumUuid.EMPTY,
  "1016e74555cc0ea44d1b5b08bde95f7f4db":
      PrimaryFileMediumUuid.THE_1016_E74555_CC0_EA44_D1_B5_B08_BDE95_F7_F4_DB,
  "107f28eb9d8bdd44db59e2c3dabaa146aaa":
      PrimaryFileMediumUuid.THE_107_F28_EB9_D8_BDD44_DB59_E2_C3_DABAA146_AAA
});

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

enum OfficialEmail { EMPTY, OFFICER_ONEKAMPONGGELAM_SG }

final officialEmailValues = EnumValues({
  "": OfficialEmail.EMPTY,
  "officer@onekamponggelam.sg": OfficialEmail.OFFICER_ONEKAMPONGGELAM_SG
});

enum SupportedLanguage { EN, ZH_CN, JA, KO }

final supportedLanguageValues = EnumValues({
  "EN": SupportedLanguage.EN,
  "JA": SupportedLanguage.JA,
  "KO": SupportedLanguage.KO,
  "ZH-CN": SupportedLanguage.ZH_CN
});

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
