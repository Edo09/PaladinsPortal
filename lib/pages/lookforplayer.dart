import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/pages/home.dart';
import '../classes/serverstatus.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../classes/getidsbygamertag.dart';
import '../classes/championranks.dart';
import '../classes/matchhistory.dart';
import '../classes/paladinsapi.dart';
import '../classes/player.dart';

import '../classes/searchplayer.dart';
import 'playerpage.dart';

class LookforPlayer extends StatefulWidget {
  final Future<List<ServerStatus>> estadoserver;
  const LookforPlayer({super.key, required this.estadoserver});

  @override
  LookforPlayerState createState() => LookforPlayerState();
}

class LookforPlayerState extends State<LookforPlayer> with WidgetsBindingObserver {
  var myController = TextEditingController();
  bool _validate = false;
  Future<List<ServerStatus>>? serverStatus;
  late List<Getplayeridsbygamertag> idbygamertag;
  int platform = 5;
  List<Getplayeridsbygamertag> itemList = [];

  final ButtonStyle style = ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: const Color.fromRGBO(46, 176, 209, 82),
      textStyle: const TextStyle(fontSize: 18));

  @override
  Widget build(BuildContext context) {
    serverStatus = widget.estadoserver;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Buscar jugador'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Image.asset(
                'assets/paladins-white4.png',
                scale: 1.8,
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                  hintText: 'Jugador...',
                  contentPadding: const EdgeInsets.all(1),
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
                  errorText: _validate ? 'Nombre del jugador' : null),
              controller: myController,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    setState(() {
                      myController.text.isEmpty ? _validate = true : _validate = false;
                    });
                    if (_validate == false) {
                      //Ocultar Teclado
                      FocusScope.of(context).requestFocus(FocusNode());

                      try {
                        setPlayer(myController.text, context);
                      } catch (e) {
                        Navigator.of(context, rootNavigator: true).pop();
                        final snackBar = SnackBar(
                          content: const Text('Error al conectar'),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: const Text('Buscar'),
                ),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    setState(() {
                      myController.text.isEmpty ? _validate = true : _validate = false;
                    });
                    if (_validate == false) {
                      //Ocultar Teclado
                      FocusScope.of(context).requestFocus(FocusNode());
                      var searchplayeresults = searchforPlayer(myController.text);
                      showModalBottomSheet<void>(
                        context: context,
                        useSafeArea: true,
                        anchorPoint: const Offset(0, 0),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              height: 400,
                              child: FutureBuilder(
                                future: searchplayeresults,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.isEmpty) {
                                      return const Text('Usuario no encontrado');
                                    }
                                    return GridView.builder(
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        childAspectRatio: 1.5,
                                      ),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return GridTile(
                                            child: InkWell(
                                          onTap: () {
                                            try {
                                              setPlayer(snapshot.data![index].playerId.toString(), context);
                                            } catch (e) {
                                              Navigator.of(context, rootNavigator: true).pop();
                                              final snackBar = SnackBar(
                                                content: const Text('Usuario invalido'),
                                                action: SnackBarAction(
                                                  label: 'Ok',
                                                  onPressed: () {},
                                                ),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            }
                                          },
                                          child: Card(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 8),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                      width: 30, portalicon(snapshot.data![index].portalId.toString())),
                                                  Text(
                                                    overflow: TextOverflow.clip,
                                                    snapshot.data![index].name.toString(),
                                                  ),
                                                  Text(
                                                    snapshot.data![index].playerId.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15, fontStyle: FontStyle.italic, color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                      },
                                    );
                                  } else if (snapshot.hasError) {}

                                  // By default, show a loading spinner
                                  return const SizedBox();
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Explorar'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Servidores', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder<List<ServerStatus>>(
                future: serverStatus,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GridTile(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              child: ListTile(
                                minLeadingWidth: 40,
                                horizontalTitleGap: 0,
                                minVerticalPadding: 0,
                                isThreeLine: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 13),
                                leading: Image.asset(width: 30, portalicon2(snapshot.data![index].platform.toString())),
                                subtitle: Text(
                                  snapshot.data![index].version.toString(),
                                ),
                                title: Text(
                                  toBeginningOfSentenceCase(snapshot.data![index].environment).toString(),
                                ),
                                trailing: Icon(
                                  Icons.radio_button_checked,
                                  color: snapshot.data![index].status == 'UP' ? Colors.green : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

String portalicon(String portalid) {
  String plataforma;

  switch (portalid) {
    case '1':
      plataforma = 'hirez';
      break;
    case '5':
      plataforma = 'steam';
      break;
    case '9':
      plataforma = 'psn';
      break;
    case '10':
      plataforma = 'xboxlive';
      break;
    case '22':
      plataforma = 'nintendoswitch';
      break;
    case '25':
      plataforma = 'steam'; //DISCORD
      break;
    case '28':
      plataforma = 'epicgames';
      break;
    default:
      plataforma = 'steam';
  }

  return 'assets/$plataforma.png';
}

String portalicon2(String platform) {
  String plataforma;

  switch (platform) {
    case 'pc':
      plataforma = 'steam';
      break;
    case 'ps4':
      plataforma = 'psn';
      break;
    case 'xbox':
      plataforma = 'xboxlive';
      break;
    case 'switch':
      plataforma = 'nintendoswitch';
      break;
    default:
      plataforma = 'steam';
  }

  return 'assets/$plataforma.png';
}

Future<List<SearchPlayer>> searchforPlayer(String gamertag) async {
  List<SearchPlayer> idbygamertag;
  idbygamertag = await PaladinsApi().searchPlayer(await PaladinsApi().setupsession(), gamertag);
  return idbygamertag;
}

void setPlayer(playername, context) async {
  final currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Cargando...')
                ],
              ),
            ),
          ),
        );
      });
  final prefs = await SharedPreferences.getInstance();
  PaladinsPlayer? paladinsPlayer;
  List<ChampionRanks> championRanks;
  List<MatchHistory> matchHistory;
  bool favorito;
  String sessionid = await PaladinsApi().setupsession();
  DateFormat format = DateFormat('M/d/y h:m:s a');
  DateTime now = DateTime.now();
  try {
    paladinsPlayer = await PaladinsApi().getPlayer(playername, sessionid);
    DateTime date = format.parse(paladinsPlayer!.lastLoginDatetime);
    Duration difference = now.difference(date);
    int days = difference.inDays.abs();
    if (days > 350) {
      Navigator.of(context, rootNavigator: true).pop();
      final snackBar = SnackBar(
        content: const Text('Usuario Inactivo'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    matchHistory = await PaladinsApi().getMatchHistory(playername, sessionid);
    championRanks = await PaladinsApi().getChampionRanks(playername, sessionid);
    String favoritos = prefs.getString('Favoritos').toString();

    favoritos.split(',');
    if (favoritos.contains(paladinsPlayer.activePlayerId.toString())) {
      favorito = true;
    } else {
      favorito = false;
    }

    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlayerProfile(),
        settings: RouteSettings(arguments: {paladinsPlayer, championRanks, matchHistory, favorito})));
  } catch (e) {
    final snackBar = SnackBar(
      content: const Text('Usuario Inválido'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context, rootNavigator: true).pop();
  }
}
