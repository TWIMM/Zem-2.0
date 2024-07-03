import 'package:agri_market/Homepage/Add.dart';
import 'package:flutter/material.dart';
import '../Auth/InscriptionPageTwo.dart';
import '../Auth/OtpPage.dart';
import 'package:agri_market/Commons/CustomAlert.dart';
import 'package:agri_market/Homepage/MainScreen.dart';
import 'package:agri_market/Services/AuthServices/Auth.dart';
import 'package:agri_market/Services/OffersServices/Offers.dart';
import 'dart:convert';
import 'package:agri_market/Auth/RecoverPasswordEmail.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:agri_market/provider/BottomProvider.dart';
import 'package:agri_market/Auth/Login.dart';

final AuthService authService = AuthService();
final OfferService offerService = OfferService();

class Validator {
/* Use to check if the payload have required key */

  bool isPayloadValid(Map<String, dynamic> payload, List<String> requiredKeys) {
    // Check if all required keys are present
    bool hasAllKeys = requiredKeys.every((key) => payload.containsKey(key));

    // Check if none of the values associated with the keys are empty
    bool noEmptyValues =
        payload.values.every((value) => value != null && value != "");

    return hasAllKeys && noEmptyValues;
  }

  void RecoverPwdValidator(
    GlobalKey<FormState> formKey,
    TextEditingController emailValue,
    Function(bool) setEmailError,
    BuildContext context,
    IconData CustomIcones1,
    IconData CustomIcones2,
  ) async {
    if (formKey.currentState!.validate()) {
      String email = emailValue.text;
      if (email.isEmpty) {
        setEmailError(true);
        CustomAlert.showalert(
          context,
          'Aucun champs vide !',
          Icon(
            CustomIcones1,
            size: 48.0,
            color: Colors.red,
          ),
        );
      } else {
        setEmailError(false);
        /*   String response = await authService.forgotPwd(email);
        Map<String, dynamic> responseJson = jsonDecode(response); */

        // Show the result in a modal
        showModalBottomSheet(
          context: context,
          backgroundColor:
              Colors.transparent, // Set background color to transparent
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white, // Set the desired background color
                ),
                height: 400,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      '/images/Group5.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Un code OTP vous a été envoyé par email.\n Veuillez l'utiliser afin de valider votre compte",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ]),
                    const SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 50,
                      margin: const EdgeInsets.only(top: 20), // Adjust margin
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0b711b), Color(0xFFFFB405)],
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpPage(
                                    email: email,
                                    customParameter: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecoverPwdPage1()), // Navigate to Inscription
                                      );
                                    })),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                        ),
                        child: const StyledText(
                          text: "Confirmer OTP",
                          fontName: "Open Sans",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      }
    }
  }

  void OTPValidator(
      String email,
      GlobalKey<FormState> formKey,
      TextEditingController digit1,
      TextEditingController digit2,
      TextEditingController digit3,
      TextEditingController digit4,
      TextEditingController digit5,
      Function(bool) setdigit1Error,
      Function(bool) setdigit2Error,
      Function(bool) setdigit3Error,
      Function(bool) setdigit4Error,
      Function(bool) setdigit5Error, // Function to set email error
      BuildContext context,
      IconData CustomIcones1,
      IconData CustomIcones2) async {
    if (formKey.currentState!.validate()) {
      String digit4text = digit4.text;
      String digit1text = digit1.text;
      String digit2text = digit2.text;
      String digit5text = digit5.text;
      String digit3text = digit3.text;

      if (digit1text.isEmpty ||
          digit2text.isEmpty ||
          digit3text.isEmpty ||
          digit4text.isEmpty) {
        setdigit1Error(true);
        setdigit2Error(true);
        setdigit3Error(true);
        setdigit4Error(true);
        setdigit5Error(true);
        CustomAlert.showalert(context, 'Aucun champs vide !', CustomIcones1);
      } else {
        setdigit1Error(false);
        setdigit2Error(false);
        setdigit3Error(false);
        setdigit4Error(false);
        setdigit5Error(false);

        var otpCode =
            digit1text + digit2text + digit3text + digit4text + digit5text;

        String response = await authService.verify(email, otpCode);
        Map<String, dynamic> responseJson = jsonDecode(response);

        print(responseJson);

        if (responseJson['error'] == true) {
          CustomAlertValidate.showalertvalidate(
            context,
            responseJson['message'],
            CustomIcones1,
            'Renvoyer le code OTP',
            () async {
              String response = await authService.resendOtp(email);
              Map<String, dynamic> responseJson = jsonDecode(response);
              print(responseJson);
            },
          );
        } else if (responseJson['error'] == false) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        }

        /*  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpPage()), // Navigate to Inscription
        ); */
      }
    }
  }

  /* Login function for validation */

  void loginValidator(
    GlobalKey<FormState> formKey,
    TextEditingController emailValue,
    TextEditingController passwordValue,
    Function(bool) setEmailError,
    Function(bool) setPasswordError,
    BuildContext context,
    IconData CustomIcones1,
    IconData CustomIcones2,
  ) async {
    if (formKey.currentState!.validate()) {
      String email = emailValue.text;
      String password = passwordValue.text;

      if (email.isEmpty || password.isEmpty) {
        setEmailError(true);
        setPasswordError(true);
        CustomAlert.showalert(context, 'Aucun champs vide !', CustomIcones1);
      } else {
        setEmailError(false);
        setPasswordError(false);

        String response = await authService.login(email, password);
        Map<String, dynamic> responseJson = jsonDecode(response);

        if (responseJson['error'] == true) {
          if (responseJson['message'] ==
              "Votre compte n'est pas vérifié ! veuillez consulter votre mail pour confirmer votre coomtpe") {
            CustomAlertValidate.showalertvalidate(
              context,
              responseJson['message'],
              CustomIcones1,
              'Valider mon compte',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtpPage(
                          email: email,
                          customParameter: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Login()), // Navigate to Inscription
                            );
                          })),
                );
              },
            );
          } else {
            CustomAlert.showalert(
                context, responseJson['message'], CustomIcones1);
          }
        } else if (responseJson['error'] == false) {
          var currentIndexProvider = context.read<CurrentIndexProvider>();

          currentIndexProvider.setAccountDetail('authToken',
              responseJson['data']['jwtAuthentification']['token']);
          currentIndexProvider.setAccountDetail(
              '_id', responseJson['data']['_id']);
          currentIndexProvider.setAccountDetail('user_name',
              "${responseJson['data']['firstName']} ${responseJson['data']['lastName']}");
          currentIndexProvider.setAccountDetail(
              'account_type', responseJson['data']['accountType']);
          currentIndexProvider.setAccountDetail(
              'phone_number', responseJson['data']['phoneNumber']);
          currentIndexProvider.setAccountDetail(
              'user_email', responseJson['data']['email']);
          currentIndexProvider.setAccountDetail(
              'company_name', responseJson['data']['company']['name']);
          currentIndexProvider.setAccountDetail(
              'country', responseJson['data']['info']['country']);
          currentIndexProvider.setAccountDetail(
              'activity', responseJson['data']['company']['activity']);
          currentIndexProvider.setAccountDetail(
              'codeZip', "${responseJson['data']['info']['codeZip']}");
          currentIndexProvider.setAccountDetail('register_number',
              "${responseJson['data']['company']['registerNumber']}");
          currentIndexProvider.setAccountDetail('adress',
              "${responseJson['data']['info']['codeZip']} , ${responseJson['data']['info']['adress']} , ${responseJson['data']['info']['country']}");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }
      }
    }
  }

  /* Post offer validator */
  Future<void> postOffer(Map<String, dynamic> payload, context,
      IconData customIcones2, String authToken,
      {List<String>? requiredKeys}) async {
    requiredKeys ??= [
      "name",
      "images",
      "type",
      "location",
      "price",
      "description",
      "detail",
      "category"
    ];

    if (isPayloadValid(payload, requiredKeys)) {
      List<List<int>?> encodedImages =
          (payload["images"] as List<dynamic>).map((image) {
        if (image is MemoryImage) {
          return image.bytes!.buffer.asUint8List();
        } else {
          return null;
        }
      }).toList();

      payload["images"] = encodedImages;

      var request = http.MultipartRequest('POST',
          Uri.parse('https://api.agrimarket.dev.geminico.cloud/api/v1/offers'));

      payload.forEach((key, value) {
        if (value != null) {
          if (key == "images") {
            // Handle the "images" field separately as an array
            for (var i = 0; i < encodedImages.length; i++) {
              if (encodedImages[i] != null) {
                request.files.add(http.MultipartFile.fromBytes(
                  'images',
                  encodedImages[i]!,
                  filename: 'offer_$i',
                ));
              }
            }
          } else {
            // Handle other fields
            request.fields[key] = value.toString();
          }
        }
      });

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $authToken',
      });

      try {
        var response = await request.send();

        if (response.statusCode == 200) {
          print('Upload successful');

          showModalBottomSheet(
            context: context,
            backgroundColor:
                Colors.transparent, // Set background color to transparent
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white, // Set the desired background color
                  ),
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        '/images/Group5.png',
                        width: 100.0,
                        height: 100.0,
                      ),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Annonce posté avec succès",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ]),
                      const SizedBox(height: 16),
                      Container(
                        width: 200,
                        height: 50,
                        margin: const EdgeInsets.only(top: 20), // Adjust margin
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0b711b), Color(0xFFFFB405)],
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            var currentIndexProvider =
                                context.read<CurrentIndexProvider>();
                            currentIndexProvider.rebuild();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                          ),
                          child: const StyledText(
                            text: "Continuer",
                            fontName: "Open Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          print('Upload failed with status ${response.statusCode}');
        }
      } catch (error) {
        showModalBottomSheet(
          context: context,
          backgroundColor:
              Colors.transparent, // Set background color to transparent
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white, // Set the desired background color
                ),
                height: 400,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      '/images/Group5.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Echec !!",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ]),
                    const SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 50,
                      margin: const EdgeInsets.only(top: 20), // Adjust margin
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0b711b), Color(0xFFFFB405)],
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          var currentIndexProvider =
                              context.read<CurrentIndexProvider>();
                          currentIndexProvider.rebuild();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                        ),
                        child: const StyledText(
                          text: "Reprendre !!",
                          fontName: "Open Sans",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      }
    } else {
      // Handle the case where the payload is not valid
      print("Payload is not valid");
      CustomAlert.showalert(context, 'Aucun champs vide !', customIcones2);
    }
  }

  /* InscriptionPageOne validator */

  void InscriptionPageOneValidator(
    GlobalKey<FormState> formKey,
    TextEditingController emailValue,
    TextEditingController nameValue,
    TextEditingController phoneValue,
    TextEditingController countryValue,
    TextEditingController adressValue,
    TextEditingController zipValue,
    Function(bool) setEmailError, // Function to set email error
    Function(bool) setZipError, // Function to set password error
    Function(bool) setNameError,
    Function(bool) setPhoneError,
    Function(bool) setCountryError,
    Function(bool) setAdressError,
    BuildContext context,
    IconData CustomIcones1,
    IconData CustomIcones2,
  ) {
    if (formKey.currentState!.validate()) {
      String email = emailValue.text;
      String name = nameValue.text;
      String phone = phoneValue.text;
      String adress = adressValue.text;
      String country = countryValue.text;
      String codeZip = zipValue.text;

      if (email.isEmpty ||
          name.isEmpty ||
          phone.isEmpty ||
          country.isEmpty ||
          codeZip.isEmpty ||
          adress.isEmpty) {
        setNameError(true);
        setEmailError(true);
        setPhoneError(true);
        setCountryError(true);
        setAdressError(true);
        setZipError(true);

        CustomAlert.showalert(context, 'Aucun champs vide !', CustomIcones1);
      } else {
        setNameError(true);
        setEmailError(true);
        setPhoneError(true);
        setCountryError(true);
        setAdressError(true);
        setZipError(true);

        final List<dynamic> data = [
          {
            "firstName": name,
            "lastName": "none",
            "phoneNumber": phone,
            "email": email,
            "info": {
              "adress": adress,
              "country": country,
              "codeZip": codeZip,
            },
          }
        ];

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InscriptionPagetwo(data)), // Navigate to Inscription
        );
      }
    }
  }

  /* Inscription Page Two Validator  */

  void validateInscriptionnPageTwo(
    List<dynamic> pageOneData,
    GlobalKey<FormState> formKey,
    TextEditingController sellerValue,
    TextEditingController buyerValue,
    TextEditingController companyValue,
    TextEditingController registerNumberValue,
    TextEditingController activityValue,
    TextEditingController accountTypeValue,
    TextEditingController passwordValue,
    Function(bool) setSellerError, // Function to set email error
    Function(bool) setBuyerError, // Function to set password error
    Function(bool) setCompanyError,
    Function(bool) setRegisterNumberError,
    Function(bool) setActivityError,
    Function(bool) setAccountType,
    Function(bool) setPasswordError,
    BuildContext context,
    IconData CustomIcones1,
    IconData CustomIcones2,
  ) async {
    if (formKey.currentState!.validate()) {
      String company = companyValue.text;
      String registerNumber = registerNumberValue.text;
      String accountType = accountTypeValue.text;
      String activity = activityValue.text;
      String password = passwordValue.text;

      if (company.isEmpty ||
          registerNumber.isEmpty ||
          activity.isEmpty ||
          password.isEmpty ||
          accountType.isEmpty) {
        setSellerError(true);
        setBuyerError(true);
        setCompanyError(true);
        setRegisterNumberError(true);
        setActivityError(true);
        setPasswordError(true);
        setAccountType(true);

        CustomAlert.showalert(context, 'Aucun champs vide !', CustomIcones1);
      } else {
        setSellerError(false);
        setBuyerError(false);
        setCompanyError(false);
        setRegisterNumberError(false);
        setActivityError(false);
        setPasswordError(false);

        dynamic payload = [];

        for (final item in pageOneData) {
          payload = {
            "firstName": item['firstName'],
            "lastName": "none",
            "phoneNumber": item['phoneNumber'],
            "email": item['email'],
            "accountType": accountType,
            "password": password,
            "company": {
              "activity": activity,
              "registerNumber": registerNumber,
              "name": company,
            },
            "info": {
              "adress": item['info']['adress'],
              "country": item['info']['country'],
              "codeZip": item['info']['codeZip'],
            },
          };
        }
        Future<void> register() async {
          String response = await authService.register(payload);
          Map<String, dynamic> responseJson = jsonDecode(response);
          //print(responseJson);

          if (responseJson['error'] == true) {
            CustomAlert.showalert(
                context, responseJson['message'], CustomIcones1);
          } else if (responseJson['error'] == false) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UsageConditionsDialog(context: context, register: register);
          },
        );

        //print(payload);
        /* */
      }
    }
  }

  void loginValidatorWithoutApi(
    GlobalKey<FormState> formKey,
    TextEditingController emailValue,
    TextEditingController passwordValue,
    Function(bool) setEmailError,
    Function(bool) setPasswordError,
    BuildContext context,
    IconData CustomIcones1,
    IconData CustomIcones2,
  ) {
    if (formKey.currentState!.validate()) {
      String email = emailValue.text;
      String password = passwordValue.text;

      if (email.isEmpty || password.isEmpty) {
        setEmailError(true);
        setPasswordError(true);
        CustomAlert.showalert(context, 'Aucun champs vide !', CustomIcones1);
      } else {
        setEmailError(false);
        setPasswordError(false);

        // Simulate successful login (remove actual API call)
        // Example data to set (replace with your actual structure):
        Map<String, dynamic> responseJson = {
          'error': false,
          'data': {
            'jwtAuthentification': {'token': 'dummy_token'},
            '_id': 'user_id',
            'firstName': 'John',
            'lastName': 'Doe',
            'accountType': 'user',
            'phoneNumber': '+1234567890',
            'email': 'john.doe@example.com',
            'company': {
              'name': 'Example Company',
              'registerNumber': '1234567890'
            },
            'info': {
              'country': 'Country',
              'codeZip': '12345',
              'adress': 'Address'
            }
          }
        };

        // Handle the response
        if (responseJson['error'] == false) {
          var currentIndexProvider = context.read<CurrentIndexProvider>();

          // Ensure each nested property is not null before accessing
          currentIndexProvider.setAccountDetail('authToken',
              responseJson['data']?['jwtAuthentification']?['token'] ?? '');
          currentIndexProvider.setAccountDetail(
              '_id', responseJson['data']?['_id'] ?? '');
          currentIndexProvider.setAccountDetail('user_name',
              "${responseJson['data']?['firstName'] ?? ''} ${responseJson['data']?['lastName'] ?? ''}");
          currentIndexProvider.setAccountDetail(
              'account_type', responseJson['data']?['accountType'] ?? '');
          currentIndexProvider.setAccountDetail(
              'phone_number', responseJson['data']?['phoneNumber'] ?? '');
          currentIndexProvider.setAccountDetail(
              'user_email', responseJson['data']?['email'] ?? '');
          currentIndexProvider.setAccountDetail(
              'company_name', responseJson['data']?['company']?['name'] ?? '');
          currentIndexProvider.setAccountDetail(
              'country', responseJson['data']?['info']?['country'] ?? '');
          currentIndexProvider.setAccountDetail(
              'activity', responseJson['data']?['company']?['activity'] ?? '');
          currentIndexProvider.setAccountDetail(
              'codeZip', responseJson['data']?['info']?['codeZip'] ?? '');
          currentIndexProvider.setAccountDetail('register_number',
              responseJson['data']?['company']?['registerNumber'] ?? '');
          currentIndexProvider.setAccountDetail('adress',
              "${responseJson['data']?['info']?['codeZip'] ?? ''}, ${responseJson['data']?['info']?['adress'] ?? ''}, ${responseJson['data']?['info']?['country'] ?? ''}");

          // Navigate to MainScreen after setting account details
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else {
          // Handle error scenario if needed
          CustomAlert.showalert(
              context, 'Error occurred during login', CustomIcones1);
        }
      }
    }
  }
}
