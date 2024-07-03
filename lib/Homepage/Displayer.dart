import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agri_market/Commons/BottomNavBar.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/provider/BottomProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_api_headers/google_api_headers.dart' as header;
import 'package:agri_market/Commons/places.dart' as places;
import 'package:location/location.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../Commons/AuthInputModel.dart';

void main() => runApp(const Displayer());

class Displayer extends StatefulWidget {
  const Displayer({super.key});

  @override
  State<Displayer> createState() => _MyAppState();
}

class _MyAppState extends State<Displayer> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: const Color(0xFFF5F5F8),
            toolbarHeight: 90,
            title: const StyledText(
              text: 'Recherche',
              fontName: "Open Sans",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            )),
        body: Center(
            child: Column(children: [
          _buildSearchBar(),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              final snackBar = SnackBar(
                /// need to set following properties for best effect of awesome_snackbar_content
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Recherche en cours !',
                  message: 'Nous recherchons les agences dans votre zone!',

                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                  contentType: ContentType.success,
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            },
            child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 39, 100),
                  // Use the provided color code
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                    child: Row(children: [
                  Icon(
                    Icons.add_location_rounded,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  StyledText(
                    text: 'Position actuelle',
                    fontName: "Open Sans",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ]))),
          ),
        ])),
        bottomNavigationBar: BottomNavBar(
          currentIndex: 4,
          onTabTapped: (index) {
            context.read<CurrentIndexProvider>().setIndex(index);
          },
        ));
  }

  Widget _buildSearchBar() {
    return CustomSearch(
      controller: searchController,
      labelText: "Rechercher une adresse",
      prefixIcon: const Icon(
        Icons.search,
        color: Color(0xFFFFB405),
      ),
      fillColor: const Color.fromARGB(255, 234, 234, 234),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 51,
    );
  }
}