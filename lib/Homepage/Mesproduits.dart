import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agri_market/Commons/BottomNavBar.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/provider/BottomProvider.dart';

class MesProduits extends StatefulWidget {
  const MesProduits({super.key});

  @override
  State<MesProduits> createState() => MesProduitsState();
}

class MesProduitsState extends State<MesProduits> {
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
              text: 'Produits enregistré',
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
            ],
          ),
        )),
        bottomNavigationBar: BottomNavBar(
          currentIndex: 3,
          onTabTapped: (index) {
            context.read<CurrentIndexProvider>().setIndex(index);
          },
        ));
  }
}
