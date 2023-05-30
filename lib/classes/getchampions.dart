// To parse this JSON data, do
//
//     final getChampions = getChampionsFromJson(jsonString);

import 'dart:convert';

List<GetChampions> getChampionsFromJson(String str) =>
    List<GetChampions>.from(json.decode(str).map((x) => GetChampions.fromJson(x)));

String getChampionsToJson(List<GetChampions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetChampions {
  GetChampions({
    required this.ability1,
    required this.ability2,
    required this.ability3,
    required this.ability4,
    required this.ability5,
    required this.abilityId1,
    required this.abilityId2,
    required this.abilityId3,
    required this.abilityId4,
    required this.abilityId5,
    required this.getChampionAbility1,
    required this.getChampionAbility2,
    required this.getChampionAbility3,
    required this.getChampionAbility4,
    required this.getChampionAbility5,
    required this.championAbility1Url,
    required this.championAbility2Url,
    required this.championAbility3Url,
    required this.championAbility4Url,
    required this.championAbility5Url,
    required this.championCardUrl,
    required this.championIconUrl,
    required this.cons,
    required this.health,
    required this.lore,
    required this.name,
    required this.nameEnglish,
    required this.onFreeRotation,
    required this.onFreeWeeklyRotation,
    required this.pantheon,
    required this.pros,
    required this.roles,
    required this.speed,
    required this.title,
    required this.type,
    required this.abilityDescription1,
    required this.abilityDescription2,
    required this.abilityDescription3,
    required this.abilityDescription4,
    required this.abilityDescription5,
    required this.id,
    required this.latestChampion,
    this.retMsg,
  });

  String ability1;
  String ability2;
  String ability3;
  String ability4;
  String ability5;
  int abilityId1;
  int abilityId2;
  int abilityId3;
  int abilityId4;
  int abilityId5;
  Ability getChampionAbility1;
  Ability getChampionAbility2;
  Ability getChampionAbility3;
  Ability getChampionAbility4;
  Ability getChampionAbility5;
  String championAbility1Url;
  String championAbility2Url;
  String championAbility3Url;
  String championAbility4Url;
  String championAbility5Url;
  String championCardUrl;
  String championIconUrl;
  String cons;
  int health;
  String lore;
  String name;
  String nameEnglish;
  String onFreeRotation;
  String onFreeWeeklyRotation;
  String pantheon;
  String pros;
  String roles;
  int speed;
  String title;
  String type;
  String abilityDescription1;
  String abilityDescription2;
  String abilityDescription3;
  String abilityDescription4;
  String abilityDescription5;
  int id;
  String latestChampion;
  dynamic retMsg;

  factory GetChampions.fromJson(Map<String, dynamic> json) => GetChampions(
        ability1: json["Ability1"],
        ability2: json["Ability2"],
        ability3: json["Ability3"],
        ability4: json["Ability4"],
        ability5: json["Ability5"],
        abilityId1: json["AbilityId1"],
        abilityId2: json["AbilityId2"],
        abilityId3: json["AbilityId3"],
        abilityId4: json["AbilityId4"],
        abilityId5: json["AbilityId5"],
        getChampionAbility1: Ability.fromJson(json["Ability_1"]),
        getChampionAbility2: Ability.fromJson(json["Ability_2"]),
        getChampionAbility3: Ability.fromJson(json["Ability_3"]),
        getChampionAbility4: Ability.fromJson(json["Ability_4"]),
        getChampionAbility5: Ability.fromJson(json["Ability_5"]),
        championAbility1Url: json["ChampionAbility1_URL"],
        championAbility2Url: json["ChampionAbility2_URL"],
        championAbility3Url: json["ChampionAbility3_URL"],
        championAbility4Url: json["ChampionAbility4_URL"],
        championAbility5Url: json["ChampionAbility5_URL"],
        championCardUrl: json["ChampionCard_URL"],
        championIconUrl: json["ChampionIcon_URL"],
        cons: json["Cons"],
        health: json["Health"],
        lore: json["Lore"],
        name: json["Name"],
        nameEnglish: json["Name_English"],
        onFreeRotation: json["OnFreeRotation"],
        onFreeWeeklyRotation: json["OnFreeWeeklyRotation"],
        pantheon: json["Pantheon"],
        pros: json["Pros"],
        roles: json["Roles"],
        speed: json["Speed"],
        title: json["Title"],
        type: json["Type"],
        abilityDescription1: json["abilityDescription1"],
        abilityDescription2: json["abilityDescription2"],
        abilityDescription3: json["abilityDescription3"],
        abilityDescription4: json["abilityDescription4"],
        abilityDescription5: json["abilityDescription5"],
        id: json["id"],
        latestChampion: json["latestChampion"],
        retMsg: json["ret_msg"],
      );

  Map<String, dynamic> toJson() => {
        "Ability1": ability1,
        "Ability2": ability2,
        "Ability3": ability3,
        "Ability4": ability4,
        "Ability5": ability5,
        "AbilityId1": abilityId1,
        "AbilityId2": abilityId2,
        "AbilityId3": abilityId3,
        "AbilityId4": abilityId4,
        "AbilityId5": abilityId5,
        "Ability_1": getChampionAbility1.toJson(),
        "Ability_2": getChampionAbility2.toJson(),
        "Ability_3": getChampionAbility3.toJson(),
        "Ability_4": getChampionAbility4.toJson(),
        "Ability_5": getChampionAbility5.toJson(),
        "ChampionAbility1_URL": championAbility1Url,
        "ChampionAbility2_URL": championAbility2Url,
        "ChampionAbility3_URL": championAbility3Url,
        "ChampionAbility4_URL": championAbility4Url,
        "ChampionAbility5_URL": championAbility5Url,
        "ChampionCard_URL": championCardUrl,
        "ChampionIcon_URL": championIconUrl,
        "Cons": cons,
        "Health": health,
        "Lore": lore,
        "Name": name,
        "Name_English": nameEnglish,
        "OnFreeRotation": onFreeRotation,
        "OnFreeWeeklyRotation": onFreeWeeklyRotation,
        "Pantheon": pantheon,
        "Pros": pros,
        "Roles": roles,
        "Speed": speed,
        "Title": title,
        "Type": type,
        "abilityDescription1": abilityDescription1,
        "abilityDescription2": abilityDescription2,
        "abilityDescription3": abilityDescription3,
        "abilityDescription4": abilityDescription4,
        "abilityDescription5": abilityDescription5,
        "id": id,
        "latestChampion": latestChampion,
        "ret_msg": retMsg,
      };
}

class Ability {
  Ability({
    required this.description,
    required this.id,
    required this.summary,
    required this.url,
    required this.damageType,
    required this.rechargeSeconds,
  });

  String description;
  int id;
  String summary;
  String url;
  String damageType;
  int rechargeSeconds;

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        description: json["Description"],
        id: json["Id"],
        summary: json["Summary"],
        url: json["URL"],
        damageType: json["damageType"],
        rechargeSeconds: json["rechargeSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "Description": description,
        "Id": id,
        "Summary": summary,
        "URL": url,
        "damageType": damageType,
        "rechargeSeconds": rechargeSeconds,
      };
}
