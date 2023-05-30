// To parse this JSON data, do
//
//     final getplayeridsbygamertag = getplayeridsbygamertagFromJson(jsonString);

import 'dart:convert';

List<Getplayeridsbygamertag> getplayeridsbygamertagFromJson(String str) =>
    List<Getplayeridsbygamertag>.from(json.decode(str).map((x) => Getplayeridsbygamertag.fromJson(x)));

String getplayeridsbygamertagToJson(List<Getplayeridsbygamertag> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getplayeridsbygamertag {
  Getplayeridsbygamertag({
    required this.name,
    required this.playerId,
    required this.portal,
    required this.portalId,
    required this.privacyFlag,
    this.retMsg,
  });

  String? name;
  int? playerId;
  String? portal;
  String? portalId;
  String? privacyFlag;
  dynamic retMsg;

  factory Getplayeridsbygamertag.fromJson(Map<String, dynamic> json) => Getplayeridsbygamertag(
        name: json["Name"],
        playerId: json["player_id"],
        portal: json["portal"],
        portalId: json["portal_id"],
        privacyFlag: json["privacy_flag"],
        retMsg: json["ret_msg"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "player_id": playerId,
        "portal": portal,
        "portal_id": portalId,
        "privacy_flag": privacyFlag,
        "ret_msg": retMsg,
      };
}
