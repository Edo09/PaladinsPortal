import 'package:flutter/material.dart';
import '/classes/rankedleaderboard.dart';
import '/pages/suggestionpage.dart';
import '/pages/toprankedpage.dart';
import '../classes/getchampions.dart';
import 'favoriteplayers.dart';
import 'lookfordeck.dart';
import 'lookforplayer.dart';

import '../classes/paladinsapi.dart';
import '../classes/serverstatus.dart';

class Home extends StatelessWidget {
  final String sessionid;
  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();

  final _tab4navigatorKey = GlobalKey<NavigatorState>();

  Home({Key? key, required this.sessionid}) : super(key: key);

  Future<List<ServerStatus>> _getServerStatus() async {
    List<ServerStatus> serverStatus;

    serverStatus = await PaladinsApi().getServerStatus(sessionid);

    return serverStatus;
  }

  Future<List<GetChampions>> _getChampions() async {
    List<GetChampions> idbygamertag;

    idbygamertag = await PaladinsApi().getChampions(sessionid);

    return idbygamertag;
  }

  Future<List<RankedLeaderboard>> _getRankedLeaderBoard() async {
    List<RankedLeaderboard> topranked;

    topranked = await PaladinsApi().getRankedLeaderBoard(sessionid);

    return topranked;
  }

  @override
  Widget build(BuildContext context) {
    return PersistentBottomBarScaffold(
      items: [
        PersistentTabItem(
          tab: LookforPlayer(
            estadoserver: _getServerStatus(),
          ),
          icon: Icons.search,
          title: 'Buscar',
          navigatorkey: _tab1navigatorKey,
        ),
        PersistentTabItem(
          tab: const FavoritePlayers(),
          icon: Icons.star,
          title: 'Favoritos',
          navigatorkey: _tab2navigatorKey,
        ),
        PersistentTabItem(
          tab: LookForDeck(
            listacampeones: _getChampions(),
          ),
          icon: Icons.dashboard_customize,
          title: 'Barajas',
          navigatorkey: _tab3navigatorKey,
        ),
        PersistentTabItem(
          tab: Leaderboard(toprankedplayers: _getRankedLeaderBoard()),
          icon: Icons.list,
          title: 'Top',
          navigatorkey: _tab4navigatorKey,
        ),
      ],
    );
  }
}

class PersistentBottomBarScaffold extends StatefulWidget {
  /// pass the required items for the tabs and BottomNavigationBar
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({Key? key, required this.items}) : super(key: key);

  @override
  State<PersistentBottomBarScaffold> createState() => _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState extends State<PersistentBottomBarScaffold> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// Check if curent tab can be popped
        if (widget.items[_selectedTab].navigatorkey?.currentState?.canPop() ?? false) {
          widget.items[_selectedTab].navigatorkey?.currentState?.pop();
          return false;
        } else {
          // if current tab can't be popped then use the root navigator
          print('cerrar?');
          return false;
        }
      },
      child: Scaffold(
        /// Using indexedStack to maintain the order of the tabs and the state of the
        /// previously opened tab
        body: IndexedStack(
          index: _selectedTab,
          children: widget.items
              .map((page) => Navigator(
                    /// Each tab is wrapped in a Navigator so that naigation in
                    /// one tab can be independent of the other tabs
                    key: page.navigatorkey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [MaterialPageRoute(builder: (context) => page.tab)];
                    },
                  ))
              .toList(),
        ),

        /// Define the persistent bottom bar
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blue,
          currentIndex: _selectedTab,
          onTap: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: widget.items.map((item) => BottomNavigationBarItem(icon: Icon(item.icon), label: item.title)).toList(),
        ),
      ),
    );
  }
}

/// Model class that holds the tab info for the [PersistentBottomBarScaffold]
class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem({required this.tab, this.navigatorkey, required this.title, required this.icon});
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
        child: Image.asset('assets/crystals.png'),
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.menu),
          itemBuilder: (context) {
            final currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Contacto", textAlign: TextAlign.end),
              ),
            ];
          },
          onSelected: (value) {
            if (value == 0) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SuggestionPage()));
            }
            // Handle other menu options here
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
