import 'dart:convert';

List<MatchDetails> matchDetailsFromJson(String str) =>
    List<MatchDetails>.from(json.decode(str).map((x) => MatchDetails.fromJson(x)));

String matchDetailsToJson(List<MatchDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchDetails {
  late int accountLevel;
  late int activeId1;
  late int activeId2;
  late int activeId3;
  late int activeId4;
  late int activeLevel1;
  late int activeLevel2;
  late int activeLevel3;
  late int activeLevel4;
  late String activePlayerId;
  late int assists;
  late int banId1;
  late int banId2;
  late int banId3;
  late int banId4;
  late dynamic ban1;
  late dynamic ban2;
  late dynamic ban3;
  late dynamic ban4;
  late int campsCleared;
  late int championId;
  late int damageBot;
  late int damageDoneInHand;
  late int damageDoneMagical;
  late int damageDonePhysical;
  late int damageMitigated;
  late int damagePlayer;
  late int damageTaken;
  late int damageTakenMagical;
  late int damageTakenPhysical;
  late int deaths;
  late int distanceTraveled;
  late String entryDatetime;
  late int finalMatchLevel;
  late int goldEarned;
  late int goldPerMinute;
  late int healing;
  late int healingBot;
  late int healingPlayerSelf;
  late int itemId1;
  late int itemId2;
  late int itemId3;
  late int itemId4;
  late int itemId5;
  late int itemId6;
  late int itemLevel1;
  late int itemLevel2;
  late int itemLevel3;
  late int itemLevel4;
  late int itemLevel5;
  late int itemLevel6;
  late String itemActive1;
  late String itemActive2;
  late String itemActive3;
  late String itemActive4;
  late String itemPurch1;
  late String itemPurch2;
  late String itemPurch3;
  late String itemPurch4;
  late String itemPurch5;
  late String itemPurch6;
  late int killingSpree;
  late int killsBot;
  late int killsDouble;
  late int killsFireGiant;
  late int killsFirstBlood;
  late int killsGoldFury;
  late int killsPenta;
  late int killsPhoenix;
  late int killsPlayer;
  late int killsQuadra;
  late int killsSiegeJuggernaut;
  late int killsSingle;
  late int killsTriple;
  late int killsWildJuggernaut;
  late int leagueLosses;
  late int leaguePoints;
  late int leagueTier;
  late int leagueWins;
  late String mapGame;
  late int masteryLevel;
  late int match;
  late int matchDuration;
  late List<MergedPlayers> mergedPlayers;
  late int minutes;
  late int multiKillMax;
  late int objectiveAssists;
  late int partyId;
  late String platform;
  late int rankStatLeague;
  late String referenceName;
  late String region;
  late String skin;
  late int skinId;
  late int structureDamage;
  late int surrendered;
  late int taskForce;
  late int team1Score;
  late int team2Score;
  late int teamId;
  late String teamName;
  late int timeInMatchSeconds;
  late int towersDestroyed;
  late int wardsPlaced;
  late String winStatus;
  late int winningTaskForce;
  late String hasReplay;
  late dynamic hzGamerTag;
  late dynamic hzPlayerName;
  late int matchQueueId;
  late String name;
  late String playerId;
  late String playerName;
  late dynamic playerPortalId;
  late dynamic playerPortalUserId;
  late dynamic retMsg;

  MatchDetails(
      {required this.accountLevel,
      required this.activeId1,
      required this.activeId2,
      required this.activeId3,
      required this.activeId4,
      required this.activeLevel1,
      required this.activeLevel2,
      required this.activeLevel3,
      required this.activeLevel4,
      required this.activePlayerId,
      required this.assists,
      required this.banId1,
      required this.banId2,
      required this.banId3,
      required this.banId4,
      required this.ban1,
      required this.ban2,
      required this.ban3,
      required this.ban4,
      required this.campsCleared,
      required this.championId,
      required this.damageBot,
      required this.damageDoneInHand,
      required this.damageDoneMagical,
      required this.damageDonePhysical,
      required this.damageMitigated,
      required this.damagePlayer,
      required this.damageTaken,
      required this.damageTakenMagical,
      required this.damageTakenPhysical,
      required this.deaths,
      required this.distanceTraveled,
      required this.entryDatetime,
      required this.finalMatchLevel,
      required this.goldEarned,
      required this.goldPerMinute,
      required this.healing,
      required this.healingBot,
      required this.healingPlayerSelf,
      required this.itemId1,
      required this.itemId2,
      required this.itemId3,
      required this.itemId4,
      required this.itemId5,
      required this.itemId6,
      required this.itemLevel1,
      required this.itemLevel2,
      required this.itemLevel3,
      required this.itemLevel4,
      required this.itemLevel5,
      required this.itemLevel6,
      required this.itemActive1,
      required this.itemActive2,
      required this.itemActive3,
      required this.itemActive4,
      required this.itemPurch1,
      required this.itemPurch2,
      required this.itemPurch3,
      required this.itemPurch4,
      required this.itemPurch5,
      required this.itemPurch6,
      required this.killingSpree,
      required this.killsBot,
      required this.killsDouble,
      required this.killsFireGiant,
      required this.killsFirstBlood,
      required this.killsGoldFury,
      required this.killsPenta,
      required this.killsPhoenix,
      required this.killsPlayer,
      required this.killsQuadra,
      required this.killsSiegeJuggernaut,
      required this.killsSingle,
      required this.killsTriple,
      required this.killsWildJuggernaut,
      required this.leagueLosses,
      required this.leaguePoints,
      required this.leagueTier,
      required this.leagueWins,
      required this.mapGame,
      required this.masteryLevel,
      required this.match,
      required this.matchDuration,
      required this.mergedPlayers,
      required this.minutes,
      required this.multiKillMax,
      required this.objectiveAssists,
      required this.partyId,
      required this.platform,
      required this.rankStatLeague,
      required this.referenceName,
      required this.region,
      required this.skin,
      required this.skinId,
      required this.structureDamage,
      required this.surrendered,
      required this.taskForce,
      required this.team1Score,
      required this.team2Score,
      required this.teamId,
      required this.teamName,
      required this.timeInMatchSeconds,
      required this.towersDestroyed,
      required this.wardsPlaced,
      required this.winStatus,
      required this.winningTaskForce,
      required this.hasReplay,
      required this.hzGamerTag,
      required this.hzPlayerName,
      required this.matchQueueId,
      required this.name,
      required this.playerId,
      required this.playerName,
      required this.playerPortalId,
      required this.playerPortalUserId,
      required this.retMsg});

  MatchDetails.fromJson(Map<String, dynamic> json) {
    accountLevel = json['Account_Level'];
    activeId1 = json['ActiveId1'];
    activeId2 = json['ActiveId2'];
    activeId3 = json['ActiveId3'];
    activeId4 = json['ActiveId4'];
    activeLevel1 = json['ActiveLevel1'];
    activeLevel2 = json['ActiveLevel2'];
    activeLevel3 = json['ActiveLevel3'];
    activeLevel4 = json['ActiveLevel4'];
    activePlayerId = json['ActivePlayerId'];
    assists = json['Assists'];
    banId1 = json['BanId1'];
    banId2 = json['BanId2'];
    banId3 = json['BanId3'];
    banId4 = json['BanId4'];
    ban1 = json['Ban_1'];
    ban2 = json['Ban_2'];
    ban3 = json['Ban_3'];
    ban4 = json['Ban_4'];
    campsCleared = json['Camps_Cleared'];
    championId = json['ChampionId'];
    damageBot = json['Damage_Bot'];
    damageDoneInHand = json['Damage_Done_In_Hand'];
    damageDoneMagical = json['Damage_Done_Magical'];
    damageDonePhysical = json['Damage_Done_Physical'];
    damageMitigated = json['Damage_Mitigated'];
    damagePlayer = json['Damage_Player'];
    damageTaken = json['Damage_Taken'];
    damageTakenMagical = json['Damage_Taken_Magical'];
    damageTakenPhysical = json['Damage_Taken_Physical'];
    deaths = json['Deaths'];
    distanceTraveled = json['Distance_Traveled'];
    entryDatetime = json['Entry_Datetime'];
    finalMatchLevel = json['Final_Match_Level'];
    goldEarned = json['Gold_Earned'];
    goldPerMinute = json['Gold_Per_Minute'];
    healing = json['Healing'];
    healingBot = json['Healing_Bot'];
    healingPlayerSelf = json['Healing_Player_Self'];
    itemId1 = json['ItemId1'];
    itemId2 = json['ItemId2'];
    itemId3 = json['ItemId3'];
    itemId4 = json['ItemId4'];
    itemId5 = json['ItemId5'];
    itemId6 = json['ItemId6'];
    itemLevel1 = json['ItemLevel1'];
    itemLevel2 = json['ItemLevel2'];
    itemLevel3 = json['ItemLevel3'];
    itemLevel4 = json['ItemLevel4'];
    itemLevel5 = json['ItemLevel5'];
    itemLevel6 = json['ItemLevel6'];
    itemActive1 = json['Item_Active_1'];
    itemActive2 = json['Item_Active_2'];
    itemActive3 = json['Item_Active_3'];
    itemActive4 = json['Item_Active_4'];
    itemPurch1 = json['Item_Purch_1'];
    itemPurch2 = json['Item_Purch_2'];
    itemPurch3 = json['Item_Purch_3'];
    itemPurch4 = json['Item_Purch_4'];
    itemPurch5 = json['Item_Purch_5'];
    itemPurch6 = json['Item_Purch_6'];
    killingSpree = json['Killing_Spree'];
    killsBot = json['Kills_Bot'];
    killsDouble = json['Kills_Double'];
    killsFireGiant = json['Kills_Fire_Giant'];
    killsFirstBlood = json['Kills_First_Blood'];
    killsGoldFury = json['Kills_Gold_Fury'];
    killsPenta = json['Kills_Penta'];
    killsPhoenix = json['Kills_Phoenix'];
    killsPlayer = json['Kills_Player'];
    killsQuadra = json['Kills_Quadra'];
    killsSiegeJuggernaut = json['Kills_Siege_Juggernaut'];
    killsSingle = json['Kills_Single'];
    killsTriple = json['Kills_Triple'];
    killsWildJuggernaut = json['Kills_Wild_Juggernaut'];
    leagueLosses = json['League_Losses'];
    leaguePoints = json['League_Points'];
    leagueTier = json['League_Tier'];
    leagueWins = json['League_Wins'];
    mapGame = json['Map_Game'];
    masteryLevel = json['Mastery_Level'];
    match = json['Match'];
    matchDuration = json['Match_Duration'];
    if (json['MergedPlayers'] != null) {
      mergedPlayers = <MergedPlayers>[];
      json['MergedPlayers'].forEach((v) {
        mergedPlayers.add(MergedPlayers.fromJson(v));
      });
    }
    minutes = json['Minutes'];
    multiKillMax = json['Multi_kill_Max'];
    objectiveAssists = json['Objective_Assists'];
    partyId = json['PartyId'];
    platform = json['Platform'];
    rankStatLeague = json['Rank_Stat_League'];
    referenceName = json['Reference_Name'];
    region = json['Region'];
    skin = json['Skin'];
    skinId = json['SkinId'];
    structureDamage = json['Structure_Damage'];
    surrendered = json['Surrendered'];
    taskForce = json['TaskForce'];
    team1Score = json['Team1Score'];
    team2Score = json['Team2Score'];
    teamId = json['TeamId'];
    teamName = json['Team_Name'];
    timeInMatchSeconds = json['Time_In_Match_Seconds'];
    towersDestroyed = json['Towers_Destroyed'];
    wardsPlaced = json['Wards_Placed'];
    winStatus = json['Win_Status'];
    winningTaskForce = json['Winning_TaskForce'];
    hasReplay = json['hasReplay'];
    hzGamerTag = json['hz_gamer_tag'];
    hzPlayerName = json['hz_player_name'];
    matchQueueId = json['match_queue_id'];
    name = json['name'];
    playerId = json['playerId'];
    playerName = json['playerName'];
    playerPortalId = json['playerPortalId'];
    playerPortalUserId = json['playerPortalUserId'];
    retMsg = json['ret_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Account_Level'] = accountLevel;
    data['ActiveId1'] = activeId1;
    data['ActiveId2'] = activeId2;
    data['ActiveId3'] = activeId3;
    data['ActiveId4'] = activeId4;
    data['ActiveLevel1'] = activeLevel1;
    data['ActiveLevel2'] = activeLevel2;
    data['ActiveLevel3'] = activeLevel3;
    data['ActiveLevel4'] = activeLevel4;
    data['ActivePlayerId'] = activePlayerId;
    data['Assists'] = assists;
    data['BanId1'] = banId1;
    data['BanId2'] = banId2;
    data['BanId3'] = banId3;
    data['BanId4'] = banId4;
    data['Ban_1'] = ban1;
    data['Ban_2'] = ban2;
    data['Ban_3'] = ban3;
    data['Ban_4'] = ban4;
    data['Camps_Cleared'] = campsCleared;
    data['ChampionId'] = championId;
    data['Damage_Bot'] = damageBot;
    data['Damage_Done_In_Hand'] = damageDoneInHand;
    data['Damage_Done_Magical'] = damageDoneMagical;
    data['Damage_Done_Physical'] = damageDonePhysical;
    data['Damage_Mitigated'] = damageMitigated;
    data['Damage_Player'] = damagePlayer;
    data['Damage_Taken'] = damageTaken;
    data['Damage_Taken_Magical'] = damageTakenMagical;
    data['Damage_Taken_Physical'] = damageTakenPhysical;
    data['Deaths'] = deaths;
    data['Distance_Traveled'] = distanceTraveled;
    data['Entry_Datetime'] = entryDatetime;
    data['Final_Match_Level'] = finalMatchLevel;
    data['Gold_Earned'] = goldEarned;
    data['Gold_Per_Minute'] = goldPerMinute;
    data['Healing'] = healing;
    data['Healing_Bot'] = healingBot;
    data['Healing_Player_Self'] = healingPlayerSelf;
    data['ItemId1'] = itemId1;
    data['ItemId2'] = itemId2;
    data['ItemId3'] = itemId3;
    data['ItemId4'] = itemId4;
    data['ItemId5'] = itemId5;
    data['ItemId6'] = itemId6;
    data['ItemLevel1'] = itemLevel1;
    data['ItemLevel2'] = itemLevel2;
    data['ItemLevel3'] = itemLevel3;
    data['ItemLevel4'] = itemLevel4;
    data['ItemLevel5'] = itemLevel5;
    data['ItemLevel6'] = itemLevel6;
    data['Item_Active_1'] = itemActive1;
    data['Item_Active_2'] = itemActive2;
    data['Item_Active_3'] = itemActive3;
    data['Item_Active_4'] = itemActive4;
    data['Item_Purch_1'] = itemPurch1;
    data['Item_Purch_2'] = itemPurch2;
    data['Item_Purch_3'] = itemPurch3;
    data['Item_Purch_4'] = itemPurch4;
    data['Item_Purch_5'] = itemPurch5;
    data['Item_Purch_6'] = itemPurch6;
    data['Killing_Spree'] = killingSpree;
    data['Kills_Bot'] = killsBot;
    data['Kills_Double'] = killsDouble;
    data['Kills_Fire_Giant'] = killsFireGiant;
    data['Kills_First_Blood'] = killsFirstBlood;
    data['Kills_Gold_Fury'] = killsGoldFury;
    data['Kills_Penta'] = killsPenta;
    data['Kills_Phoenix'] = killsPhoenix;
    data['Kills_Player'] = killsPlayer;
    data['Kills_Quadra'] = killsQuadra;
    data['Kills_Siege_Juggernaut'] = killsSiegeJuggernaut;
    data['Kills_Single'] = killsSingle;
    data['Kills_Triple'] = killsTriple;
    data['Kills_Wild_Juggernaut'] = killsWildJuggernaut;
    data['League_Losses'] = leagueLosses;
    data['League_Points'] = leaguePoints;
    data['League_Tier'] = leagueTier;
    data['League_Wins'] = leagueWins;
    data['Map_Game'] = mapGame;
    data['Mastery_Level'] = masteryLevel;
    data['Match'] = match;
    data['Match_Duration'] = matchDuration;
    data['MergedPlayers'] = mergedPlayers.map((v) => v.toJson()).toList();
    data['Minutes'] = minutes;
    data['Multi_kill_Max'] = multiKillMax;
    data['Objective_Assists'] = objectiveAssists;
    data['PartyId'] = partyId;
    data['Platform'] = platform;
    data['Rank_Stat_League'] = rankStatLeague;
    data['Reference_Name'] = referenceName;
    data['Region'] = region;
    data['Skin'] = skin;
    data['SkinId'] = skinId;
    data['Structure_Damage'] = structureDamage;
    data['Surrendered'] = surrendered;
    data['TaskForce'] = taskForce;
    data['Team1Score'] = team1Score;
    data['Team2Score'] = team2Score;
    data['TeamId'] = teamId;
    data['Team_Name'] = teamName;
    data['Time_In_Match_Seconds'] = timeInMatchSeconds;
    data['Towers_Destroyed'] = towersDestroyed;
    data['Wards_Placed'] = wardsPlaced;
    data['Win_Status'] = winStatus;
    data['Winning_TaskForce'] = winningTaskForce;
    data['hasReplay'] = hasReplay;
    data['hz_gamer_tag'] = hzGamerTag;
    data['hz_player_name'] = hzPlayerName;
    data['match_queue_id'] = matchQueueId;
    data['name'] = name;
    data['playerId'] = playerId;
    data['playerName'] = playerName;
    data['playerPortalId'] = playerPortalId;
    data['playerPortalUserId'] = playerPortalUserId;
    data['ret_msg'] = retMsg;
    return data;
  }

  void updateAttributes() {
    partyId = (0) + 1;
  }
}

class MergedPlayers {
  late String mergeDatetime;
  late String playerId;
  late String portalId;

  MergedPlayers({required this.mergeDatetime, required this.playerId, required this.portalId});

  MergedPlayers.fromJson(Map<String, dynamic> json) {
    mergeDatetime = json['merge_datetime'];
    playerId = json['playerId'];
    portalId = json['portalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merge_datetime'] = mergeDatetime;
    data['playerId'] = playerId;
    data['portalId'] = portalId;
    return data;
  }
}
