import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Commons/AuthInputModel.dart';
import 'package:agri_market/Utils/MyIcons.dart';
import 'package:agri_market/Commons/BottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:agri_market/Commons/custom_text.dart';
import 'package:agri_market/Commons/custom_annonce.dart';
import 'package:agri_market/provider/BottomProvider.dart';
import 'package:agri_market/Services/OffersServices/Offers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agri_market/Utils/UtilsClass.dart';

final OfferService offerService = OfferService();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  bool shouldRebuild = true; // Introduce a flag

  @override
  bool get wantKeepAlive => true;

  TextEditingController searchController = TextEditingController();
  String selectedCategory = '';
  GlobalKey _firstContainerKey = GlobalKey();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  double textWidth = 0;
  final Map<int, GlobalKey> containerKeys = {};
  // final Map<int, double> categoryWidths = {};
  var authToken;
  bool isSelected = false;
  String SelectedSubCat = "";
  var allOffers = [];
  var recentOffers = [];
  var yesterdayOffer = [];
  var sponsoredOffer = [];
  var currentIndexProvider;
  var countries = [];
  bool isDataloaded = false;
  List contacts = [];
  List<String> categorY = [];

  double firstContainerWidth = 0;
  var selectedCategoryId = 1;

  /*  void getSize(int categoryId) {
    final RenderBox renderBox = containerKeys[categoryId]!
        .currentContext!
        .findRenderObject() as RenderBox;
    final size = renderBox.size;
    setState(() {
      categoryWidths[categoryId] = size.width;
    });
  } */

  Future<void> fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.first.org/data/v1/countries'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        var countriesData = responseData['data'];

        countries = countriesData.values
            .map<String>((country) => country['country'].toString())
            .toList();
        category[2]['subcategories'] = countries;
        // print("countries $category");
      } else {
        throw Exception('Failed to fetch countries: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching countries: $error');
    }
  }

  Future<void> _loadAuthToken() async {
    authToken = await currentIndexProvider.getAccountDetail('authToken');

    // var response = await offerService.getAllOffers(authToken);

    //  var categories = await offerService.getCategories(authToken);

    //var cat = categories['message']['categories']['data']['category'];
    // List<String> mysubcategories = cat.cast<String>();

    categorY = ["VIP", "Moyen"];

    // print("categorY $categorY");
    //  var responseExploited = response['message']['data']['data'];
    allOffers = allOffers = [
      {
        'id': 1,
        'name': 'Honda WR-V',
        'description':
            "Modèle : Toyota Prius V\nAnnée : 2023\nKilométrage : 25,000 km\n\nDescription :\nLa Toyota Prius V est une voiture hybride spacieuse et économique, idéale pour les trajets urbains et les longues distances. Avec son design moderne et ses caractéristiques avancées en matière de sécurité, la Prius V offre une conduite confortable et écologique. Elle est équipée d'une technologie de pointe pour réduire la consommation de carburant et minimiser les émissions, contribuant ainsi à un environnement plus propre.",
        'images': [
          'https://imgd-ct.aeplcdn.com/664x374/n/cw/ec/134205/new-wr-v-right-front-three-quarter.jpeg?isig=0&q=80'
        ]
      },
      {
        'id': 2,
        'name': 'Honda CVr Indonesia',
        'description': 'Description de l\'offre 2 pour Honda CVr Indonesia',
        'images': [
          'https://paultan.org/image/2023/07/2023_Honda_WRV_V_Launch_Malaysia_Ext-2-BM-850x567.jpg'
        ]
      },
      // Add more offers as needed
    ];

    recentOffers = [
      {
        'id': 1,
        'name': 'Honda WR-V',
        'description': 'Description de l\'offre récente pour Honda WR-V',
        'images': [
          'https://imgd-ct.aeplcdn.com/664x374/n/cw/ec/134205/new-wr-v-right-front-three-quarter.jpeg?isig=0&q=80'
        ]
      },
      {
        'id': 2,
        'name': 'Honda CVr Indonesia',
        'description':
            'Description de l\'offre récente pour Honda CVr Indonesia',
        'images': [
          'https://paultan.org/image/2023/07/2023_Honda_WRV_V_Launch_Malaysia_Ext-2-BM-850x567.jpg'
        ]
      },
      // Add more recent offers as needed
    ];

    sponsoredOffer = [
      {
        'id': 1,
        'name': 'Honda WR-V',
        'description': 'Description de l\'offre sponsorisée pour Honda WR-V',
        'images': [
          'https://imgd-ct.aeplcdn.com/664x374/n/cw/ec/134205/new-wr-v-right-front-three-quarter.jpeg?isig=0&q=80'
        ]
      },
      {
        'id': 2,
        'name': 'Honda CVr Indonesia',
        'description':
            'Description de l\'offre sponsorisée pour Honda CVr Indonesia',
        'images': [
          'https://paultan.org/image/2023/07/2023_Honda_WRV_V_Launch_Malaysia_Ext-2-BM-850x567.jpg'
        ]
      },
      // Add more sponsored offers as needed
    ];

    yesterdayOffer = [
      {
        'id': 1,
        'name': 'Lexus WR-V',
        'description': 'Description de l\'offre d\'hier pour Lexus WR-V',
        'images': [
          'https://imgd-ct.aeplcdn.com/664x374/n/cw/ec/134205/new-wr-v-right-front-three-quarter.jpeg?isig=0&q=80'
        ]
      },
      {
        'id': 2,
        'name': 'Honda CVr Indonesia',
        'description':
            'Description de l\'offre d\'hier pour Honda CVr Indonesia',
        'images': [
          'https://paultan.org/image/2023/07/2023_Honda_WRV_V_Launch_Malaysia_Ext-2-BM-850x567.jpg'
        ]
      },
      // Add more yesterday offers as needed
    ];

    /*allOffers = responseExploited['all'];
    recentOffers = responseExploited['recent'];
    sponsoredOffer = responseExploited['sponsored'];
    yesterdayOffer = responseExploited['yesterday']; */
  }

  Future<void> _getContacts() async {
    // Request permission to access contacts
    PermissionStatus status = await Permission.contacts.request();

    if (status == PermissionStatus.granted) {
      // Get all contacts
      contacts = await ContactsService.getContacts(withThumbnails: false);
      //print("contacts : $contacts");
      /* setState(() {
        contactsList = contacts;
      }); */
    } else {
      print("Permission Denied");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentIndexProvider = Provider.of<CurrentIndexProvider>(context);
  }

  @override
  void initState() {
    super.initState();
    fetchCountries();
    _getContacts();
    for (final item in category) {
      containerKeys[item['id']] = GlobalKey();
    }

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // getSize(selectedCategoryId);
      _loadAuthToken();

      // Find the 'Location' category and update its 'subcategories'
      var locationCategoryIndex = category.indexWhere(
        (item) => item['id'] == 3,
      );
      var catCatIndex = category.indexWhere(
        (item) => item['id'] == 2,
      );
      // print('locationCategoryIndex $locationCategoryIndex');
      if (locationCategoryIndex != -1) {
        var locationCategory = category[locationCategoryIndex];
        locationCategory['subcategories'] = countries;
        // Update the modified category back to the list
        category[locationCategoryIndex] = locationCategory;
      }

      if (catCatIndex != -1) {
        category[catCatIndex]['subcategories'] = categorY;
      }
    });
  }

  final List<Map<String, dynamic>> category = [
    {
      "title": "Type",
      "subcategories": ["Auto Partage", "Moto Partage"],
      "id": 1
    },
    {"title": "Catégorie", "subcategories": <String>[], "id": 2},
    {"title": "Location", "subcategories": <String>[], "id": 3},
  ];

  _buildCategoryButtons(currentIndexProvider) {
    return CategoryButtons(
      category: category,
      homecontext: context,
      currentIndexProvider: currentIndexProvider,
      selectedCategoryId: selectedCategoryId,
      containerKeys: containerKeys,
      //categoryWidths: categoryWidths,
      showSubcategoriesDialog: _showSubcategoriesDialog,
    );
  }

  _buildAnnoncesList(List<dynamic> offers) {
    return AnnoncesList(offers: offers);
  }

  Widget _buildSearchBar() {
    return CustomSearch(
      controller: searchController,
      labelText: "Rechercher",
      prefixIcon: const Icon(
        Icons.search,
        color: Color(0xFFFFB405),
      ),
      fillColor: const Color.fromARGB(255, 234, 234, 234),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 51,
    );
  }

  void _showSubcategoriesDialog(BuildContext context, var my_id,
      List<String> subcategories, subcategory) {
    setState(() {
      isSelected = true;
      SelectedSubCat = subcategory;
    });

    currentIndexProvider.updateCategoryLabel(my_id, SelectedSubCat);
    //Navigator.of(context).pop();
    //navigatorKey.currentState?.pop();

    if (kDebugMode) {
      print('Selected subcategory: $SelectedSubCat');
    }
  }

  void toggleRebuildFlag() {
    setState(() {
      shouldRebuild = !shouldRebuild;
    });
  }

  // ... rest of the code ...

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Ensure AutomaticKeepAliveClientMixin is properly used

    if (!shouldRebuild) {
      return const SizedBox
          .shrink(); // Return an empty widget if rebuild is not needed
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFF5F5F8),
        toolbarHeight: 90,
        title: const Column(
          children: [
            StyledText(
              text: 'Parcourez les offres ',
              fontName: "Open Sans",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            StyledText(
              text: 'Les plus récentes',
              fontName: "Open Sans",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Image.asset(
                'assets/images/agrimarket.png',
                width: 60, // Set the desired width
                height: 60, // Set the desired height
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadAuthToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildSearchBar(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Container(
                          width: 115,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(125, 0, 39, 100),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          height: 40,
                          child: Row(
                            children: [
                              loadSvgImage(setting, 30, 30),
                              const SizedBox(width: 3),
                              const StyledText(
                                text: "Trier par",
                                fontName: "Montserrat",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildCategoryButtons(currentIndexProvider),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const StyledText(
                            text: 'Sponsored',
                            fontName: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            onTap: () {
                              currentIndexProvider.setOfferBY(
                                  'appBarTitle', 'Sponsored');
                              currentIndexProvider.setOfferBY(
                                  'listOfOffers', sponsoredOffer);
                              Navigator.pushNamed(context, '/listofferby');
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 25,
                              color: Color.fromARGB(255, 150, 150, 150),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.center,
                      child: sponsoredOffer.isNotEmpty
                          ? _buildAnnoncesList(sponsoredOffer)
                          : const Text('No sponsored offers available'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const StyledText(
                            text: 'Recent',
                            fontName: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            onTap: () {
                              currentIndexProvider.setOfferBY(
                                  'appBarTitle', 'Recent');
                              currentIndexProvider.setOfferBY(
                                  'listOfOffers', recentOffers);
                              Navigator.pushNamed(context, '/listofferby');
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 25,
                              color: Color.fromARGB(255, 150, 150, 150),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.center,
                      child: recentOffers.isNotEmpty
                          ? _buildAnnoncesList(recentOffers)
                          : const Text('No recent offers available'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const StyledText(
                            text: 'Yesterday',
                            fontName: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            onTap: () {
                              currentIndexProvider.setOfferBY(
                                  'appBarTitle', 'Yesterday');
                              currentIndexProvider.setOfferBY(
                                  'listOfOffers', yesterdayOffer);
                              Navigator.pushNamed(context, '/listofferby');
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 25,
                              color: Color.fromARGB(255, 150, 150, 150),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.center,
                      child: yesterdayOffer.isNotEmpty
                          ? _buildAnnoncesList(yesterdayOffer)
                          : const Text('No recent yesterday available'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Display a loading indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTabTapped: (index) {
          context.read<CurrentIndexProvider>().setIndex(index);
        },
      ),
    );
  }
}

class CategoryButtons extends StatefulWidget {
  final List<Map<String, dynamic>> category;
  final BuildContext homecontext;
  final int selectedCategoryId;
  final Map<int, GlobalKey> containerKeys;
  // final Map<int, double> categoryWidths;
  final Function(BuildContext, dynamic, List<String>, dynamic)
      showSubcategoriesDialog;
  final currentIndexProvider;

  const CategoryButtons({
    required this.category,
    required this.homecontext,
    required this.selectedCategoryId,
    required this.containerKeys,
    // required this.categoryWidths,
    required this.showSubcategoriesDialog,
    required this.currentIndexProvider,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoryButtonsState createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {
  String selectedSubCat = "";
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.category.length,
          itemBuilder: (context, int index) {
            final item = widget.category[index];

            String displayText = isSelected &&
                    widget.currentIndexProvider.myselectedCategoryId ==
                        item['id']
                ? selectedSubCat
                : item['title'];

            return Padding(
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  // Show subcategories when a category is tapped

                  UtilsClass.showActivityPickerBottomSheet(
                    context,
                    item['subcategories'],
                    (subcategorySelected) {
                      widget.showSubcategoriesDialog(context, item['id'],
                          item['subcategories'], subcategorySelected);
                    },
                  );

                  setState(() {
                    isSelected = true;
                  });

                  widget.currentIndexProvider
                      .setSimpleProviderValue(item['id']);

                  if (kDebugMode) {
                    print(
                        'Selected cat : ${widget.currentIndexProvider.myselectedCategoryId}');
                  }
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: widget.currentIndexProvider
                                        .myselectedCategoryId ==
                                    item['id']
                                ? const Color.fromARGB(255, 0, 39, 100)
                                : Colors.transparent,
                            width: 3.0, // Adjust the width as needed
                          ),
                        ),
                      ),
                      key: widget.containerKeys[item['id']],
                      child: StyledText(
                        text:
                            widget.currentIndexProvider.getTextById(item['id']),
                        fontName: "Montserrat",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color:
                            widget.currentIndexProvider.myselectedCategoryId ==
                                    item['id']
                                ? const Color.fromARGB(255, 0, 39, 100)
                                : Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AnnoncesList extends StatelessWidget {
  final List<dynamic> offers;

  const AnnoncesList({required this.offers});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: offers.isNotEmpty
          ? _buildAnnoncesList(offers)
          : const Text('No offers available'),
    );
  }

  Widget _buildAnnoncesList(List<dynamic> arrayOfList) {
    List<Widget> annonceWidgets = [];

    int maxDisplayedItems = 2;
    int displayedItems = 0;

    for (final item in arrayOfList) {
      if (displayedItems < maxDisplayedItems) {
        annonceWidgets.add(
          Padding(
            padding: const EdgeInsets.only(right: 0.0, bottom: 16.0),
            child: CustomAnnonce(
              imageUrl: item['images'][0],
              title: item['name'],
              description: item['description'],
              keywords: ["Auto", "Moto", "Zem", "achat", "voiture"],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        displayedItems++;
      } else {
        break; // Break out of the loop if the maximum number of items is reached
      }
    }

    return Column(
      children: annonceWidgets,
    );
  }
}
