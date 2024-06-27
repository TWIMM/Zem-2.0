import 'package:flutter/material.dart';
import '../Services/Validator.dart';
import '../Commons/AuthInputModel.dart';
import '../Utils/MyIcons.dart' as MyIcons;
import 'Login.dart';
import 'package:agri_market/Commons/custom_text.dart';

void main() {
  runApp(RecoverPwdPage1());
}

Validator validator = Validator();

class CustomIcons {
  static const IconData warning_amber_rounded =
      IconData(0xf02a0, fontFamily: 'MaterialIcons');
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
}

class RecoverPwdPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: frontEnd(),
    );
  }
}

class frontEnd extends StatefulWidget {
  @override
  _frontEndState createState() => _frontEndState();
}

class _frontEndState extends State<frontEnd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add this key
  TextEditingController emailController = TextEditingController();
  bool isChecked = false; // Added the isChecked variable
  bool isEmailError = false;

  Widget customCheckbox() {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: isChecked ? Color(0xFFFFA805) : Colors.white,
            width: 2.0,
          ),
          color: isChecked ? Color(0xFFFFA805) : Colors.transparent,
        ),
        child: isChecked
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
    return SafeArea(
      // Wrap your Scaffold with SafeArea

      child: Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
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
                        SizedBox(width: 5.0),
                        GestureDetector(
                            onTap: () {
                              // Handle the icon's tap action here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Login()), // Navigate to Inscription
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
                                size: 40.0,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      child: StyledText(
                        text: "Veuillez entrer votre E-mail \n ",
                        fontName: "Open Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            // Email Input
                            CustomInputField(
                              controller: emailController,
                              labelStyle: TextStyle(
                                  fontWeight:
                                      FontWeight.bold, // Change the font weight
                                  fontSize: 15,
                                  color: Colors.white
                                  // Change the font size
                                  ),
                              labelText: "Email",
                              isError: isEmailError,
                              border: InputBorder.none,
                            ),

                            SizedBox(height: 20.0),

                            // Text Row under Password Input

                            // Login Button
                            GestureDetector(
                              onTap: () {
                                validator.RecoverPwdValidator(
                                    _formKey, emailController, (isError) {
                                  setState(() {
                                    isEmailError = isError;
                                  });
                                }, context, CustomIcons.warning_amber_rounded,
                                    CustomIcons.cancel_outlined);
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
                                      text: 'Envoyer',
                                      fontName: "Open Sans",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            )
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
