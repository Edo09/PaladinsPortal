// To parse this JSON data, do
//
//     final rankedLeaderboard = rankedLeaderboardFromJson(jsonString);

import 'dart:convert';

List<RankedLeaderboard> rankedLeaderboardFromJson(String str) =>
    List<RankedLeaderboard>.from(json.decode(str).map((x) => RankedLeaderboard.fromJson(x)));

String rankedLeaderboardToJson(List<RankedLeaderboard> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RankedLeaderboard {
  RankedLeaderboard({
    required this.leaves,
    required this.losses,
    required this.name,
    required this.points,
    required this.prevRank,
    required this.rank,
    required this.season,
    required this.tier,
    required this.trend,
    required this.wins,
    required this.playerId,
    this.retMsg,
  });

  int leaves;
  int losses;
  String name;
  int points;
  int prevRank;
  int rank;
  int season;
  int tier;
  int trend;
  int wins;
  String playerId;
  dynamic retMsg;

  factory RankedLeaderboard.fromJson(Map<String, dynamic> json) => RankedLeaderboard(
        leaves: json["Leaves"],
        losses: json["Losses"],
        name: json["Name"],
        points: json["Points"],
        prevRank: json["PrevRank"],
        rank: json["Rank"],
        season: json["Season"],
        tier: json["Tier"],
        trend: json["Trend"],
        wins: json["Wins"],
        playerId: json["player_id"],
        retMsg: json["ret_msg"],
      );

  Map<String, dynamic> toJson() => {
        "Leaves": leaves,
        "Losses": losses,
        "Name": name,
        "Points": points,
        "PrevRank": prevRank,
        "Rank": rank,
        "Season": season,
        "Tier": tier,
        "Trend": trend,
        "Wins": wins,
        "player_id": playerId,
        "ret_msg": retMsg,
      };
}
