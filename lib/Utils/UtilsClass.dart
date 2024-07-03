// ignore_for_file: prefer_const_constructors
import 'package:agri_market/Commons/custom_text.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UtilsClass {
  static String hideCharacters(String input, int keepVisible) {
    if (input.length <= keepVisible) {
      return input;
    }

    return input.replaceRange(
        keepVisible, input.length, '*' * (input.length - keepVisible));
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static void showActivityPickerBottomSheet(
      BuildContext context,
      List<String> items,
      final void Function(dynamic param) onActivitySelected) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: ActivityPickerBottomSheet(
            activities: items,
            onActivitySelected: (selectedActivity) {
              onActivitySelected(selectedActivity);
              /*  setState(() {
                activityName = selectedActivity;
                activityController.text = activityName ?? "";
              });
              widget.onActivitySelected(activityName);
              Navigator.pop(context); */

              Navigator.pop(context);
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
            for (var activity in activities)
              ListTile(
                title: Text(activity),
                onTap: () {
                  onActivitySelected(activity);
                },
              ),
          ],
        ),
      ),
    );
  }
}
