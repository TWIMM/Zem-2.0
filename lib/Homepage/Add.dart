import 'package:flutter/material.dart';
import '../Commons/AuthInputModel.dart';
import 'package:agri_market/Commons/custummessagealerte.dart';
import 'package:agri_market/Utils/MyIcons.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/Homepage/Home.dart';
import 'package:provider/provider.dart';
import 'package:agri_market/Commons/BottomNavBar.dart';
import 'package:agri_market/Commons/drop.dart';
import 'package:agri_market/provider/BottomProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import '../Services/Validator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:agri_market/Commons/dropConditions.dart';
import 'package:agri_market/Commons/dropSeats.dart';
import 'package:agri_market/Commons/DropGmaps.dart';


Validator validator = Validator();

class Add extends StatefulWidget {
  const Add({Key? key});

  @override
  State<Add> createState() => _MessagesState();
}

class _MessagesState extends State<Add> {
  TextEditingController searchController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController kilometrageController = TextEditingController();
  TextEditingController marqueController = TextEditingController();
  TextEditingController seatsController = TextEditingController(); 
  TextEditingController conditionController = TextEditingController(); // New controller for état

  List<MemoryImage?> selectedImages = List.generate(4, (index) => null);
  var authToken;
  var currentIndexProvider;

  bool isErrorPrice = false;
  String type = "";
  bool isAchatSelected = true;
  bool isVenteSelected = false;
  var _id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentIndexProvider = Provider.of<CurrentIndexProvider>(context);

