// To parse this JSON data, do
//
//     final playerLoadouts = playerLoadoutsFromJson(jsonString);

import 'dart:convert';

List<PlayerLoadouts> playerLoadoutsFromJson(String str) =>
    List<PlayerLoadouts>.from(json.decode(str).map((x) => PlayerLoadouts.fromJson(x)));

String playerLoadoutsToJson(List<PlayerLoadouts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlayerLoadouts {
  PlayerLoadouts({
    required this.championId,
    required this.championName,
    required this.deckId,
    required this.deckName,
    required this.loadoutItems,
    required this.playerId,
    required this.playerName,
    this.retMsg,
  });

  int championId;
  String championName;
  int deckId;
  String deckName;
  List<LoadoutItem> loadoutItems;
  int playerId;
  String playerName;
  dynamic retMsg;

  factory PlayerLoadouts.fromJson(Map<String, dynamic> json) => PlayerLoadouts(
        championId: json["ChampionId"],
        championName: json["ChampionName"],
        deckId: json["DeckId"],
        deckName: json["DeckName"],
        loadoutItems: List<LoadoutItem>.from(json["LoadoutItems"].map((x) => LoadoutItem.fromJson(x))),
        playerId: json["playerId"],
        playerName: json["playerName"],
        retMsg: json["ret_msg"],
      );

  Map<String, dynamic> toJson() => {
        "ChampionId": championId,
        "ChampionName": championName,
        "DeckId": deckId,
        "DeckName": deckName,
        "LoadoutItems": List<dynamic>.from(loadoutItems.map((x) => x.toJson())),
        "playerId": playerId,
        "playerName": playerName,
        "ret_msg": retMsg,
      };
}

class LoadoutItem {
  LoadoutItem({
    required this.itemId,
    required this.itemName,
    required this.points,
  });

  int itemId;
  String itemName;
  int points;

  factory LoadoutItem.fromJson(Map<String, dynamic> json) => LoadoutItem(
        itemId: json["ItemId"],
        itemName: json["ItemName"],
        points: json["Points"],
      );

  Map<String, dynamic> toJson() => {
        "ItemId": itemId,
        "ItemName": itemName,
        "Points": points,
      };
}
