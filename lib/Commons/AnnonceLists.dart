import 'package:flutter/material.dart';
import 'package:agri_market/Commons/custom_annonce.dart';

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

    int maxDisplayedItems = 2;
    int displayedItems = 0;

    for (final item in arrayOfList) {
      if (displayedItems < maxDisplayedItems) {
        annonceWidgets.add(
          Padding(
            padding: const EdgeInsets.only(right: 0.0, bottom: 16.0),
            child: CustomAnnonce(
              imageUrl: item['images'][0],
              title: item['name'],
              description: item['description'],
              keywords: [
                "huiles",
                "vente",
                "industrie",
                "achat",
                "agriculture"
              ],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        displayedItems++;
      } else {
        break; // Break out of the loop if the maximum number of items is reached
      }
    }

    return Column(
      children: annonceWidgets,
    );
  }
}
