// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mscoffeeapp/services/auth_service.dart';
import '../helpers/constants.dart';
import './menu_list.dart';
import 'community.dart';
import 'profile.dart';
import 'support.dart';

class MenuScreen extends StatefulWidget {
  static String routeName = 'menuScreen';

  const MenuScreen({Key? key}) : super(key: key);
  static Route<MenuScreen> route() {
    return MaterialPageRoute<MenuScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => const MenuScreen(),
    );
  }

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  final List<Widget> tabs = [
    MenuList(coffees: coffees),

    /// -----------------------------------
    ///  CommunityView or ChatView based on role
    /// -----------------------------------
    if (AuthService.instance.user?.isTWSUser)
      const ChatView()
    else
      const CommunityView(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// -----------------------------------
    ///  profile
    /// -----------------------------------

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text("Welcome ${AuthService.instance.user!.name}"),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          /// -----------------------------------
          ///  implement avatar
          /// -----------------------------------
        ],
      ),
      body: tabs[_selectedIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.brown.shade300,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: "Menu",
        ),

        /// -----------------------------------
        ///  BottomNavigationBarItem nased on user role
        /// -----------------------------------
        BottomNavigationBarItem(
          icon: AuthService.instance.user?.isTWSUser
              ? const Icon(Icons.support_agent)
              : const Icon(Icons.group),
          label: AuthService.instance.user?.isTWSUser ? "Support" : "Community",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.brown.shade800,
      onTap: _onItemTapped,
    );
  }
}
