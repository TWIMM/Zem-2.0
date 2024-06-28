import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropGmaps extends StatefulWidget {
  final void Function(String?) onActivitySelected;

  const DropGmaps({Key? key, required this.onActivitySelected})
      : super(key: key);

  @override
  State<DropGmaps> createState() => _DropGmapsState();
}

class _DropGmapsState extends State<DropGmaps> {
  TextEditingController activityController = TextEditingController();
  String? activityName = "";

  List<String> activities = [
    '7 places',
    '5 places',
    '4 places',
    '2 places',
  ];

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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              border: Border.all(
                color: Colors.white,
              ),
              color: Color.fromARGB(255, 0, 39, 100),
            ),
            child: TextButton(
              onPressed: () {
                _showActivityPickerBottomSheet(context);
              },
              child: Text(
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
              style: TextStyle(
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  37.7749, -122.4194), // Initial position (San Francisco)
              zoom: 12.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              // You can manipulate the map controller here
            },
            markers: {
              Marker(
                markerId: MarkerId('marker_1'),
                position: LatLng(37.7749, -122.4194),
                infoWindow: InfoWindow(title: 'San Francisco'),
              ),
            },
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
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
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
