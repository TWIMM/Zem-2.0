import 'package:flutter/material.dart';
import 'Login.dart';
import '../Services/Validator.dart';
import '../Commons/AuthInputModel.dart';
import '../Commons/SocialMediasIconsRow.dart';
import '../Utils/MyIcons.dart' as MyIcons;
import 'package:page_transition/page_transition.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/Commons/drop.dart';

void main() {
  runApp(Inscription());
}

Validator validator = Validator();

class Inscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InscriptionPage(),
    );
  }
}

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPage createState() => _InscriptionPage();
}

class _InscriptionPage extends State<InscriptionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add this key
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  bool isChecked = false; // Added the isChecked variable
  bool isPasswordVisible = false; // Added the isPasswordVisible variable
  bool isNameError = false;
  bool isEmailError = false;
  bool isPhoneError = false;
  bool isCountryError = false;
  bool isAdressError = false;
  bool isZipError = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap your Scaffold with SafeArea
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Fond.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center vertically
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              // Handle the icon's tap action here
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: Login()));
                            },
                            child: Opacity(
                              opacity:
                                  0.7, // Set the opacity level (0.0 to 1.0)
                              child: Icon(
                                MyIcons.CustomIcons.arrow_circle_left_outlined,
                                size: 40.0,
                                color: Colors.white,
                              ),
                            )),
                        /* Expanded(
                          child: Center(
                            child: Transform.scale(
                              scale: 1.2,
                              child: Image.asset(
                                'assets/images/agrimarket.png',
                                height: 50,
                              ),
                            ),
                          ),
                        ), */
                        GestureDetector(
                            onTap: () {
                              // Handle the icon's tap action here
                            },
                            child: Opacity(
                              opacity:
                                  0.01, // Set the opacity level (0.0 to 1.0)
                              child: Icon(
                                MyIcons.CustomIcons.arrow_circle_left_outlined,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            // Email Input
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: StyledText(
                                text: "Inscrivez vous maintenant \n ",
                                fontName: "Open Sans",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 1.0),
                            StyledText(
                              text: "Inscription \n ",
                              fontName: "Open Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              textAlign: TextAlign.center,
                            ),
                            CustomInputField(
                              controller: nameController,
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              labelText: "Name",
                              isError: isNameError,
                              prefixIcon: GestureDetector(
                                child: Icon(
                                  MyIcons.CustomIcons.account_circle_outlined,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              border: InputBorder.none,
                            ),

                            SizedBox(height: 20.0),

                            CustomInputField(
                              controller: emailController,
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              isError: isEmailError,
                              prefixIcon: GestureDetector(
                                child: Icon(
                                  MyIcons.CustomIcons.markunread_outlined,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              border: InputBorder.none,
                            ),

                            SizedBox(height: 20.0),

                            CustomInputField(
                              controller: phoneController,
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              onChanged: (value) {
                                /*  String securedValue = UtilsClass.hideCharacters(
                                    value,
                                    3); */ // Hide all but the first 3 characters
                                /*    phoneController.value =
                                    phoneController.value.copyWith(
                                  text: securedValue,
                                  selection: TextSelection.collapsed(
                                      offset: securedValue.length),
                                ); */
                              },
                              labelText: "Phone",
                              isError: isPhoneError,
                              prefixIcon: GestureDetector(
                                child: Icon(
                                  MyIcons.CustomIcons.phone_rounded,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              border: InputBorder.none,
                              keyboardType: TextInputType
                                  .number, // Set the keyboard type to number
                            ),
                            // Password Input

                            SizedBox(height: 20.0),

                            DropdownMenuExample(
                              onCountrySelected: (value) {
                                countryController.text = value ?? "";
                              },
                            ),

                            /*  CustomInputField(
                              controller: countryController,
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              labelText: "Country",
                              isError: isCountryError,
                              prefixIcon: GestureDetector(
                                child: Icon(
                                  MyIcons.CustomIcons.map_outlined,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              border: InputBorder.none,
                            ), */

                            SizedBox(height: 20.0),

                            CustomInputField(
                              controller: adressController,
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              labelText: "Adress",
                              isError: isAdressError,
                              prefixIcon: GestureDetector(
                                child: Icon(
                                  MyIcons.CustomIcons.maps_home_work,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              border: InputBorder.none,
                            ),

                            SizedBox(height: 20.0),

                            CustomInputField(
                              controller: zipController,
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              labelText: "Code Zip",
                              isError: isAdressError,
                              prefixIcon: GestureDetector(
                                child: Icon(
                                  MyIcons.CustomIcons.pin_drop,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              border: InputBorder.none,
                            ),

                            SizedBox(height: 20.0),

                            // Login Button
                            GestureDetector(
                              onTap: () {
                                validator.InscriptionPageOneValidator(
                                    _formKey,
                                    emailController,
                                    nameController,
                                    phoneController,
                                    countryController,
                                    adressController,
                                    zipController, (isError) {
                                  setState(() {
                                    isEmailError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isZipError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isNameError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isPhoneError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isCountryError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isAdressError = isError;
                                  });
                                },
                                    context,
                                    MyIcons.CustomIcons.warning_amber_rounded,
                                    MyIcons.CustomIcons.cancel_outlined);
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                margin:
                                    EdgeInsets.only(top: 20), // Adjust margin
                                decoration: BoxDecoration(
                                  color:  Color.fromARGB(255, 0, 39, 100), // Use the provided color code
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Center(
                                  child: StyledText(
                                    text: 'Next',
                                    fontName: "Open Sans",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Image.asset(
                              'assets/images/OR.png', // Replace with the path to your image
                              width: 300,
                              height: 60,
                            ),

                            SocialMediaIconsRow(),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                StyledText(
                                  text: "Déjà inscrit ? \n ",
                                  fontName: "Open Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.leftToRight,
                                            child: Login()));
                                  },
                                  child: StyledText(
                                    text: "Connectez vous \n ",
                                    fontName: "Open Sans",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFFA805),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
