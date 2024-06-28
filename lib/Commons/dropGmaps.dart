import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class dropGmaps extends StatefulWidget {
  final void Function(String?) onActivitySelected;

  const dropGmaps({Key? key, required this.onActivitySelected})
      : super(key: key);

  @override
  State<dropGmaps> createState() => _DropGmapsState();
}

class _DropGmapsState extends State<dropGmaps> {
  TextEditingController activityController = TextEditingController();
  String? activityName = "";


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      LocationData locationData = await location.getLocation();
      setState(() {
        currentLocationData = locationData;
      });
      _updateMarkers();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _updateMarkers() {
    if (currentLocationData != null) {
      Marker marker = Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(
            currentLocationData!.latitude!, currentLocationData!.longitude!),
        infoWindow: InfoWindow(title: 'Current Location'),
      );
      setState(() {
        markers.clear();
        markers.add(marker);
      });
    }
  }


  List<String> activities = [
    '7 places',
    '5 places',
    '4 places',
    '2 places',
  ];
 GoogleMapController? mapController;
  LocationData? currentLocationData;
  Location location = Location();
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 184, 180, 180).withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: (deviceWidth - 42) * 0.3,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              border: Border.all(
                color: Colors.white,
              ),
              color: const Color.fromARGB(255, 0, 39, 100),
            ),
            child: TextButton(
              onPressed: () {
                _showActivityPickerBottomSheet(context);
              },
              child: const Text(
                'Open Maps',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: (deviceWidth - 42) * 0.7,
            child: Text(
              activityController.text,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _showActivityPickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding around the map
            child:  GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    currentLocationData?.latitude ?? 0.0,
                    currentLocationData?.longitude ?? 0.0,
                  ),
                  zoom: 15.0,
                ),
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
            ),
          ),
        );
      },
    );
  }
}

class ActivityPickerBottomSheet extends StatelessWidget {
  final List<String> activities;
  final void Function(String) onActivitySelected;

  const ActivityPickerBottomSheet({
    Key? key,
    required this.activities,
    required this.onActivitySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const SingleChildScrollView(
        // Use SingleChildScrollView to make the content scrollable
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Add widgets here as needed for the bottom sheet content
          ],
        ),
      ),
    );
  }
}
