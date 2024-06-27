import 'dart:math';
import '../Commons/AuthInputModel.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'Inscription.dart';
import 'package:page_transition/page_transition.dart';
import 'package:agri_market/Commons/custom_text.dart';
import '../Services/Validator.dart';
import '../Commons/SocialMediasIconsRow.dart';
import '../Utils/MyIcons.dart' as MyIcons;
import '../Utils/UtilsClass.dart';
import 'package:agri_market/Commons/dropActivities.dart';

Validator validator = Validator();

class InscriptionPagetwo extends StatelessWidget {
  final List<dynamic> data;
  InscriptionPagetwo(this.data);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InscriptionPage2(data: data),
    );
  }
}

class InscriptionPage2 extends StatefulWidget {
  final List<dynamic> data;

  InscriptionPage2({required this.data});

  @override
  _InscriptionPage2 createState() => _InscriptionPage2(data: data);
}

class _InscriptionPage2 extends State<InscriptionPage2> {
  final List<dynamic> data;

  _InscriptionPage2({required this.data});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController buyerController = TextEditingController();
  TextEditingController sellerController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController registerNumberController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();

  bool isChecked = false;
  bool isPasswordVisible = false;

  bool isSellerError = false;
  bool isBuyerError = false;
  bool isCompanyError = false;
  bool isregisterNumberError = false;
  bool isActivityError = false;
  bool isPasswordError = false;
  bool isRadio1Pressed = false;
  bool isRadio2Pressed = false;
  bool isCheckedMock = false;
  bool isAccountError = false ; 

  Widget customCheckbox() {
    return InkWell(
      onTap: () {
        setState(() {
          isCheckedMock = !isCheckedMock;
        });
        print(isCheckedMock);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Color.fromARGB(255, 14, 135, 248),
            width: 2.0,
          ),
          color: isCheckedMock
              ? Color.fromARGB(255, 14, 135, 248)
              : Colors.transparent,
        ),
        child: isCheckedMock
            ? Icon(
                Icons.check,
                size: 20.0,
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(data);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 5.0),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child:
                                        Inscription()), // Navigate to Inscription
                              );
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
                    SizedBox(width: 20.0),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            // Email Input
                            StyledText(
                              text: "Inscrivez vous maintenant \n ",
                              fontName: "Open Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              textAlign: TextAlign.center,
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
                            CustomBuyerSellerField(
                              labelText: "Location d'une Auto/Moto",
                              isError: isSellerError,
                              prefixIcon: GestureDetector(
                                  child: Transform.rotate(
                                angle: -pi / 4,
                                child: Icon(
                                  MyIcons.CustomIcons.send_outlined,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              )),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  // Handle the icon's tap action here
                                  setState(() {
                                    isRadio1Pressed = !isRadio1Pressed;
                                    isRadio2Pressed = false;
                                    if (isRadio1Pressed == false) {
                                      accountTypeController.text = '';
                                    } else {
                                      accountTypeController.text = 'SELLER';
                                    }
                                  });
                                },
                                child: Icon(
                                  MyIcons.CustomIcons.radio_button_on_outlined,
                                  size: 25.0,
                                  color: isRadio1Pressed
                                      ? Color(0xFFFFB405)
                                      : Colors.white,
                                ),
                              ),
                            ),

                            SizedBox(height: 20.0),

                            CustomBuyerSellerField(
                              labelText: "Mettre en location mon Auto/Moto",
                              isError: isBuyerError,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  // Handle the icon's tap action here
                                  setState(() {
                                    isRadio2Pressed = !isRadio2Pressed;
                                    if (isRadio2Pressed == false) {
                                      accountTypeController.text = '';
                                    } else {
                                      accountTypeController.text = 'BUYER';
                                    }
                                    isRadio1Pressed = false;
                                  });
                                },
                                child: Icon(
                                  MyIcons.CustomIcons.radio_button_on_outlined,
                                  size: 25.0,
                                  color: isRadio2Pressed
                                      ? Color(0xFFFFB405)
                                      : Colors.white,
                                ),
                              ),
                              prefixIcon: GestureDetector(
                                child: Transform.rotate(
                                  angle: pi / 4,
                                  child: Icon(
                                    MyIcons.CustomIcons.send_outlined,
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20.0),

                            CustomInputField(
                              controller: companyController,
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              labelText: "Company",
                              isError: isCompanyError,
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
                              controller: registerNumberController,
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              onChanged: (value) {
                                /*   String securedValue = UtilsClass.hideCharacters(
                                    value,
                                    3); // Hide all but the first 3 characters
                                registerNumberController.value =
                                    registerNumberController.value.copyWith(
                                  text: securedValue,
                                  selection: TextSelection.collapsed(
                                      offset: securedValue.length),
                                ); */
                              },
                              labelText: "Register Number",
                              isError: isregisterNumberError,
                              prefixIcon: GestureDetector(
                                child: Icon(
                                  MyIcons.CustomIcons.folder_open_outlined,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                              border: InputBorder.none,
                              keyboardType: TextInputType.number,
                            ),

                            SizedBox(height: 20.0),

                            ActivityPickerExample(
                              onActivitySelected: (value) {
                                activityController.text = value ?? "";
                              },
                            ),

                            SizedBox(height: 20.0),

                            CustomInputField(
                              controller: passwordController,
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              labelText: "Password",
                              isError: isPasswordError,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/EyeIcon.png',
                                  width: 24.0,
                                  height: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              obscureText: !isPasswordVisible,
                            ),

                            SizedBox(height: 20.0),

                            // Login Button
                            GestureDetector(
                              onTap: () {
                                List<dynamic> pageOneData = data;
                                validator.validateInscriptionnPageTwo(
                                    pageOneData,
                                    _formKey,
                                    sellerController,
                                    buyerController,
                                    companyController,
                                    registerNumberController,
                                    activityController,
                                    accountTypeController,
                                    passwordController, (isError) {
                                  setState(() {
                                    isBuyerError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isSellerError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isCompanyError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isregisterNumberError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isActivityError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isAccountError = isError;
                                  });
                                }, (isError) {
                                  setState(() {
                                    isPasswordError = isError;
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
                                    text: 'Register',
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
