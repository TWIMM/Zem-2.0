// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:agri_market/Commons/BottomNavBar.dart';
import 'package:agri_market/Homepage/google_maps_screen.dart';
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
      onGenerateRoute: (settings) {
        // Handle unknown routes here
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              elevation: 0,
              backgroundColor: const Color(0xFFF5F5F8),
              toolbarHeight: 90,
              title: const StyledText(
                text: 'Page introuvable',
                fontName: "Open Sans",
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            body: Center(
              child: Text('404 - Not Found'),
            ),
          ),
        );
      },
      routes: {
        // Define your other routes here if needed
        '/chat_detail': (context) => ChatDetailPageWrapper(),
        '/listofferby': (context) => ListOfferByWidget(),
        '/search_place': (context) => Displayer(),
      },
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
    GlobalKey<NavigatorState>(),
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: List.generate(
          _navigatorKeys.length,
          (index) => _buildOffstageNavigator(index, currentIndex),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(int index, int currentIndex) {
    var routeBuilders = _routeBuilders(context, index);
    return Offstage(
      offstage: currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          final routeName = routeSettings.name;
          WidgetBuilder? builder = routeBuilders[routeName];
          return MaterialPageRoute(
            builder: (context) => builder!(context),
          );
        },
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    switch (index) {
      case 0:
        return {
          '/': (context) => Home(),
          '/chat_detail': (context) => ChatDetailPageWrapper(),
          '/listofferby': (context) => ListOfferByWidget(),
          '/search_place': (context) => Displayer(),
        };
      case 1:
        return {
          '/': (context) => Messages(),
          '/chat_detail': (context) => ChatDetailPageWrapper(),
        };
      case 2:
        return {
          '/': (context) => Add(),
        };
      case 3:
        return {
          '/': (context) => MesProduits(),
        };
      case 4:
        return {
          '/': (context) => Displayer(),
        };
      case 5:
        return {
          '/': (context) => Profile(),
        };
      default:
        return {
        
        };
    }
  }
}
