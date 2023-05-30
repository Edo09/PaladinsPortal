import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';

import '../classes/championranks.dart';

class PlayerChampions extends StatefulWidget {
  const PlayerChampions({
    Key? key,
  }) : super(key: key);

  @override
  PlayerChampionsState createState() => PlayerChampionsState();
}

class PlayerChampionsState extends State<PlayerChampions> {
  String winrateCal(int w, int l) {
    if (w != 0 || l != 0) {
      var wr = ((w / (l + w)) * 100).round();

      //String wrfinal = '$wr%($w - $l)';

      return '$wr%';
    } else {
      return '0%';
    }
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  String kdaCal(int k, int d, int a) {
    var kda = ((k + a) / d).toStringAsFixed(1);
    return kda.toString();
  }

  List<ChampionRanks> listacampeones = <ChampionRanks>[];
  final formatter = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    dynamic champlist = ModalRoute.of(context)?.settings.arguments;
    listacampeones = champlist['champions'];
    return Scaffold(
      appBar: AppBar(title: Text('Campeones de ${champlist['playername']}')),
      body: HorizontalDataTable(
        leftHandSideColumnWidth: 80,
        rightHandSideColumnWidth: 500,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: listacampeones.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 0.0,
          thickness: 1.5,
        ),
        leftHandSideColBackgroundColor: Colors.blue[100] as Color,
        rightHandSideColBackgroundColor: Colors.blue[50] as Color,
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Campeon', 100, 0, 'rank'),
      _getTitleItemWidget('Partidas', 80, 1, 'matches'),
      _getTitleItemWidget('WinR', 55, 2, 'wr'),
      _getTitleItemWidget('Bajas', 70, 3, 'kills'),
      _getTitleItemWidget('Muertes', 80, 4, 'deaths'),
      _getTitleItemWidget('Asist.', 70, 5, 'assists'),
      _getTitleItemWidget('KDA', 65, 6, 'kda'),
      _getTitleItemWidget('Horas', 80, 7, 'hours'),
    ];
  }

  int _selectedIndex = -1;
  Widget _getTitleItemWidget(String label, double width, int index, String sort) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_selectedIndex == index) {
            _selectedIndex = -1;
            switch (sort) {
              case 'rank':
                listacampeones.sort((a, b) => b.rank.compareTo(a.rank));
                break;
              case 'matches':
                listacampeones.sort((a, b) => (b.wins + b.losses).compareTo((a.wins + a.losses)));
                break;
              case 'kills':
                listacampeones.sort((a, b) => b.kills.compareTo(a.kills));
                break;
              case 'deaths':
                listacampeones.sort((a, b) => b.deaths.compareTo(a.deaths));
                break;
              case 'assists':
                listacampeones.sort((a, b) => b.assists.compareTo(a.assists));
                break;
              case 'kda':
                listacampeones.sort(
                    (a, b) => kdaCal(b.kills, b.deaths, b.assists).compareTo(kdaCal(a.kills, a.deaths, a.assists)));
                break;
              case 'hours':
                listacampeones.sort((a, b) => b.minutes.compareTo(a.minutes));
                break;
              case 'wr':
                listacampeones.sort((a, b) => winrateCal(b.wins, b.losses).compareTo(winrateCal(a.wins, a.losses)));
                break;

              default:
            }
          } else {
            _selectedIndex = index;
            switch (sort) {
              case 'rank':
                listacampeones.sort((a, b) => a.rank.compareTo(b.rank));
                break;
              case 'matches':
                listacampeones.sort((a, b) => (a.wins + a.losses).compareTo(b.wins + b.losses));
                break;
              case 'kills':
                listacampeones.sort((a, b) => a.kills.compareTo(b.kills));
                break;
              case 'deaths':
                listacampeones.sort((a, b) => a.deaths.compareTo(b.deaths));
                break;
              case 'assists':
                listacampeones.sort((a, b) => a.assists.compareTo(b.assists));
                break;
              case 'kda':
                listacampeones.sort(
                    (a, b) => kdaCal(a.kills, a.deaths, a.assists).compareTo(kdaCal(b.kills, b.deaths, b.assists)));
                break;
              case 'hours':
                listacampeones.sort((a, b) => a.minutes.compareTo(b.minutes));
                break;
              case 'wr':
                listacampeones.sort((a, b) => winrateCal(a.wins, a.losses).compareTo(winrateCal(b.wins, b.losses)));
                break;

              default:
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: index == _selectedIndex ? Colors.lightBlueAccent : Colors.blue[100],
        ),
        width: width,
        height: 56,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: Alignment.center,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black))),
        width: 100,
        height: 81,
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.network(
              'https://webcdn.hirezstudios.com/paladins/champion-icons/${listacampeones[index].champion.toLowerCase().replaceAll(' ', '-')}.jpg',
              width: 60,
            ),
            Text(listacampeones[index].rank.toString()),
          ],
        ));
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        //PARTIDAS
        Container(
            //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            width: 75,
            height: 81,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            alignment: Alignment.center,
            child: Text(
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                formatter.format(listacampeones[index].wins + listacampeones[index].losses))),
        //WINRATE
        Container(
          width: 65,
          height: 81,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              winrateCal(listacampeones[index].wins, listacampeones[index].losses)),
        ),
        //KILLS
        Container(
          width: 60,
          height: 81,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              formatter.format(listacampeones[index].kills)),
        ),
        //MUERTES
        Container(
          width: 75,
          height: 81,
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              formatter.format(listacampeones[index].deaths)),
        ),
        //ASISTENCIAS
        Container(
          width: 75,
          height: 81,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              formatter.format(listacampeones[index].assists)),
        ),
        //KDA
        Container(
          //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: 60,
          height: 81,
          padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              kdaCal(listacampeones[index].kills, listacampeones[index].deaths, listacampeones[index].assists)),
        ),
        //HOURS
        Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: 90,
          height: 81,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          alignment: Alignment.center,
          child: Text(
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              durationToString(listacampeones[index].minutes)),
        ),
      ],
    );
  }
}
