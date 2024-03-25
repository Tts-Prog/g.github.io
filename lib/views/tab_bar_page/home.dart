import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:ame/views/events_map/events_map.dart';
import 'package:ame/views/explore/explore.dart';
import 'package:ame/views/profile/profile_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.email, required this.id})
      : super(key: key);

  final String email, id;

  static String routeName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String email = "";
  String id = "";
  @override
  void initState() {
    // TODO: implement initState
    email = widget.email;
    id = widget.id;
    super.initState();
  }

  //New
  List<Widget> pageList() {
    List<Widget> listOfPages = <Widget>[
      Explore(
        id: id,
        email: widget.email,
      ),
      EventsMap(
        id: id,
        email: widget.email,
      ),
      ProfilePage(
        id: id,
        email: widget.email,
      ),
    ];
    return listOfPages;
  }

  //static List<Widget> _pages =

  Color tabBarItemColor(int index) {
    return _selectedIndex == index
        ? AppColors.selectedNavBarItem
        : AppColors.unselectedNavBarItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList().elementAt(_selectedIndex),
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
