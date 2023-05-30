import 'package:flutter/material.dart';
import '/classes/playerloadouts.dart';
import '/pages/home.dart';
import '../classes/getchampions.dart';
import '/classes/searchplayer.dart';
import '../classes/paladinsapi.dart';
import 'lookforplayer.dart';
import 'playerdecks.dart';

class LookForDeck extends StatefulWidget {
  final Future<List<GetChampions>> listacampeones;
  const LookForDeck({
    super.key,
    required this.listacampeones,
  });

  @override
  LookForDeckState createState() => LookForDeckState();
}

class LookForDeckState extends State<LookForDeck> {
  List selectedChampion = [];
  int _selectedImageIndex = -1;
  final myController = TextEditingController();
  Future<List<GetChampions>>? campeones;
  bool _validate = false;
  List<SearchPlayer> playerlist = [];
  final ButtonStyle style = ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: const Color.fromRGBO(46, 176, 209, 82),
      textStyle: const TextStyle(fontSize: 18));

  @override
  Widget build(BuildContext context) {
    campeones = widget.listacampeones;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Buscar Barajas',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                  hintText: 'Jugador...',
                  contentPadding: const EdgeInsets.all(1),
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
                  errorText: _validate ? 'Nombre del jugador' : null),
              controller: myController,
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
                                        setPlayerLoadout(snapshot.data![index].playerId, context,
                                            campeonseleccionado: selectedChampion);
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
              child: const Text('Buscar'),
            ),
            Expanded(
              child: FutureBuilder<List<GetChampions>>(
                future: campeones,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      setState(() {});
                      return const Text('Cargando...');
                    }
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GridTile(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (_selectedImageIndex == index) {
                                  // if the tapped image is already selected, deselect it
                                  _selectedImageIndex = -1;
                                  selectedChampion = [];
                                } else {
                                  // otherwise, select the tapped image
                                  _selectedImageIndex = index;
                                  selectedChampion = [snapshot.data![index].name, snapshot.data![index].id];
                                }
                              });
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _selectedImageIndex == index ? Colors.blue : Colors.grey.withOpacity(0.5),
                                    width: _selectedImageIndex == index ? 3.5 : 1,
                                  ),
                                ),
                                child: Opacity(
                                  opacity: _selectedImageIndex == index ? 0.6 : 1,
                                  child: Image.network(
                                    snapshot.data![index].championIconUrl,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {}
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void setPlayerLoadout(playerid, context, {campeonseleccionado = ''}) async {
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
  String sessionid = await PaladinsApi().setupsession();
  if (campeonseleccionado == '') {
    campeonseleccionado = [];
  }
  try {
    List<PlayerLoadouts> playerloadouts = await PaladinsApi().getPlayerLoadouts(sessionid, playerid);
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PlayerDecks(),
        settings: RouteSettings(arguments: {playerloadouts, campeonseleccionado})));
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
