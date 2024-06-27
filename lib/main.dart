import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'Auth/Login.dart';
import 'package:agri_market/provider/BottomProvider.dart';
import 'package:agri_market/Commons/custom_text.dart';


void main() => runApp(LandingPageApp());

class LandingPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                CurrentIndexProvider()), // Provide your CurrentIndexProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Landing Page',
        home: LandingPage(),
      ),
    );
  }
}

class MethodUtils {
  static void goToLogin(BuildContext context) {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.leftToRight, child: Login()));
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final currentIndex = context.watch<CurrentIndexProvider>().currentIndex;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Fond.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Your content here
               /*  Transform.scale(
                  scale: 1.8,
                  child: Image.asset(
                    'assets/images/agrimarket.png',
                    width: 100,
                    height: 100,
                  ),
                ), */
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: StyledText(
                    text:
                        "Bienvenue sur Zem 2.0 !",
                    fontName: "Open Sans",
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                // Button with Gradient Background
                GestureDetector(
                  onTap: () {
                    // Update the current index using the provider
                    context.read<CurrentIndexProvider>().setIndex(0);

                    // Navigate to MainScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color:  Color.fromARGB(255, 0, 39, 100), // Use the provided color code
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child:Center(child: StyledText(
                      text: 'Nous rejoindre',
                      fontName: "Open Sans",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
