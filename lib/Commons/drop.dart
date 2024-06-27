// ignore_for_file: prefer_const_constructors
import 'package:agri_market/Commons/custom_text.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropdownMenuExample extends StatefulWidget {
  final void Function(String?) onCountrySelected;
  final Color? color;
  final Color? bordercolor;
  var country;

  DropdownMenuExample(
      {Key? key,
      this.color,
      this.bordercolor,
      required this.onCountrySelected,
      this.country})
      : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? countryName = "";
  List<String> countries = [];

  @override
  void initState() {
    super.initState();
    fetchCountries(); // Fetch countries when the widget initializes
  }

  void setStateOfCountry(countryName) {
    setState(() {
      countryName = countryName;
    }); // Fetch countries when the widget initializes
  }

  Future<void> fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.first.org/data/v1/countries'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        var countriesData = responseData['data'];
        print(responseData);
        setState(() {
          countries = countriesData.values
              .map<String>((country) => country['country'].toString())
              .toList();
        });
      } else {
        throw Exception('Failed to fetch countries: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching countries: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 184, 180, 180).withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          // Add border to Container
          color: widget.bordercolor ?? Colors.white,
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
                color: widget.bordercolor ?? Colors.white,
              ),
              color: Color.fromARGB(255, 0, 39, 100),
            ),
            child: TextButton(
              onPressed: () {
                _showCountryPickerBottomSheet(context);
              },
              child: StyledText(
                text: 'Choisir Pays',
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
              text: widget.country ?? "",
              fontName: "Open Sans",
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: widget.color ?? Colors.white,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _showCountryPickerBottomSheet(BuildContext context) {
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
          child: CountryPickerBottomSheet(
            countries: countries,
            onCountrySelected: (selectedCountry) {
              setState(() {
                countryName = selectedCountry;
                widget.country = countryName ?? "";
              });
              widget.onCountrySelected(countryName);
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
        );
      },
    );
  }
}

class CountryPickerBottomSheet extends StatelessWidget {
  final List<String> countries;
  final void Function(String) onCountrySelected;

  const CountryPickerBottomSheet({
    Key? key,
    required this.countries,
    required this.onCountrySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _dropdownMenuExampleState = _DropdownMenuExampleState();
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        // Use SingleChildScrollView to make the content scrollable
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (var country in countries)
              ListTile(
                title: Text(country),
                onTap: () {
                  onCountrySelected(country);
                  //  _dropdownMenuExampleState.setStateOfCountry(country);
                },
              ),
          ],
        ),
      ),
    );
  }
}
