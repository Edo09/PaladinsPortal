// To parse this JSON data, do
//
//     final paladinsPlayer = paladinsPlayerFromJson(jsonString);
import 'dart:convert';

PaladinsPlayer playerFromJson(String str) => PaladinsPlayer.fromJson(json.decode(str));

String playerToJson(PaladinsPlayer data) => json.encode(data.toJson());

class PaladinsPlayer {
  PaladinsPlayer({
    required this.activePlayerId,
    required this.avatarId,
    required this.avatarUrl,
    required this.createdDatetime,
    required this.hoursPlayed,
    required this.id,
    required this.lastLoginDatetime,
    required this.leaves,
    required this.level,
    required this.loadingFrame,
    required this.losses,
    required this.masteryLevel,
    required this.mergedPlayers,
    required this.minutesPlayed,
    required this.name,
    required this.personalStatusMessage,
    required this.platform,
    required this.rankedConquest,
    required this.rankedController,
    required this.rankedKbm,
    required this.region,
    required this.teamId,
    required this.teamName,
    required this.tierConquest,
    required this.tierRankedController,
    required this.tierRankedKbm,
    required this.title,
    required this.totalAchievements,
    required this.totalWorshippers,
    required this.totalXp,
    required this.wins,
    required this.hzGamerTag,
    required this.hzPlayerName,
    required this.retMsg,
  });

  int activePlayerId;
  int avatarId;
  String? avatarUrl;
  String createdDatetime;
  int hoursPlayed;
  int id;
  String lastLoginDatetime;
  int leaves;
  int level;
  String? loadingFrame;
  int losses;
  int masteryLevel;
  dynamic mergedPlayers;
  int minutesPlayed;
  String name;
  String personalStatusMessage;
  String platform;
  Ranked rankedConquest;
  Ranked rankedController;
  Ranked rankedKbm;
  String region;
  int teamId;
  String teamName;
  int tierConquest;
  int tierRankedController;
  int tierRankedKbm;
  String? title;
  int totalAchievements;
  int totalWorshippers;
  int totalXp;
  int wins;
  String? hzGamerTag;
  String? hzPlayerName;
  dynamic retMsg;

  factory PaladinsPlayer.fromJson(Map<String, dynamic> json) => PaladinsPlayer(
        activePlayerId: json["ActivePlayerId"],
        avatarId: json["AvatarId"],
        avatarUrl: json["AvatarURL"],
        createdDatetime: json["Created_Datetime"],
        hoursPlayed: json["HoursPlayed"],
        id: json["Id"],
        lastLoginDatetime: json["Last_Login_Datetime"],
        leaves: json["Leaves"],
        level: json["Level"],
        loadingFrame: json["LoadingFrame"],
        losses: json["Losses"],
        masteryLevel: json["MasteryLevel"],
        mergedPlayers: json["MergedPlayers"],
        minutesPlayed: json["MinutesPlayed"],
        name: json["Name"],
        personalStatusMessage: json["Personal_Status_Message"],
        platform: json["Platform"],
        rankedConquest: Ranked.fromJson(json["RankedConquest"]),
        rankedController: Ranked.fromJson(json["RankedController"]),
        rankedKbm: Ranked.fromJson(json["RankedKBM"]),
        region: json["Region"],
        teamId: json["TeamId"],
        teamName: json["Team_Name"],
        tierConquest: json["Tier_Conquest"],
        tierRankedController: json["Tier_RankedController"],
        tierRankedKbm: json["Tier_RankedKBM"],
        title: json["Title"],
        totalAchievements: json["Total_Achievements"],
        totalWorshippers: json["Total_Worshippers"],
        totalXp: json["Total_XP"],
        wins: json["Wins"],
        hzGamerTag: json["hz_gamer_tag"],
        hzPlayerName: json["hz_player_name"],
        retMsg: json["ret_msg"],
      );

  Map<String, dynamic> toJson() => {
        "ActivePlayerId": activePlayerId,
        "AvatarId": avatarId,
        "AvatarURL": avatarUrl,
        "Created_Datetime": createdDatetime,
        "HoursPlayed": hoursPlayed,
        "Id": id,
        "Last_Login_Datetime": lastLoginDatetime,
        "Leaves": leaves,
        "Level": level,
        "LoadingFrame": loadingFrame,
        "Losses": losses,
        "MasteryLevel": masteryLevel,
        "MergedPlayers": mergedPlayers,
        "MinutesPlayed": minutesPlayed,
        "Name": name,
        "Personal_Status_Message": personalStatusMessage,
        "Platform": platform,
        "RankedConquest": rankedConquest.toJson(),
        "RankedController": rankedController.toJson(),
        "RankedKBM": rankedKbm.toJson(),
        "Region": region,
        "TeamId": teamId,
        "Team_Name": teamName,
        "Tier_Conquest": tierConquest,
        "Tier_RankedController": tierRankedController,
        "Tier_RankedKBM": tierRankedKbm,
        "Title": title,
        "Total_Achievements": totalAchievements,
        "Total_Worshippers": totalWorshippers,
        "Total_XP": totalXp,
        "Wins": wins,
        "hz_gamer_tag": hzGamerTag,
        "hz_player_name": hzPlayerName,
        "ret_msg": retMsg,
      };
}

class Ranked {
  Ranked({
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
    required this.retMsg,
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
  dynamic playerId;
  dynamic retMsg;

  factory Ranked.fromJson(Map<String, dynamic> json) => Ranked(
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
