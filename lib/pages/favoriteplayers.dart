import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import '/pages/lookfordeck.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lookforplayer.dart';
import 'suggestionpage.dart';

class FavoritePlayers extends StatefulWidget {
  const FavoritePlayers({super.key});

  @override
  FavoritePlayersState createState() => FavoritePlayersState();
}

class FavoritePlayersState extends State<FavoritePlayers> {
  void removeFavorites(var usuario) async {
    final prefs = await SharedPreferences.getInstance();
    List<dynamic> favoritos = jsonDecode(prefs.getString('Favoritos').toString());
    Map remover = favoritos.firstWhere((element) => element['nombre'] == usuario['nombre']);
    favoritos.remove(remover);
    prefs.setString('Favoritos', jsonEncode(favoritos));
  }

  void removeallfavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('Favoritos');
  }

  void updateFavorites() {
    setState(() {
      print('refrescado');
    });
  }

  Future<List<dynamic>> setFavs() async {
    final prefs = await SharedPreferences.getInstance();
    List<dynamic> favs = jsonDecode(prefs.getString('Favoritos').toString());

    return favs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
          child: Image.asset('assets/crystals.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              updateFavorites();
            },
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton(
              icon: const Icon(Icons.menu),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    padding: EdgeInsets.only(left: 13, right: 0),
                    child: Text("Contacto"),
                  )
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SuggestionPage()));
                }
              }),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: FutureBuilder(
          future: setFavs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.blue[50],
                    child: InkWell(
                      onLongPress: () {
                        setPlayerLoadout(snapshot.data![index]['id'].toString(), context);
                      },
                      onTap: () async {
                        final currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        try {
                          setPlayer(snapshot.data![index]['id'].toString(), context);
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
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Image.network(
                                snapshot.data![index]['url'],
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset('assets/noprofile.png');
                                },
                              ),
                            ),
                            trailing: StarButton(
                                iconSize: 40.0,
                                isStarred: true,
                                valueChanged: (isStarred) {
                                  removeFavorites(snapshot.data![index]);
                                }),
                            title: Row(
                              children: [
                                Text(snapshot.data![index]['nombre'].toString()),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text('(${snapshot.data![index]['nivel']})'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: SizedBox());
            }
          },
        ),
      ),
    );
  }
}
