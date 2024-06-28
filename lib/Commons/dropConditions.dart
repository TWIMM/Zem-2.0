// ignore_for_file: prefer_const_constructors
import 'package:agri_market/Commons/custom_text.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class dropCondition extends StatefulWidget {
  final void Function(String?) onActivitySelected;

  const dropCondition({Key? key, required this.onActivitySelected})
      : super(key: key);

  @override
  State<dropCondition> createState() => _ActivityPickerExampleState();
}

class _ActivityPickerExampleState extends State<dropCondition> {
  TextEditingController activityController = TextEditingController();
  String? activityName = "";
 /*  List<String> activities = [
    '7 places',
    '5 places',
    '4 places',
    '2 places',
  ]; */

   List<String> activities = [
    'Neuf-climatisé',
    'Bon état-climatisé',
    'Neuf-non-climatisé',
    'Bon état-non-climatisé',

  ];

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 184, 180, 180).withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          // Add border to Container
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
              color:  Color.fromARGB(255, 0, 39, 100),
            ),
            child: TextButton(
              onPressed: () {
                _showActivityPickerBottomSheet(context);
              },
              child: StyledText(
                text: 'Condition du véhicule',
                fontName: "Open Sans",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: (deviceWidth - 42) * 0.7,
            child: StyledText(
              text: activityController.text,
              fontName: "Open Sans",
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: ActivityPickerBottomSheet(
            activities: activities,
            onActivitySelected: (selectedActivity) {
              setState(() {
                activityName = selectedActivity;
                activityController.text = activityName ?? "";
              });
              widget.onActivitySelected(activityName);
              Navigator.pop(context); // Close the bottom sheet
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
