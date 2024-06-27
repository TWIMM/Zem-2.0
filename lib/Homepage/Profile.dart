import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agri_market/Commons/BottomNavBar.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/provider/BottomProvider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const IconData edit = IconData(0xe21a, fontFamily: 'MaterialIcons');
  var currentIndexProvider;
  var username = "";
  var phone_number = "";
  var user_email = "";
  var activity = "";
  var country = "";
  var adress = "";
  var user_name = "";
  var account_type = "";
  var register_number = "";
  var codeZip = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentIndexProvider = Provider.of<CurrentIndexProvider>(context);
    username = currentIndexProvider.getAccountDetail('user_name');
    phone_number = currentIndexProvider.getAccountDetail('phone_number');
    activity = currentIndexProvider.getAccountDetail('activity');
    user_email = currentIndexProvider.getAccountDetail('user_email');
    phone_number = currentIndexProvider.getAccountDetail('phone_number');
    country = currentIndexProvider.getAccountDetail('country');
    adress = currentIndexProvider.getAccountDetail('adress');
    user_name = currentIndexProvider.getAccountDetail('user_name');
    account_type = currentIndexProvider.getAccountDetail('account_type');
    codeZip = currentIndexProvider.getAccountDetail('codeZip');
    register_number = currentIndexProvider.getAccountDetail('register_number');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: const Color(0xFFF5F5F8),
            toolbarHeight: 90,
            title: const StyledText(
              text: 'Profile',
              fontName: "Open Sans",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            )),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 39, 100).withOpacity(0.3), // Adjust opacity as needed
                  border: const Border(
                      bottom: BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 243, 194, 33))),
                ),
                child: Row(
                  children: [
                    // Circular profile picture with glassmorphism
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 4.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            50.0), // Adjust the radius as needed
                        child: Image.asset(
                          'assets/icons/pp.png',
                          width: 60, // Set the desired width
                          height: 60, // Set the desired height
                        ),
                      ),
                    ),

                    const SizedBox(
                        width:
                            16.0), // Add some spacing between the profile picture and username

                    // Username
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledText(
                          text: "$username",
                          fontName: "Open Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 5),
                        StyledText(
                          text: "$activity",
                          fontName: "Open Sans",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              buildEachpart(),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 113, 113, 113)
                      .withOpacity(0.1), // Adjust opacity as needed
                ),
                child: const StyledText(
                  text: "Informations Professionelles",
                  fontName: "Open Sans",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  textAlign: TextAlign.start,
                ),
              ),
              buildEachpart2(),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 113, 113, 113)
                      .withOpacity(0.1), // Adjust opacity as needed
                ),
                child: const StyledText(
                  text: "Plus d'Options",
                  fontName: "Open Sans",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  textAlign: TextAlign.start,
                ),
              ),
              buildPlusOptions(),
              const SizedBox(height: 1),
              Container(
                alignment: Alignment.center,
                child: const SizedBox(),
              ),
            ],
          ),
        )),
        bottomNavigationBar: BottomNavBar(
          currentIndex: 1,
          onTabTapped: (index) {
            context.read<CurrentIndexProvider>().setIndex(index);
          },
        ));
  }

  Widget buildEachpart() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(
            color: const Color.fromARGB(
                255, 231, 230, 230)), // Border around the entire container
      ),
      child: Column(
        children: [
          buildLine('Mobile', phone_number),
          buildLine('Email', user_email),
          buildLine('Country', country),
        ],
      ),
    );
  }

  Widget buildEachpart2() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        border: Border.all(
            color: const Color.fromARGB(
                255, 231, 230, 230)), // Border around the entire container
      ),
      child: Column(
        children: [
          buildLine('Company Name', phone_number),
          buildLine('Adresse', adress),
          buildLine('Activity', activity),
          buildLine('Account Type', account_type),
          buildLine('Register Number', register_number),
        ],
      ),
    );
  }

  Widget buildPlusOptions() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        border: Border.all(
            color: const Color.fromARGB(
                255, 231, 230, 230)), // Border around the entire container
      ),
      child: Column(
        children: [
          buildLine('Name', user_name),
          buildLine('Password', ''),
          buildLine('Code Zip', codeZip),
        ],
      ),
    );
  }

  /* Widget buildLine2(var left, var right) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Color.fromARGB(
                  255, 231, 230, 230)), // Bottom border for each line
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0), // Adjust padding as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Your content for each line
            Row(
              children: [
                // Your content for each line
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Your content for each line
                    StyledText(
                      text: "$left : $right",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
 */
  Widget buildLine(var top, var bottom) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Color.fromARGB(
                  255, 231, 230, 230)), // Bottom border for each line
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Adjust padding as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Your content for each line
            Row(
              children: [
                // Your content for each line
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Your content for each line
                    StyledText(
                      text: "$top",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),

                    StyledText(
                      text: "$bottom",
                      fontName: "Open Sans",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ],
            ),
             SizedBox(
                width: 60,
                child:
                    // Your content for each line
                    GestureDetector(onTap: () {}, child: Icon(edit, size: 20))),
          ],
        ),
      ),
    );
  }
}
