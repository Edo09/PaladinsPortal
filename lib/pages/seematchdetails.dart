import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../classes/matchdetails.dart';
import '../classes/paladinsapi.dart';
import '../pages/playerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lookforplayer.dart';

class SeeMatchDetails extends StatefulWidget {
  const SeeMatchDetails({super.key});

  @override
  SeeMatchDetailsState createState() => SeeMatchDetailsState();
}

PlayerProfile playerPage = PlayerProfile();
final formatter = NumberFormat("#,###");
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

List names = [];

class SeeMatchDetailsState extends State<SeeMatchDetails> {
  @override
  Widget build(BuildContext context) {
    Future<List<MatchDetails>> setMatchDetails(String matchId) async {
      final SharedPreferences prefs = await _prefs;

      final List<MatchDetails> matchDetails =
          await PaladinsApi().getMatchDetails(matchId, prefs.getString('sessionid').toString());

      return matchDetails;
    }

    dynamic match = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('${returnMapGame(match['mapgame']).first}\n${returnMapGame(match['mapgame']).last}'),
          actions: [
            PopupMenuButton(
                icon: const Icon(Icons.book),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Match ID"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Detalles"),
                    )
                  ];
                },
                onSelected: (value) async {
                  if (value == 0) {
                    Clipboard.setData(ClipboardData(text: match['matchid']));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Match ID Copiado'),
                    ));
                  } else if (value == 1) {}
                }),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(bottom: 10),
          color: const Color.fromARGB(39, 202, 220, 224),
          child: FutureBuilder(
            future: setMatchDetails(match['matchid'].toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      if (index == 5) {
                        List<int> resultadoPartida = [
                          snapshot.data![index].team1Score,
                          snapshot.data![index].team2Score
                        ];
                        resultadoPartida.sort();
                        /* Tablero medio */
                        return Column(
                          children: [
                            Center(
                                child: Column(
                              children: [
                                Text(
                                  '${resultadoPartida.last} - ${resultadoPartida.first}',
                                  style: const TextStyle(fontSize: 25.0),
                                ),
                                Text(
                                  snapshot.data![index].region,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ],
                            )) /* Tablero medio */,
                            /*item 5 */
                            Card(
                              clipBehavior: Clip.antiAlias,
                              color: index >= 5 ? Colors.red[400] : Colors.blueAccent[200],
                              elevation: 5.0,
                              child: InkWell(
                                onTap: () {
                                  //cuenta Privada
                                  if (snapshot.data![index].activePlayerId == "0") {
                                  } else {
                                    try {
                                      setPlayer(snapshot.data![index].activePlayerId, context);
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
                                child: Column(
                                  children: [
                                    Container(
                                      decoration:
                                          BoxDecoration(color: index >= 5 ? Colors.red[300] : Colors.blueAccent[100]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Image.network(
                                                  'https://webcdn.hirezstudios.com/paladins/champion-icons/${snapshot.data![index].referenceName.toLowerCase().replaceAll(' ', '-')}.jpg',
                                                  width: 60,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    /*PLATAFORMA*/
                                                    Image.asset(
                                                      'assets/${snapshot.data![index].platform.toString().toLowerCase().replaceAll(' ', '')}.png',
                                                      width: 15,
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Text(
                                                      snapshot.data![index].playerName == ''
                                                          ? 'Cuenta Privada'
                                                          : snapshot.data![index].playerName,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                    ),
                                                    Text(' (${snapshot.data![index].accountLevel})'),
                                                    Text(
                                                      ' P${snapshot.data![index].partyId.toString()}',
                                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Image.asset(
                                                  'assets/talentos/Talent_${snapshot.data![index].referenceName.replaceAll(' ', '_')}_${snapshot.data![index].itemPurch6.replaceAll(' ', '').trim()}.png',
                                                  width: 50,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return const Text(' ');
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DefaultTextStyle(
                                      style: const TextStyle(fontSize: 17.5, color: Colors.black),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              const Text('KDA'),
                                              Text(
                                                  '${snapshot.data![index].killsPlayer}/${snapshot.data![index].deaths}/${snapshot.data![index].assists}',
                                                  style: const TextStyle(fontWeight: FontWeight.bold))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('Daño'),
                                              Text(formatter.format(snapshot.data![index].damagePlayer).toString(),
                                                  style: const TextStyle(fontWeight: FontWeight.bold))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('Mitigación'),
                                              Text(formatter.format(snapshot.data![index].damageMitigated).toString(),
                                                  style: const TextStyle(fontWeight: FontWeight.bold))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('Curación'),
                                              Text(formatter.format(snapshot.data![index].healing).toString(),
                                                  style: const TextStyle(fontWeight: FontWeight.bold))
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ), /*item 5 */
                          ],
                        );
                      }
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        color: index >= 5 ? Colors.red[400] : Colors.blueAccent[200],
                        elevation: 5.0,
                        child: InkWell(
                          onTap: () {
                            print(snapshot.data![index].activePlayerId);
                            if (snapshot.data![index].activePlayerId == "0") {
                              print("Cuenta privada");
                            } else {
                              try {
                                setPlayer(snapshot.data![index].activePlayerId, context);
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
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(color: index >= 5 ? Colors.red[300] : Colors.blueAccent[100]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Image.network(
                                            'https://webcdn.hirezstudios.com/paladins/champion-icons/${snapshot.data![index].referenceName.toLowerCase().replaceAll(' ', '-')}.jpg',
                                            width: 60,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/${snapshot.data![index].platform.toString().toLowerCase().replaceAll(' ', '')}.png',
                                                width: 15,
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                snapshot.data![index].playerName == ''
                                                    ? 'Cuenta Privada'
                                                    : snapshot.data![index].playerName,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              Text(' (${snapshot.data![index].accountLevel})'),
                                              Text(
                                                ' P${snapshot.data![index].partyId.toString()}',
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            'assets/talentos/Talent_${snapshot.data![index].referenceName.replaceAll(' ', '_')}_${snapshot.data![index].itemPurch6.replaceAll(' ', '')}.png',
                                            width: 50,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Text(' ');
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              DefaultTextStyle(
                                style: const TextStyle(fontSize: 17.5, color: Colors.black),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const Text('KDA'),
                                        Text(
                                            '${snapshot.data![index].killsPlayer}/${snapshot.data![index].deaths}/${snapshot.data![index].assists}',
                                            style: const TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text('Daño'),
                                        Text(formatter.format(snapshot.data![index].damagePlayer).toString(),
                                            style: const TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text('Mitigación'),
                                        Text(formatter.format(snapshot.data![index].damageMitigated).toString(),
                                            style: const TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text('Curación'),
                                        Text(formatter.format(snapshot.data![index].healing).toString(),
                                            style: const TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
