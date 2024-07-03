import 'package:flutter/material.dart';
import '../Commons/AuthInputModel.dart';
import 'package:agri_market/Commons/custummessagealerte.dart';
import 'package:agri_market/Utils/MyIcons.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/Homepage/Home.dart';
import 'package:provider/provider.dart';
import 'package:agri_market/Commons/BottomNavBar.dart';

import 'package:agri_market/provider/BottomProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:agri_market/Homepage/Chat.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final currentIndex = context.watch<CurrentIndexProvider>().currentIndex;

    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: const Color(0xFFF5F5F8),
            toolbarHeight: 90,
            title: const StyledText(
              text: 'Messages',
              fontName: "Open Sans",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            )),
        body: Column(
          children: [
            const SizedBox(height: 20),
            CustomSearch(
                controller: searchController,
                labelText: "Rechercher",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFFFFB405),
                ),
                fillColor: const Color.fromARGB(255, 234, 234, 234),
                width: deviceWidth * 0.9,
                height: 51,
                onChanged: (ValueKey) {}),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/chat_detail');
                },
                child: messageAlert(
                  numberofunread: 3,
                  sender: 'Geminico Ceo',
                  imageUrl: pp,
                ),
              ),
            ),
            const SizedBox(height: 1),
            Container(
              alignment: Alignment.center,
              child: messageAlert(
                numberofunread: 10,
                sender: 'Monkey D Luffy',
                imageUrl: annonce2,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: 1,
          onTabTapped: (index) {
            context.read<CurrentIndexProvider>().setIndex(index);
          },
        ));
  }
}
