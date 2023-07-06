import 'dart:convert';

SendandReceiveData sendandReceiveDataFromJson(String str) =>
    SendandReceiveData.fromJson(json.decode(str));

String sendandReceiveDataToJson(SendandReceiveData data) =>
    json.encode(data.toJson());

class SendandReceiveData {
  int? code;
  String? message;
  List<Datum>? data;

  SendandReceiveData({
    this.code,
    this.message,
    this.data,
  });

  factory SendandReceiveData.fromJson(Map<String, dynamic> json) =>
      SendandReceiveData(
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
  String? date;
  String? time;
  String? msgType;
  String? ctrlMsg;
  String? ctrlDesc;
  String? status;
  String? msgCode;

  Datum({
    this.date,
    this.time,
    this.msgType,
    this.ctrlMsg,
    this.ctrlDesc,
    this.status,
    this.msgCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        time: json["time"],
        msgType: json["msgType"],
        ctrlMsg: json["ctrlMsg"],
        ctrlDesc: json["ctrlDesc"],
        status: json["status"],
        msgCode: json["msgCode"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "msgType": msgType,
        "ctrlMsg": ctrlMsg,
        "ctrlDesc": ctrlDesc,
        "status": status,
        "msgCode": msgCode,
      };
}
