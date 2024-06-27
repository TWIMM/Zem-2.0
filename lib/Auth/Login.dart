import 'package:flutter/material.dart';
import 'Inscription.dart';
import '../Services/Validator.dart';
import '../Commons/AuthInputModel.dart';
import '../Commons/SocialMediasIconsRow.dart';
import 'RecoverPasswordEmail.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/Homepage/MainScreen.dart';

void main() {
  runApp(Login());
}

Validator validator = Validator();

class CustomIcons {
  static const IconData warning_amber_rounded =
      IconData(0xf02a0, fontFamily: 'MaterialIcons');
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add this key
  final TextEditingController customController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false; // Added the isChecked variable
  bool isPasswordVisible = false; // Added the isPasswordVisible variable
  bool isEmailError = false;
  bool isPasswordError = false;

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center vertically
                      children: <Widget>[
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
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: StyledText(
                        text:
                            "Nous vous souhaitons la bienvenue à la plus \n grande plateforme d'Auto/Moto partage. \n ",
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
                              isError: isEmailError,
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

                            // Text Row under Password Input
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                customCheckbox(), // Use customCheckbox here
                                SizedBox(width: 8.0),
                                StyledText(
                                  text: "Remember me ",
                                  fontName: "Open Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                Spacer(), // Adds space between Checkbox and "Forgot Password"
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecoverPwdPage1()), // Navigate to Inscription
                                    );
                                  },
                                  child: StyledText(
                                    text: "Mot de passe oublié? ",
                                    fontName: "Open Sans",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFFA805),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),

                            SizedBox(height: 20.0),

                            // Login Button
                            GestureDetector(
                              child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 0, 39, 100),
                                       // Use the provided color code
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Center(
                                    child: StyledText(
                                      text: 'Login',
                                      fontName: "Open Sans",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              onTap: () {
                                validator.loginValidator(
                                  _formKey,
                                  emailController,
                                  passwordController,
                                  (isError) {
                                    setState(() {
                                      isEmailError = isError;
                                    });
                                  },
                                  (isError) {
                                    setState(() {
                                      isPasswordError = isError;
                                    });
                                  },
                                  context,
                                  CustomIcons.warning_amber_rounded,
                                  CustomIcons.cancel_outlined,
                                );

                                // Add your button action here
                              },
                            ),

                            Image.asset(
                              'assets/images/OR.png', // Replace with the path to your image
                              width: 300,
                              height: 100,
                            ),

                            SocialMediaIconsRow(),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                StyledText(
                                  text: "Pas de compte? ",
                                  fontName: "Open Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Inscription()), // Navigate to Inscription
                                    );
                                  },
                                  child: StyledText(
                                    text: "S'inscrire ",
                                    fontName: "Open Sans",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFFB405),
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
