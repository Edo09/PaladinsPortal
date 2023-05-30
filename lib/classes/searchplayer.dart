// To parse this JSON data, do
//
//     final searchPlayer = searchPlayersFromJson(jsonString);

import 'dart:convert';

List<SearchPlayer> searchPlayerFromJson(String str) =>
    List<SearchPlayer>.from(json.decode(str).map((x) => SearchPlayer.fromJson(x)));

String searchPlayerToJson(List<SearchPlayer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchPlayer {
  SearchPlayer({
    required this.name,
    this.hzPlayerName,
    required this.playerId,
    required this.portalId,
    required this.privacyFlag,
    this.retMsg,
  });

  String? name;
  String? hzPlayerName;
  String? playerId;
  String? portalId;
  String? privacyFlag;
  dynamic retMsg;

  factory SearchPlayer.fromJson(Map<String, dynamic> json) => SearchPlayer(
        name: json["Name"],
        hzPlayerName: json["hz_player_name"],
        playerId: json["player_id"],
        portalId: json["portal_id"],
        privacyFlag: json["privacy_flag"],
        retMsg: json["ret_msg"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "hz_player_name": hzPlayerName,
        "player_id": playerId,
        "portal_id": portalId,
        "privacy_flag": privacyFlag,
        "ret_msg": retMsg,
      };
}
