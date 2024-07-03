import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/Services/gmaps_service.dart';
import 'package:agri_market/Utils/place_from_coordinates.dart';

class GMapsApp extends StatelessWidget {
  final double defaultLong;
  final double defaultLat;

  const GMapsApp({
    Key? key,
    required this.defaultLong,
    required this.defaultLat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GMapsScreen(
        defaultLong: defaultLong,
        defaultLat: defaultLat,
      ),
    );
  }
}

class GMapsScreen extends StatefulWidget {
  final double defaultLong;
  final double defaultLat;

  const GMapsScreen({
    Key? key,
    required this.defaultLong,
    required this.defaultLat,
  }) : super(key: key);

  @override
  _GMapsScreenState createState() => _GMapsScreenState();
}

class _GMapsScreenState extends State<GMapsScreen> {
  late GoogleMapController mapController;
  late PlaceFromCoordinates placeFromCoordinates;

  @override
  void initState() {
    super.initState();
    placeFromCoordinates = PlaceFromCoordinates();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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
          text: 'Nos agences',
          fontName: "Open Sans",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      body: GoogleMap(
        onCameraIdle: () {
          print('Flutter');
          GmapsService.placeFromCoordinates(
            widget.defaultLat,
            widget.defaultLong,
          ).then((value) {
            setState(() {
              placeFromCoordinates = value;
            });
          });
        },
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.defaultLat, widget.defaultLong),
          zoom: 11.0,
        ),
        onCameraMove: (CameraPosition positionCam) {
          print('Location  : ${positionCam.toString()}');
          // No need to setState for widget.defaultLat and widget.defaultLong
          // These values are immutable once set
        },
      ),
      bottomSheet: Container(
        color: const Color.fromARGB(255, 1, 47, 121).withOpacity(0.5),
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(Icons.location_on),
            ),
            Expanded(
              child: StyledText(
                text:
                    '${placeFromCoordinates.results?[0].formattedAddress ?? "Chargement..."}',
                fontName: "Open Sans",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
