// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:agri_market/Commons/BottomNavBar.dart';
import 'package:agri_market/provider/BottomProvider.dart';
import 'package:agri_market/Homepage/Chat.dart';
import 'package:agri_market/Homepage/Messages.dart';
import 'package:agri_market/Homepage/Profile.dart';
import 'package:agri_market/Homepage/Home.dart';
import 'package:agri_market/Homepage/Add.dart';
import 'package:agri_market/Homepage/Mesproduits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agri_market/Homepage/ListOfferBy.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/Homepage/Displayer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<CurrentIndexProvider>().currentIndex;

    String appBarTitle1 = 'Parcourez les offres';
    String appBarTitle2 = 'les plus récentes';

    switch (currentIndex) {
      case 0:
        appBarTitle1 = 'Parcourez les offres';
        appBarTitle2 = 'les plus récentes';
        break;
      case 1:
        appBarTitle1 = 'Messagerie';
        appBarTitle2 = '';
        break;
      case 2:
        appBarTitle1 = 'Publier une offre';
        appBarTitle2 = '';
        break;
      case 3:
        appBarTitle1 = 'Wishlist';
        appBarTitle2 = '';
        break;
      case 4:
        appBarTitle1 = 'Profile';
        appBarTitle2 = '';
        break;
      default:
        appBarTitle1 = 'Parcourez les offres';
        appBarTitle2 = 'les plus récentes';
        break;
    }
    Widget? bottomNavBar;
    PreferredSizeWidget? appBar;

    bottomNavBar = BottomNavBar(
      currentIndex: currentIndex,
      onTabTapped: (index) {
        context.read<CurrentIndexProvider>().setIndex(index);
      },
    );
    appBar = AppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0,
      backgroundColor: Color(0xFFF5F5F8),
      toolbarHeight: 90,
      title: Column(
        children: [
          StyledText(
            text: appBarTitle1,
            fontName: "Open Sans",
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          StyledText(
            text: appBarTitle2,
            fontName: "Open Sans",
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Image.asset(
              'assets/icons/pp.png',
              width: 60, // Set the desired width
              height: 60, // Set the desired height
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ],
    );

    print("Current Route: $currentIndex");

    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[currentIndex].currentState!.maybePop();

          // let the system handle the back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
              _buildOffstageNavigator(2),
              _buildOffstageNavigator(3),
              _buildOffstageNavigator(4),
              _buildOffstageNavigator(5),
            ],
          ),
          //  bottomNavigationBar: bottomNavBar,
        ));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    final authToken =
        context.watch<CurrentIndexProvider>().getAccountDetail('authToken');
    return {
      '/': (context) {
        return [
          Home(),
          Messages(),
          Add(),
          MesProduits(),
          Displayer(),

          Profile(),
          // ChatDetailPageWrapper()
        ].elementAt(index);
      },
      '/chat_detail': (context) => ChatDetailPageWrapper(),
      '/listofferby': (context) => ListOfferByWidget(),
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);
    final currentIndex = context.watch<CurrentIndexProvider>().currentIndex;

    return Offstage(
      offstage: currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }
}
