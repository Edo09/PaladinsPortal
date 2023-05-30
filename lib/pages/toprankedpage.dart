import 'package:flutter/material.dart';
import '/classes/rankedleaderboard.dart';
import '/pages/lookforplayer.dart';

import '../classes/paladinsapi.dart';
import 'home.dart';

class Leaderboard extends StatefulWidget {
  final Future<List<RankedLeaderboard>> toprankedplayers;

  const Leaderboard({super.key, required this.toprankedplayers});

  @override
  LeaderboardState createState() => LeaderboardState();
}

const List<String> tiers = <String>[
  'Gran Maestro',
  'Diamante I',
  'Diamante II',
  'Diamante III',
  'Diamante IV',
  'Diamante V',
  'Platino I',
  'Platino II',
  'Platino III',
  'Platino IV',
  'Platino V'
];
Future<List<RankedLeaderboard>> _getRankedLeaderBoard(int tier) async {
  List<RankedLeaderboard> topranked;

  topranked = await PaladinsApi().getRankedLeaderBoard(await PaladinsApi().setupsession(), tier: tier);

  return topranked;
}

class LeaderboardState extends State<Leaderboard> {
  String dropdownValue = tiers.first;
  Future<List<RankedLeaderboard>>? topranked;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    topranked = widget.toprankedplayers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Clasificación mundial',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              dropdownColor: const Color.fromRGBO(40, 155, 184, 72),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
              icon: const Icon(Icons.arrow_downward),
              onChanged: (String? value) {
                if (dropdownValue != value.toString()) {
                  setState(() {
                    dropdownValue = value.toString();
                    topranked = _getRankedLeaderBoard(getTierIndex(tiers.indexOf(value!)));
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
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context, rootNavigator: true).pop();
                    });
                  });
                }
              },
              items: tiers.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      logotierWidget(tiers.indexOf(value)),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<RankedLeaderboard>>(
              future: topranked,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    setState(() {});
                    return const Text('error sin data');
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple.shade200,
                            foregroundColor: Colors.white,
                            child: Text('${index + 1}'),
                          ),
                          title: Text(
                            snapshot.data![index].name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            '${snapshot.data![index].points} TP',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          onTap: () {
                            setPlayer(snapshot.data![index].playerId, context);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget logotierWidget(int value) {
  String logotier;
  switch (value) {
    case 0:
      logotier = '26';
      break;
    case 1:
      logotier = '25';
      break;
    case 2:
      logotier = '24';
      break;
    case 3:
      logotier = '23';
      break;
    case 4:
      logotier = '22';
      break;
    case 5:
      logotier = '21';
      break;
    case 6:
      logotier = '20';
      break;
    case 7:
      logotier = '19';
      break;
    case 8:
      logotier = '18';
      break;
    case 9:
      logotier = '17';
      break;
    case 10:
      logotier = '16';
      break;
    default:
      logotier = '27';
  }
  return Image.asset('assets/$logotier.png');
}

int getTierIndex(int index) {
  print(index);
  switch (index) {
    case 0:
      return 26;
    case 1:
      return 25;
    case 2:
      return 24;
    case 3:
      return 23;
    case 4:
      return 22;
    case 5:
      return 21;
    case 6:
      return 20;
    case 7:
      return 19;
    case 8:
      return 18;
    case 9:
      return 17;
    case 10:
      return 16;

    default:
      return 26;
  }
}
