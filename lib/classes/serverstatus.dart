// To parse this JSON data, do
//
//     final serverStatus = serverStatusFromJson(jsonString);

import 'dart:convert';

List<ServerStatus> serverStatusFromJson(String str) =>
    List<ServerStatus>.from(json.decode(str).map((x) => ServerStatus.fromJson(x)));

String serverStatusToJson(List<ServerStatus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServerStatus {
  ServerStatus({
    required this.entryDatetime,
    required this.environment,
    required this.limitedAccess,
    required this.platform,
    this.retMsg,
    required this.status,
    required this.version,
  });

  String? entryDatetime;
  String? environment;
  bool? limitedAccess;
  String? platform;
  dynamic retMsg;
  String? status;
  String? version;

  factory ServerStatus.fromJson(Map<String, dynamic> json) => ServerStatus(
        entryDatetime: json["entry_datetime"],
        environment: json["environment"],
        limitedAccess: json["limited_access"],
        platform: json["platform"],
        retMsg: json["ret_msg"],
        status: json["status"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "entry_datetime": entryDatetime,
        "environment": environment,
        "limited_access": limitedAccess,
        "platform": platform,
        "ret_msg": retMsg,
        "status": status,
        "version": version,
      };
}
