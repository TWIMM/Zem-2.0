import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Services/Validator.dart';
import '../Commons/AuthInputModel.dart';
import '../Utils/MyIcons.dart' as MyIcons;
import 'RecoverPasswordEmail.dart';
import '../Commons/custom_text.dart';

void main() {
  runApp(OtpPage(customParameter: () {}, email: ''));
}

Validator validator = Validator();

class CustomIcons {
  static const IconData warning_amber_rounded =
      IconData(0xf02a0, fontFamily: 'MaterialIcons');
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
}

class OtpPage extends StatelessWidget {
  final VoidCallback customParameter;
  final String email;

  OtpPage({required this.customParameter, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FrontEnd(customParameter: customParameter, email: email),
    );
  }
}

class FrontEnd extends StatefulWidget {
  final VoidCallback customParameter;
  final String email;

  FrontEnd({required this.customParameter, required this.email});

  @override
  _frontEndState createState() => _frontEndState();
}

class _frontEndState extends State<FrontEnd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController digit1 = TextEditingController();
  TextEditingController digit2 = TextEditingController();
  TextEditingController digit3 = TextEditingController();
  TextEditingController digit4 = TextEditingController();
  TextEditingController digit5 = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();

  bool isChecked = false;
  bool isEmailError = false;
  bool isDigit2 = false;
  bool isDigit3 = false;
  bool isDigit4 = false;
  bool isDigit5 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
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
                              widget.customParameter();
                            },
                            child: Opacity(
                              opacity: 0.7,
                              child: Icon(
                                MyIcons.CustomIcons.arrow_circle_left_outlined,
                                size: 40.0,
                                color: Colors.white,
                              ),
                            )),
                        Expanded(
                          child: Center(
                            child: Transform.scale(
                              scale: 1.5,
                              child: Image.asset(
                                'assets/images/agrimarket.png',
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecoverPwdPage1()),
                              );
                            },
                            child: Opacity(
                              opacity: 0.01,
                              child: Icon(
                                MyIcons.CustomIcons.arrow_circle_left_outlined,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      child: StyledText(
                        text: "Entrer le code à 5 chiffres ",
                        fontName: "Open Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 50,
                                  height: 100,
                                  color: Colors.transparent,
                                  child: CustomInputField(
                                    controller: digit1,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        focusNode2.requestFocus();
                                      }
                                    },
                                    focusNode: focusNode1,
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                    labelText: "",
                                    isError: isEmailError,
                                    border: InputBorder.none,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 100,
                                  color: Colors.transparent,
                                  child: CustomInputField(
                                    controller: digit2,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        focusNode3.requestFocus();
                                      }
                                    },
                                    focusNode: focusNode2,
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                    labelText: "",
                                    isError: isDigit2,
                                    border: InputBorder.none,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 100,
                                  color: Colors.transparent,
                                  child: CustomInputField(
                                    controller: digit3,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        focusNode4.requestFocus();
                                      }
                                    },
                                    focusNode: focusNode3,
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                    labelText: "",
                                    isError: isDigit3,
                                    border: InputBorder.none,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 100,
                                  color: Colors.transparent,
                                  child: CustomInputField(
                                    controller: digit4,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        focusNode5.requestFocus();
                                      }
                                    },
                                    focusNode: focusNode4,
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                    labelText: "",
                                    isError: isDigit4,
                                    border: InputBorder.none,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 100,
                                  color: Colors.transparent,
                                  child: CustomInputField(
                                    controller: digit5,
                                    focusNode: focusNode5,
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                    labelText: "",
                                    isError: isDigit5,
                                    border: InputBorder.none,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                validator.OTPValidator(
                                  widget.email,
                                  _formKey,
                                  digit1,
                                  digit2,
                                  digit3,
                                  digit4,
                                  digit5,
                                  (isError) {
                                    setState(() {
                                      isEmailError = isError;
                                    });
                                  },
                                  (isError) {
                                    setState(() {
                                      isDigit2 = isError;
                                    });
                                  },
                                  (isError) {
                                    setState(() {
                                      isDigit3 = isError;
                                    });
                                  },
                                  (isError) {
                                    setState(() {
                                      isDigit4 = isError;
                                    });
                                  },
                                  (isError) {
                                    setState(() {
                                      isDigit5 = isError;
                                    });
                                  },
                                  context,
                                  CustomIcons.warning_amber_rounded,
                                  CustomIcons.cancel_outlined,
                                );
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 39, 100),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Center(
                                  child: StyledText(
                                    text: 'Send OTP',
                                    fontName: "Open Sans",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
