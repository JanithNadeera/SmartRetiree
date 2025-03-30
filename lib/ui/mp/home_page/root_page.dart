import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_retiree/models/plants.dart';
import 'package:smart_retiree/ui/mp/home_page/gardning_page.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/setting_page.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/update_profile_screen.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/yoga_page.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/favourite_page.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/home_page.dart';
import 'package:smart_retiree/ui/mp/home_page/screens/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Plant> favorites = [];

  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> _widgetOptions() {
    return [
      const HomePage(),
      FavoritePage(
        favoritedPlants: favorites,
      ),
      const YogaPage(),
      const ProfilePage(),
      // const EditProfilePage(),
      // SettingsPage(),
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    Icons.fitness_center,
    Icons.person,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorite',
    'Yoga',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const GardningPage(),
                  type: PageTransitionType.bottomToTop));
        },
        // backgroundColor: Constants.primaryColor,
        backgroundColor: Colors.red,
        child: Image.asset(
          'assets/images/gar.png',
          height: 30.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: Colors.red,
          activeColor: Colors.red,
          inactiveColor: Colors.black,
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
              final List<Plant> favoritedPlants = Plant.getFavoritedPlants();

              favorites = favoritedPlants;
            });
          }),
    );
  }
}
