import 'package:flutter/material.dart';
import 'package:agri_market/Utils/MyIcons.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabTapped;
  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF04366E),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: [
        _buildNavItem(
          index: 0,
          icon: Icons.home_outlined,
        ),
        _buildNavItem(
          icon: Icons.sms_outlined,
          index: 1,
        ),
        _buildNavItem(
          icon: Icons.add_circle_sharp,
          index: 2,
        ),
        _buildNavItem(
          icon: Icons.bookmarks_outlined,
          index: 3,
        ),
        _buildNavItem(
          icon: Icons.search_rounded,
          index: 4,
        ),
        _buildNavItem(
          icon: Icons.account_circle_outlined,
          index: 5,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem({
    IconData? icon,
    String? svgPath,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: icon != null
                ? Icon(
                    icon,
                    size: currentIndex == 2 ? 37 : 33,
                    color: /*  currentIndex == index
                        ? const Color.fromRGBO(230, 179, 38, 1)
                        :      : */
                        Colors.white,
                  )
                : svgPath != null
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          /*   currentIndex == index
                              ? const Color.fromRGBO(230, 179, 38, 1)
                              : */
                          Colors.transparent,
                          BlendMode.srcIn,
                        ),
                        child: loadSvgImage(svgPath, 35, 35),
                      )
                    : null,
          ),
          if (currentIndex == index)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  // height: 3,
                  // color: Colors.blue,
                  ),
            ),
        ],
      ),
      label: '',
    );
  }
}