    authToken = currentIndexProvider.getAccountDetail('authToken');
    print("Add $authToken");
    _id = currentIndexProvider.getAccountDetail('_id');
  }

  @override
  void initState() {
    super.initState();
    // Example: Get the authentication token from a hypothetical AuthService class
    // authToken = currentIndexProvider.getAccountDetail('authToken');
    // print("Add $authToken");
    // _id = currentIndexProvider.getAccountDetail('_id');
  }

  @override
  Widget build(BuildContext context) {
    // final currentIndex = context.watch<CurrentIndexProvider>().currentIndex;

    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 90,
          title: Column(
            children: [
              StyledText(
                text: 'Publier une offre',
                fontName: "Open Sans",
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              SizedBox(height: 6),
              StyledText(
                text: 'Annonce',
                fontName: "Open Sans",
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(height: 30),
                TextField(
                  controller: _descriptionController,
                  minLines: 10,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    filled: true,
                    fillColor: Color(0xFFF5F5F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyledText(
                      text: 'Photos',
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                MyRowWithCircles(context),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyledText(
                      text: "Type d'annonce",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                offerTypes(),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyledText(
                      text: "Pays de l'annonce",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                DropGmaps(
                  onActivitySelected: (value) {
                      countryController.text = value ?? "";
                  },
                ),
               /*  DropdownMenuExample(
                  color: Colors.black,
                  country: countryController, 
                  bordercolor: Color.fromARGB(255, 4, 209, 11),
                  onCountrySelected: (value) {
                    countryController.text = value ?? "";
                  },
                ), */
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyledText(
                      text: "Nombre de place du véhicule",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 15), 
                dropSeats(
                   onActivitySelected: (value) {
                      seatsController.text = value ?? "";
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyledText(
                      text: "Condition du véhicule",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 15), 
                dropCondition(
                   onActivitySelected: (value) {
                      conditionController.text = value ?? "";
                  },
                ), 
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyledText(
                      text: "Prix de l'annonce",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                MyCustomInputField(
                  controller: priceController,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  labelText: "0 USD",
                  isError: isErrorPrice,
                  border: InputBorder.none,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyledText(
                      text: "Marque",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                MyCustomInputField(
                  controller: marqueController,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  labelText: "Marque",
                  isError: isErrorPrice,
                  border: InputBorder.none,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyledText(
                      text: "Kilométrage",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                MyCustomInputField(
                  controller: kilometrageController,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  labelText: "KmH",
                  isError: isErrorPrice,
                  border: InputBorder.none,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyledText(
                      text: "Titre de l'annonce",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                MyCustomInputField(
                  controller: titleController,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  labelText: "Entrez le titre",
                  isError: isErrorPrice,
                  border: InputBorder.none,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        var payload = {
                          "name": titleController.text,
                          "images": selectedImages,
                          "type": type,
                          "location": countryController.text,
                          "price": priceController.text,
                          "description": _descriptionController.text,
                          "detail": "Detail",
                          "category": "Category",
                          "createdBy": _id,
                        };
                        //print(payload);
                        validator
                            .postOffer(payload, context,
                                CustomIcons.warning_amber_rounded, authToken)
                            .then((result) {
                          setState(() {
                            // Set TextEditingController instances to empty
                            searchController = TextEditingController();
                            _descriptionController = TextEditingController();
                            titleController = TextEditingController();
                            countryController = TextEditingController();
                            priceController = TextEditingController();

                            // Set selectedImages list to empty
                            selectedImages = List.generate(4, (index) => null);
                          });
                        });
                      },
                      child: Container(
                        width: 160,
                        height: 40,
                        decoration: BoxDecoration(
                          color:  Color.fromARGB(255, 0, 39, 100),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: StyledText(
                            text: "Publier l'annonce",
                            fontName: "Open Sans",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: 2,
          onTabTapped: (index) {
            context.read<CurrentIndexProvider>().setIndex(index);
          },
        ));
  }

  final String imageUrl = 'https://ottawa-canada.net/add-photo 1.png';
  final String imageUrlAchat = 'https://ottawa-canada.net/buy 1.png';
  final String imageUrlVente = 'https://ottawa-canada.net/buy 2.png';

  _showSubcategoriesDialog(BuildContext context, var index) async {
    bool? useFilePicker = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('From Gallery'),
                  tileColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                const Divider(
                  color: Color.fromARGB(255, 231, 230, 230),
                  height: 20,
                ),
                ListTile(
                  title: Text('From Camera'),
                  tileColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (useFilePicker != null) {
      if (useFilePicker) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );

        if (result != null && result.files.isNotEmpty) {
          Uint8List fileBytes = result.files.first.bytes!;
          setState(() {
            selectedImages[index] = MemoryImage(fileBytes);
          });
        }
      } else {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );

        if (pickedFile != null) {
          File imageFile = File(pickedFile.path);
          var fileBytes = await imageFile.readAsBytes();

          setState(() {
            selectedImages[index] = MemoryImage(Uint8List.fromList(fileBytes));
          });
        }
      }
    }
  }

  // Remplacez par votre URL d'image
  Widget MyRowWithCircles(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        4,
        (index) => GestureDetector(
          onTap: () async {
            await _showSubcategoriesDialog(context, index);
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color.fromARGB(255, 220, 218, 218),
              image: selectedImages[index] != null
                  ? DecorationImage(
                      image: selectedImages[index]!,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: Stack(
              children: [
                // Cercle au centre
                Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: selectedImages[index] != null
                          ? Color.fromARGB(255, 197, 196, 196).withOpacity(0.3)
                          : Color.fromARGB(255, 197, 196, 196),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                                'assets/icons/Camera.png',
                                height: 10,
                                width:10
                              ), /* Image.network(
                        imageUrl,
                        width: 10,
                        height: 10,
                      ), */
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget offerTypes() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: () {
          setState(() {
            isAchatSelected = true;
            isVenteSelected = false;
            type = 'MotoPartage';
          });
        },
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: isAchatSelected
                ? Color.fromARGB(255, 0, 39, 100) // Selected color
                : Color.fromARGB(125, 0, 39, 100), // Adjusted opacity for not selected
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /* Image.network(
                  imageUrlAchat,
                  width: 15,
                  height: 30,
                ), */
                StyledText(
                  text: 'Moto partage',
                  fontName: "Open Sans",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(width: 10, height: 10),
      GestureDetector(
        onTap: () {
          setState(() {
            isAchatSelected = false;
            type = 'AutoPartage';
            isVenteSelected = true;
          });
        },
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: isVenteSelected
                ? Colors.red
                : Color.fromARGB(255, 243, 115, 106), // Adjust opacity
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StyledText(
                  text: 'Auto partage',
                  fontName: "Open Sans",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
               /*  Image.network(
                  imageUrlVente,
                  width: 15,
                  height: 30,
                ), */
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

class MyCustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final onChanged;
  final String labelText;
  final bool isError;
  final Widget? suffixIcon;
  final Widget? prefixIcon; // Add a nullable suffix icon parameter
  final bool? obscureText;
  final InputBorder? border;
  final TextStyle? labelStyle;
  final bool? enabled;
  final TextInputType? keyboardType;

  const MyCustomInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.isError,
    this.suffixIcon, // Make the suffix icon optional
    this.prefixIcon,
    this.onChanged,
    this.obscureText,
    this.border,
    this.labelStyle,
    this.enabled,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      style: TextStyle(color: Colors.black),
      obscureText:
          obscureText ?? false, // Set obscureText or use a default value
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: isError ? Colors.red :  Color.fromARGB(255, 0, 39, 100),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: isError ? Colors.red : Color.fromARGB(255, 0, 39, 100),
          ),
        ),
        suffixIcon: suffixIcon, // Use the provided suffix icon
        prefixIcon: prefixIcon,
        errorStyle: TextStyle(color: Colors.white),
        fillColor: const Color.fromARGB(255, 184, 180, 180).withOpacity(0.2),
        filled: true,
        labelStyle: labelStyle,
        border: InputBorder.none,
      ),
      keyboardType: keyboardType,
    );
  }
}

class CustomIcons {
  static const IconData warning_amber_rounded =
      IconData(0xf02a0, fontFamily: 'MaterialIcons');
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');
}
