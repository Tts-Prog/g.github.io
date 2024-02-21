import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:ame/views/explore/explore.dart';
import 'package:ame/views/profile/profile_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  //New
  static const List<Widget> _pages = <Widget>[
    Explore(),
    Placeholder(),
    ProfilePage(),
    //  Menu(),
  ];

  Color tabBarItemColor(int index) {
    return _selectedIndex == index
        ? AppColors.selectedNavBarItem
        : AppColors.unselectedNavBarItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.selectedNavBarItem,
        unselectedItemColor: AppColors.unselectedNavBarItem,
        unselectedFontSize: 10,
        items: <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: ImageIcon(
          //     AssetImage(dashboardIcon),
          //   ),
          //   label: 'Dashboard',
          // ),
          BottomNavigationBarItem(
            icon: ViewUtil.imageAsset4Scale(
                asset: AppAssets.exploreIcon, color: tabBarItemColor(0)),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: ViewUtil.imageAsset4Scale(
                asset: AppAssets.locationNavBar, color: tabBarItemColor(1)),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: ViewUtil.imageAsset4Scale(
                asset: AppAssets.profileNavBar, color: tabBarItemColor(2)),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
