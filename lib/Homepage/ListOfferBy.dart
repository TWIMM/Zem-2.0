import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agri_market/provider/BottomProvider.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/Commons/custom_annonce.dart';

class ListOfferByWidget extends StatefulWidget {
  String appBarTitle;

  ListOfferByWidget({
    this.appBarTitle = "",
  });

  @override
  _ListOfferByWidgetState createState() => _ListOfferByWidgetState();
}

class _ListOfferByWidgetState extends State<ListOfferByWidget> {
  var currentIndexProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentIndexProvider = Provider.of<CurrentIndexProvider>(context);
  }

  _buildAnnoncesList(List<dynamic> offers) {
    return AnnoncesList(offers: offers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Color(0xFFF5F5F8),
          toolbarHeight: 90,
          title: Column(
            children: [
              StyledText(
                text: currentIndexProvider.offerBy['appBarTitle'],
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
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                // Your UI components using widget.offers go here
                SizedBox(height: 20),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    child: _buildAnnoncesList(
                      currentIndexProvider.offerBy['listOfOffers'],
                    )),
              ],
            ),
          ),
        ));
  }
}

class AnnoncesList extends StatelessWidget {
  final List<dynamic> offers;

  const AnnoncesList({required this.offers});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: offers.isNotEmpty
          ? _buildAnnoncesList(offers)
          : Text('No offers available'),
    );
  }

  Widget _buildAnnoncesList(List<dynamic> arrayOfList) {
    List<Widget> annonceWidgets = [];

    for (final item in arrayOfList) {
      annonceWidgets.add(
        Padding(
          padding: const EdgeInsets.only(right: 0.0, bottom: 16.0),
          child: CustomAnnonce(
            imageUrl: item['images'][0],
            title: item['name'],
            description: item['description'],
            keywords: ["huiles", "vente", "industrie", "achat", "agriculture"],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    return Column(
      children: annonceWidgets,
    );
  }
}
