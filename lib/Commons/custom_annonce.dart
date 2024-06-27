import 'package:flutter/material.dart';
import 'package:agri_market/Commons/custom_text.dart';

class CustomAnnonce extends StatefulWidget {
  final bool? isBackground;
  final String imageUrl;
  final BorderRadius borderRadius;
  final String title;
  final String description;
  final List<String> keywords;

  const CustomAnnonce(
      {Key? key,
      required this.title,
      required this.description,
      required this.keywords,
      this.isBackground = false,
      required this.imageUrl,
      required this.borderRadius})
      : super(key: key);

  @override
  _CustomAnnonceState createState() => _CustomAnnonceState();
}

class _CustomAnnonceState extends State<CustomAnnonce> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Container(
            width: deviceWidth,
            height: 140,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: OverflowBox(
              maxWidth: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: deviceWidth * 0.3,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    child: const SizedBox(),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    width: ((deviceWidth * 0.55) - 15),
                    child: _buildAnnonceText(
                      widget.title,
                      widget.description,
                      widget.keywords,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 39, 100),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: deviceWidth * 0.1,
                      height: deviceWidth * 0.1,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isBookmarked = !isBookmarked;
                            });
                          },
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmarks
                                : Icons.bookmarks_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnnonceText(title, description, keywords) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText(
            text: title,
            fontName: "Open Sans",
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontFamily: "Open Sans",
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            maxLines: 3, // Set the maximum number of lines
            overflow: TextOverflow
                .ellipsis, // Add this line to show ellipsis if text overflows
          ),
          SizedBox(height: 10),
          _buildCategoryButtons()
        ]);
  }

  Widget _buildCategoryButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.keywords.length,
          itemBuilder: (context, int index) {
            final item = widget.keywords[index];
            // print(widget.keywords);
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child: StyledText(
                  text: item,
                  fontName: "Montserrat",
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 229, 162, 7),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
