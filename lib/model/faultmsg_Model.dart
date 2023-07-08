import 'dart:convert';

FaultmessageModel faultmessageModelFromJson(String str) =>
    FaultmessageModel.fromJson(json.decode(str));
String faultmessageModelToJson(FaultmessageModel data) =>
    json.encode(data.toJson());

class FaultmessageModel {
  int? code;
  String? message;
  List<FaultData>? data;

  FaultmessageModel({
    this.code,
    this.message,
    this.data,
  });

  factory FaultmessageModel.fromJson(Map<String, dynamic> json) =>
      FaultmessageModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<FaultData>.from(
                json["data"]!.map((x) => FaultData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FaultData {
  int? userId;
  int? controllerId;
  String? messageCode;
  String? controllerMessage;
  String? readStatus;
  String? messageType;
  String? messageDescription;
  String? ctrlDate;
  String? ctrlTime;

  FaultData({
    this.userId,
    this.controllerId,
    this.messageCode,
    this.controllerMessage,
    this.readStatus,
    this.messageType,
    this.messageDescription,
    this.ctrlDate,
    this.ctrlTime,
  });

  factory FaultData.fromJson(Map<String, dynamic> json) => FaultData(
        userId: json["userId"],
        controllerId: json["controllerId"],
        messageCode: json["messageCode"],
        controllerMessage: json["controllerMessage"],
        readStatus: json["readStatus"],
        messageType: json["messageType"],
        messageDescription: json["messageDescription"],
        ctrlDate: json["ctrlDate"],
        ctrlTime: json["ctrlTime"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "controllerId": controllerId,
        "messageCode": messageCode,
        "controllerMessage": controllerMessage,
        "readStatus": readStatus,
        "messageType": messageType,
        "messageDescription": messageDescription,
        "ctrlDate": ctrlDate,
        "ctrlTime": ctrlTime,
      };
}
