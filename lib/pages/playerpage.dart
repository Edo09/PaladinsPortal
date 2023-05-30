import 'dart:convert';

import 'package:flutter/material.dart';
import '/pages/playerchamps.dart';
import '/pages/seematchdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/championranks.dart';
import '../classes/matchhistory.dart';
import '../classes/player.dart';
import 'package:intl/intl.dart';
import 'package:favorite_button/favorite_button.dart';

class PlayerProfile extends StatelessWidget {
  final formatter = NumberFormat("#,###");

  PlayerProfile({super.key});

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    PaladinsPlayer paladinsPlayer;
    List<ChampionRanks> championRanks;
    List<MatchHistory> matchHistory;
    DateFormat format = DateFormat('M/d/y h:m:s a');
    bool favorito;

    if (ModalRoute.of(context)?.settings.arguments == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Jugador no encontrado'),
        ),
      );
    } else {
      var datos = ModalRoute.of(context)?.settings.arguments as Set;
      paladinsPlayer = datos.first;
      championRanks = datos.elementAt(1);
      matchHistory = datos.elementAt(2);
      favorito = datos.last;
    }
//Calcualr WR Rankeds
    String winrateCal(int w, int l) {
      if (w != 0 || l != 0) {
        var wr = ((w / (l + w)) * 100).round();

        String wrfinal = '$wr%($w - $l)';
        return wrfinal;
      } else {
        return '0%';
      }
    }

    //FAVORITOS
    void saveFavoritesInf(int id, String? name, String level, String url) async {
      final SharedPreferences prefs = await _prefs;

      var usuario = [
        {"id": id, "nombre": name, "nivel": level, "url": url}
      ];
      //CREAR LISTA SI NO EXISTE
      if (prefs.getString('Favoritos') == null || prefs.getString('Favoritos') == '') {
        await prefs.setString('Favoritos', jsonEncode(usuario));
      } else {
        //SI EXISTE COMPROBAR SI USUARIO ESTA AGREGADO
        List<dynamic> favoritos = jsonDecode(prefs.getString('Favoritos').toString());

        Map remover = favoritos.firstWhere((element) => element['nombre'] == name, orElse: () {
          return {"nombre": "noesiste"};
        });

        if (remover['nombre'] == name) {
          //SI ESTA AGREGADO REMOVERLO
          favoritos.remove(remover);
          prefs.setString('Favoritos', jsonEncode(favoritos));
        } else {
          //SI NO ESTA AGREGADO AGREGARLO
          favoritos.addAll(usuario);
          prefs.setString('Favoritos', jsonEncode(favoritos));
        }
      }
      print("Final: ${prefs.getString('Favoritos')}");
    }

    String lastLoginTime(lastLoginDatetime) {
      DateTime date = format.parse(paladinsPlayer.lastLoginDatetime);
      Duration timeDifference = DateTime.now().difference(date);
      if (timeDifference.inDays > 0) {
        return ('Ultima conexión hace ${timeDifference.inDays} día(s)');
      } else if (timeDifference.inHours > 0) {
        return ('Ultima conexión hace ${timeDifference.inHours} horas');
      } else if (timeDifference.inMinutes > 0) {
        return ('Ultima conexión hace ${timeDifference.inMinutes} minutos');
      } else {
        return ('Ultima conexión menos de un minuto');
      }
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        actions: <Widget>[
          StarButton(
            isStarred: favorito == true ? true : false,
            iconSize: 45.0,
            valueChanged: (isStarred) {
              saveFavoritesInf(paladinsPlayer.activePlayerId, paladinsPlayer.hzPlayerName ?? paladinsPlayer.hzGamerTag,
                  paladinsPlayer.level.toString(), paladinsPlayer.avatarUrl.toString());
            },
          ),
          const SizedBox(
            width: 15,
          )
        ],
        backgroundColor: Colors.blue[800],
        title: Row(
          children: [
            Image.asset(
              'assets/${paladinsPlayer.platform.toString().toLowerCase().replaceAll(' ', '')}.png',
              width: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paladinsPlayer.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                Text(lastLoginTime(paladinsPlayer.lastLoginDatetime),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[300],
                    ))
              ],
            ),
          ],
        ),
      ),

      /*StarButton(
            isStarred: favorito == true ? true : false,
            iconSize: 45.0,
            valueChanged: (_isStarred) {
              saveFavoritesInf(paladinsPlayer.activePlayerId, paladinsPlayer.hzPlayerName ?? paladinsPlayer.hzGamerTag,
                  paladinsPlayer.level.toString(), paladinsPlayer.avatarUrl.toString());
            },
          )*/
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color.fromARGB(255, 40, 45, 51), Colors.blueAccent])),
                child: SizedBox(
                  height: 200.0,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            child: Image.network(
                              paladinsPlayer.avatarUrl.toString(),
                              width: 95,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  'https://raw.githubusercontent.com/luissilva1044894/hirez-api-docs/master/.assets/paladins/avatar/0.png',
                                  width: 75,
                                );
                              },
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fill,
                            child: Column(
                              children: [
                                Text(
                                  '${paladinsPlayer.hzGamerTag ?? paladinsPlayer.hzPlayerName} [${paladinsPlayer.level}]',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '"${paladinsPlayer.title}"',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.grey[300], fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              /*Image.asset(
                                'assets/${_paladinsPlayer.rankedKbm.tier}.png',
                                width: 20,
                              ),*/
                              Image(
                                image: AssetImage("assets/${paladinsPlayer.rankedKbm.tier}.png"),
                                width: 75,
                              ),
                              Text(
                                paladinsPlayer.rankedKbm.points.toString(),
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.blue[50],
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 11.5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Ganadas",
                                      style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      formatter.format(paladinsPlayer.wins).toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[800],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Perdidas",
                                      style: TextStyle(
                                        color: Colors.red[900],
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      formatter.format(paladinsPlayer.losses).toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[800],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Winrate",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      paladinsPlayer.wins == 0
                                          ? '0%'
                                          : '${((paladinsPlayer.wins / (paladinsPlayer.losses + paladinsPlayer.wins)) * 100).round()}%',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[800],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              color: Colors.blue[600],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      color: Colors.blue[50],
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 11),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Top Campeones',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var item in championRanks.length < 3
                                    ? championRanks.sublist(0, championRanks.length)
                                    : championRanks.sublist(0, 3))
                                  Expanded(
                                    child: Card(
                                      color: Colors.blue[100],
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          Image.network(
                                            'https://webcdn.hirezstudios.com/paladins/champion-icons/${item.champion.toLowerCase().replaceAll(' ', '-')}.jpg',
                                            width: 65,
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${item.champion}(${item.rank})',
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                          const Text('G-P',
                                              style: TextStyle(fontSize: 11.0, color: Colors.black, letterSpacing: 1)),
                                          Text(
                                            '${formatter.format(item.wins)} - ${formatter.format(item.losses)} (${((item.wins / (item.losses + item.wins)) * 100).round()}%)',
                                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const PlayerChampions(),
                                    settings: RouteSettings(arguments: {
                                      'champions': championRanks,
                                      'playername': paladinsPlayer.name.toString()
                                    })));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(const Color.fromARGB(255, 20, 115, 223)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Todos los campeones',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: paladinsPlayer.rankedKbm.tier == 0 && paladinsPlayer.rankedController.tier == 0,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.blue[50],
                        elevation: 5.0,
                        child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
                            child: Text('Sin Rango',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                ))),
                      ),
                    ),

                    //RANKED PC
                    Visibility(
                      visible: paladinsPlayer.rankedKbm.tier != 0,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.blue[50],
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 11),
                          child: Column(
                            children: [
                              const Text('Información de Rankeds (PC)',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('Rango',
                                          style: TextStyle(
                                              fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(returnTier(paladinsPlayer.rankedKbm.tier))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('WinRate',
                                          style: TextStyle(
                                              fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        winrateCal(paladinsPlayer.rankedKbm.wins, paladinsPlayer.rankedKbm.losses),
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[800],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('TP',
                                          style: TextStyle(
                                              fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(paladinsPlayer.rankedKbm.points.toString())
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Desertor',
                                          style: TextStyle(
                                              fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(paladinsPlayer.rankedKbm.leaves.toString())
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //RANKED CONSOLA
                    Visibility(
                      visible: paladinsPlayer.rankedController.tier != 0,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.blue[50],
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 11),
                          child: Column(
                            children: [
                              const Text('Información de Rankeds (Control)',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('Rango',
                                          style: TextStyle(
                                              fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(returnTier(paladinsPlayer.rankedController.tier))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('WinRate',
                                          style: TextStyle(
                                              fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        winrateCal(paladinsPlayer.rankedController.wins,
                                            paladinsPlayer.rankedController.losses),
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[800],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('TP',
                                          style: TextStyle(
                                              fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(paladinsPlayer.rankedController.points.toString())
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Desertor',
                                          style: TextStyle(
                                              fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(paladinsPlayer.rankedController.leaves.toString())
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //INFORMACION JUGADOR
                    Card(
                      clipBehavior: Clip.antiAlias,
                      color: Colors.blue[50],
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 11),
                        child: Column(
                          children: [
                            const Text('Información del jugador',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text('Cuenta creada',
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(returnCreatedDateTime(paladinsPlayer.createdDatetime.toString()))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Horas jugadas',
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(formatter.format(paladinsPlayer.hoursPlayed).toString())
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text('Desertor',
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(paladinsPlayer.leaves.toString())
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Campeones',
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(paladinsPlayer.masteryLevel.toString())
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Ultimas 15 partidas',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: matchHistory.length,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            color: Colors.blue[50],
                            elevation: 5.0,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SeeMatchDetails(),
                                    settings: RouteSettings(arguments: {
                                      'matchid': matchHistory[index].match.toString(),
                                      'mapgame': matchHistory[index].mapGame.toString()
                                    })));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                      image: const NetworkImage(
                                          "https://paladinsassets.com/loading-screens/Loading_TestMaps.png"),
                                      fit: BoxFit.fitWidth,
                                    )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Image.network(
                                            'https://webcdn.hirezstudios.com/paladins/champion-icons/${matchHistory[index].champion.toString().toLowerCase().replaceAll(' ', '-')}.jpg',
                                            width: 55,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Text('erro al cargar');
                                            },
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    matchHistory[index].champion.toString(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text('${matchHistory[index].minutes} minutos')
                                                ],
                                              ),
                                              Text(
                                                '${returnMapGame(matchHistory[index].mapGame.toString()).first}\n${returnMapGame(matchHistory[index].mapGame.toString()).last}',
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(fontSize: 15.0),
                                                overflow: TextOverflow.fade,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Spacer(),
                                          Text(matchHistory[index].winStatus == 'Win' ? 'G' : 'P',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    matchHistory[index].winStatus == 'Win' ? Colors.green : Colors.red,
                                              ))
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
                                                '${matchHistory[index].kills}/${matchHistory[index].deaths}/${matchHistory[index].assists}',
                                                style: const TextStyle(fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('Daño'),
                                            Text(formatter.format(matchHistory[index].damage).toString(),
                                                style: const TextStyle(fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('Curación'),
                                            Text(formatter.format(matchHistory[index].healing).toString(),
                                                style: const TextStyle(fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('Mitigación'),
                                            Text(formatter.format(matchHistory[index].damageMitigated).toString(),
                                                style: const TextStyle(fontWeight: FontWeight.bold))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> returnMapGame(String oldmapgame) {
  List mapgame = oldmapgame.split(' ');
  var cola = mapgame.first == 'LIVE' || mapgame.first == 'Practice' ? 'Casual' : 'Ranked';
  var mapanombre = mapgame.sublist(1, mapgame.length);
  var concatenate = StringBuffer();
  for (var item in mapanombre) {
    concatenate.write(' $item');
  }
  List<String> nombremapa = [cola, concatenate.toString()];

  return nombremapa;
}

String returnCreatedDateTime(String datetime) {
  final dateTime = DateTime.tryParse(datetime);

  if (dateTime == null) {
    print('Invalid date format: $datetime');
    return datetime.split(' ')[0];
  } else {
    final formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);
    print(formattedDate); // Output: 10/15/2016
    return formattedDate;
  }
}

String returnTier(int tier) {
  switch (tier) {
    case 1:
      return 'Bronze V';
    case 2:
      return 'Bronze IV';

    case 3:
      return 'Bronze III';

    case 4:
      return 'Bronze II';

    case 5:
      return 'Bronze I';

    case 6:
      return 'Plata V';

    case 7:
      return 'Plata IV';

    case 8:
      return 'Plata III';

    case 9:
      return 'Plata II';

    case 10:
      return 'Plata I';

    case 11:
      return 'Oro V';

    case 12:
      return 'Oro IV';

    case 13:
      return 'Oro III';

    case 14:
      return 'Oro II';

    case 15:
      return 'Oro I';

    case 16:
      return 'Platino V';

    case 17:
      return 'Platino IV';

    case 18:
      return 'Platino III';

    case 19:
      return 'Platino II';

    case 20:
      return 'Platino I';

    case 21:
      return 'Diamante V';

    case 22:
      return 'Diamante IV';

    case 23:
      return 'Diamante III';

    case 24:
      return 'Diamante II';

    case 25:
      return 'Diamante I';

    case 26:
      return 'Maestro';

    case 27:
      return 'Gran Maestro';

    default:
      return 'Sin Rango';
  }
}
