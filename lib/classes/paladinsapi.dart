import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import '/classes/getchampions.dart';
import '/classes/getidsbygamertag.dart';
import '/classes/playerloadouts.dart';
import '/classes/rankedleaderboard.dart';
import '/classes/searchplayer.dart';
import '/classes/serverstatus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'championranks.dart';
import 'matchdetails.dart';
import 'matchhistory.dart';
import 'player.dart';

class PaladinsApi {
  String devId = "3689";
  String authId = "0C8F72200C284878AF806B2ABD05BCFF";
  String apiUrl = 'https://api.paladins.com/paladinsapi.svc';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getSession() async {
    String request = 'createsessionJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);
    String sessionId;
    try {
      String hashedsignature = md5.convert(utf8.encode('${devId}createsession$authId$formatted')).toString();
      var url = Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$formatted');

      var response = await http.get(url);

      Map data = jsonDecode(response.body);
      sessionId = data['session_id'];
    } catch (e) {
      return '';
    }

    return sessionId;
  }

  Future<List<ServerStatus>> getServerStatus(String sessionid) async {
    String request = 'gethirezserverstatusJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);

    List<ServerStatus>? serverStatus;

    String hashedsignature = md5.convert(utf8.encode('${devId}gethirezserverstatus$authId$formatted')).toString();

    var response = await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted'));

    serverStatus = serverStatusFromJson(response.body);
    print('serverstatus');

    return serverStatus;
  }

  Future<PaladinsPlayer?> getPlayer(String playername, String sessionid) async {
    String request = 'getplayerJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);

    PaladinsPlayer? paladinsPlayer;

    String hashedsignature = md5.convert(utf8.encode('${devId}getplayer$authId$formatted')).toString();

    try {
      var response =
          await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/$playername'));
      if (response.statusCode == 200) {
        var jsonString = response.body.substring(1, response.body.length - 1);
        var jsonMap = json.decode(jsonString);
        paladinsPlayer = PaladinsPlayer.fromJson(jsonMap);
      }
    } catch (exception) {
      print(exception);

      exit;
      return paladinsPlayer;
    }

    return paladinsPlayer;
  }

  Future<List<Getplayeridsbygamertag>> getplayeridsbygamertag(String sessionid, int portalid, String gamertag) async {
    String request = 'getplayeridsbygamertagJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);

    List<Getplayeridsbygamertag>? idsbygamertag;

    String hashedsignature = md5.convert(utf8.encode('${devId}getplayeridsbygamertag$authId$formatted')).toString();

    var response =
        await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/$portalid/$gamertag'));

    if (getplayeridsbygamertagFromJson(response.body).length > 7) {
      idsbygamertag = getplayeridsbygamertagFromJson(response.body).sublist(0, 7);
    } else {
      idsbygamertag = getplayeridsbygamertagFromJson(response.body);
    }

    return idsbygamertag;
  }

  Future<List<RankedLeaderboard>> getRankedLeaderBoard(String sessionid, {String queue = '486', int tier = 26}) async {
    String request = 'getleagueleaderboardJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);

    List<RankedLeaderboard>? topranked;

    String hashedsignature = md5.convert(utf8.encode('${devId}getleagueleaderboard$authId$formatted')).toString();

    var response =
        await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/$queue/$tier/1'));

    topranked = rankedLeaderboardFromJson(response.body);
    print('leaderboard');

    return topranked;
  }

  Future<List<SearchPlayer>> searchPlayer(String sessionid, String gamertag) async {
    String request = 'searchplayersJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);

    List<SearchPlayer>? playersearched;

    String hashedsignature = md5.convert(utf8.encode('${devId}searchplayers$authId$formatted')).toString();

    var response =
        await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/$gamertag'));

    playersearched = searchPlayerFromJson(response.body);

    return playersearched;
  }

  Future<List<PlayerLoadouts>> getPlayerLoadouts(String sessionid, String playerid) async {
    String request = 'getplayerloadoutsJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);

    List<PlayerLoadouts>? playerloadouts;

    String hashedsignature = md5.convert(utf8.encode('${devId}getplayerloadouts$authId$formatted')).toString();

    var response =
        await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/$playerid/7'));

    playerloadouts = playerLoadoutsFromJson(response.body);

    return playerloadouts;
  }

