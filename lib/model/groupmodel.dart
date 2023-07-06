// To parse this JSON data, do
//
//     final groupData = groupDataFromJson(jsonString);

import 'dart:convert';

GroupData groupDataFromJson(String str) => GroupData.fromJson(json.decode(str));

String groupDataToJson(GroupData data) => json.encode(data.toJson());

class GroupData {
  int? code;
  String? message;
  List<Datum>? data;

  GroupData({
    this.code,
    this.message,
    this.data,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? userGroupId;
  int? userId;
  String? groupName;

  Datum({
    this.userGroupId,
    this.userId,
    this.groupName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userGroupId: json["userGroupId"],
        userId: json["userId"],
        groupName: json["groupName"],
      );

  Map<String, dynamic> toJson() => {
        "userGroupId": userGroupId,
        "userId": userId,
        "groupName": groupName,
      };
}
