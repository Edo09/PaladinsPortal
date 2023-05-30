import 'package:flutter/material.dart';
import '/classes/playerloadouts.dart';

class PlayerDecks extends StatelessWidget {
  const PlayerDecks({super.key});

  @override
  Widget build(BuildContext context) {
    List<PlayerLoadouts> playerloadouts;
    List selectedChampion = [];
    if (ModalRoute.of(context)?.settings.arguments == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Jugador no encontrado'),
        ),
      );
    } else {
      var datos = ModalRoute.of(context)?.settings.arguments as Set;

      playerloadouts = datos.first;
      selectedChampion = datos.last;

      if (selectedChampion.isNotEmpty) {
        playerloadouts.removeWhere((element) => element.championId != selectedChampion[1]);
      }

      if (playerloadouts.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sin barajas'),
          ),
          body: const Text('Jugador no tiene Barajas de este Campeón'),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(playerloadouts.first.playerName),
      ),
      body: ListView.builder(
        itemCount: playerloadouts.length,
        itemBuilder: (BuildContext context, int index) {
          for (PlayerLoadouts data in playerloadouts) {
            List<dynamic> loadoutItems = data.loadoutItems;
            loadoutItems.sort((a, b) => b.points.compareTo(a.points));
          }
          return Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.4,
                  alignment: const Alignment(0.4, 0),
                  image: NetworkImage(
                      "https://raw.githubusercontent.com/Edo09/hirez-api-docs/master/.assets/paladins/headers/${playerloadouts[index].championId}.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      playerloadouts[index].deckName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(playerloadouts[index].championName),
                    leading: Image.network(
                      'https://webcdn.hirezstudios.com/paladins/champion-icons/${playerloadouts[index].championName.toLowerCase().replaceAll(' ', '-')}.jpg',
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('error');
                      },
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 0.5,
                  ),
                  ListView(
                    shrinkWrap: true, // Set shrinkWrap to true
                    physics: const ClampingScrollPhysics(), // Set physics to ClampingScrollPhysics
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Row(
                          children: [
                            MyCustomWidget(
                              imageUrl: getItemName(playerloadouts[index].loadoutItems[0].itemName),
                              itemName: playerloadouts[index].loadoutItems[0].itemName,
                              points: playerloadouts[index].loadoutItems[0].points,
                            ),
                            MyCustomWidget(
                              imageUrl: getItemName(playerloadouts[index].loadoutItems[1].itemName),
                              itemName: playerloadouts[index].loadoutItems[1].itemName,
                              points: playerloadouts[index].loadoutItems[1].points,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          MyCustomWidget(
                            imageUrl: getItemName(playerloadouts[index].loadoutItems[2].itemName),
                            itemName: playerloadouts[index].loadoutItems[2].itemName,
                            points: playerloadouts[index].loadoutItems[2].points,
                          ),
                          MyCustomWidget(
                            imageUrl: getItemName(playerloadouts[index].loadoutItems[3].itemName),
                            itemName: playerloadouts[index].loadoutItems[3].itemName,
                            points: playerloadouts[index].loadoutItems[3].points,
                          ),
                          MyCustomWidget(
                            imageUrl: getItemName(playerloadouts[index].loadoutItems[4].itemName),
                            itemName: playerloadouts[index].loadoutItems[4].itemName,
                            points: playerloadouts[index].loadoutItems[4].points,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String getItemName(String itemname) {
    print(itemname);
    switch (itemname) {
      case 'Inflame I':
        itemname = 'failsafe';
        break;
      case 'Heads Will Roll I':
        itemname = 'power-of-the-abyss';
        break;
      case 'Continuation I':
        itemname = 'abyss-walker';
        break;
      case 'Royal Army I':
        itemname = 'kings-court';
        break;
      case 'Shell Shock I':
        itemname = 'mad-bomber';
        break;
      default:
    }

    String url =
        "https://webcdn.hirezstudios.com/paladins/champion-cards/${itemname.toLowerCase().replaceAll(' ', '-').replaceAll('-i', '').replaceAll("'", '')}.jpg";

    return url;
  }
}

ColorSwatch rangodeCarta(int rango) {
  ColorSwatch<int> color = Colors.grey;
  switch (rango) {
    case 1:
      color = Colors.grey;
      break;
    case 2:
      color = Colors.greenAccent;
      break;
    case 3:
      color = Colors.blueAccent;
      break;
    case 4:
      color = Colors.purple;
      break;
    case 5:
      color = Colors.orange;
      break;
  }

  return color;
}

class MyCustomWidget extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final int points;

  const MyCustomWidget({super.key, required this.imageUrl, required this.itemName, required this.points});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: rangodeCarta(points),
              ),
            ),
            child: Card(
              margin: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Image.network(
                    imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Error');
                    },
                  ),
                  FittedBox(
                    child: Text(
                      itemName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: rangodeCarta(points),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      points.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