  Future<PaladinsPlayer> getPlayerbyId(int id, String sessionid) async {
    String request = 'getplayerJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);
    // ignore: avoid_init_to_null
    var paladinsPlayer = null;

    String hashedsignature = md5.convert(utf8.encode('${devId}getplayer$authId$formatted')).toString();

    try {
      var response = await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/$id'));
      if (response.statusCode == 200) {
        var jsonString = response.body.substring(1, response.body.length - 1);
        var jsonMap = json.decode(jsonString);
        paladinsPlayer = PaladinsPlayer.fromJson(jsonMap);
      }
    } catch (exception) {
      print(exception);

      exit;

      return paladinsPlayer;
    }
    print('playerid');
    return paladinsPlayer;
  }

  Future<List<ChampionRanks>> getChampionRanks(String playername, String sessionid) async {
    String request = 'getchampionranksJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);

    List<ChampionRanks>? championRanks;

    String hashedsignature = md5.convert(utf8.encode('${devId}getchampionranks$authId$formatted')).toString();

    var response =
        await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/$playername'));
    championRanks = championRanksFromJson(response.body);

    return championRanks;
  }

  Future<List<GetChampions>> getChampions(String sessionid) async {
    String request = 'getchampionsJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);

    List<GetChampions>? getchampions;

    String hashedsignature = md5.convert(utf8.encode('${devId}getchampions$authId$formatted')).toString();

    var response = await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/1'));
    getchampions = getChampionsFromJson(response.body);

    print('getchampions');

    return getchampions;
  }

  Future<List<MatchHistory>> getMatchHistory(String playername, String sessionid) async {
    String request = 'getmatchhistoryJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);
    List<MatchHistory>? matchHistory;

    String hashedsignature = md5.convert(utf8.encode('${devId}getmatchhistory$authId$formatted')).toString();

    var response =
        await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/$playername'));

    if (response.body.contains("No Match History")) {
      matchHistory = matchHistoryFromJson(response.body);
      print('sin historial');
    } else {
      if (matchHistoryFromJson(response.body).length < 15) {
        matchHistory = matchHistoryFromJson(response.body).sublist(0, matchHistoryFromJson(response.body).length);
      } else {
        matchHistory = matchHistoryFromJson(response.body).sublist(0, 15);
      }
    }

    return matchHistory;
  }

  Future<List<MatchDetails>> getMatchDetails(String matchid, String sessionid) async {
    String request = 'getmatchdetailsJson';
    DateTime now = DateTime.now().toUtc();
    DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    String formatted = formatter.format(now);
    List<MatchDetails> matchDetails;

    String hashedsignature = md5.convert(utf8.encode('${devId}getmatchdetails$authId$formatted')).toString();

    var response = await http.get(Uri.parse('$apiUrl/$request/$devId/$hashedsignature/$sessionid/$formatted/$matchid'));

    matchDetails = matchDetailsFromJson(response.body);

    return matchDetails;
  }

  Future<String> setupsession() async {
    final SharedPreferences prefs = await _prefs;

    String todayMinutes() {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd HH:mm');
      String formattedDate = formatter.format(now);
      return formattedDate;
    }

    int minutesBetween(String from, String to) {
      DateTime dateTimeFrom = DateTime.parse(from);
      DateTime dateTimeto = DateTime.parse(to);

      int difference = dateTimeto.difference(dateTimeFrom).inMinutes;

      if (difference.isNegative) {
        difference = 15;
      }
      return difference;
    }

    if (prefs.getString('sessionid') == null ||
        prefs.getString('sessionid')!.isEmpty ||
        prefs.getString('sessiontime').toString() == 'null') {
      //INICIAR NUEVA SESSION
      prefs.setString('sessiontime', todayMinutes());
      prefs.setString('sessionid', await getSession());
      print('Nueva session');
    } else {
      if (minutesBetween(prefs.getString('sessiontime').toString(), todayMinutes()) > 15 ||
          minutesBetween(prefs.getString('sessiontime').toString(), todayMinutes()).isNegative ||
          minutesBetween(prefs.getString('sessiontime').toString(), todayMinutes()).isNaN) {
        //RENICIAR SESSION
        prefs.remove('sessiontime');

        prefs.setString('sessiontime', todayMinutes());
        prefs.setString('sessionid', await getSession());

        print('Session Reiniciada');
      } else {
        //SESSION SIGUE ACTIVA
        print('Session activa');
      }
    }
    print(prefs.getString('sessiontime').toString());
    print('Tiempo de la session ${minutesBetween(prefs.getString('sessiontime').toString(), todayMinutes())}');
    print('${prefs.getString('sessionid')}');
    return prefs.getString('sessionid').toString();
  }
}
