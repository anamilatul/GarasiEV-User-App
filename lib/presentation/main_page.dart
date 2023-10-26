import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/presentation/account/account_page.dart';
import 'package:flutter_garasi_ev/presentation/my_order/my_order_page.dart';
// import 'package:flutter_garasi_ev/presentation/search/search_page.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

import '../data/datasources/auth_local_datasource.dart';
import 'home/home_page.dart';
import 'search/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    MyOrderPage(),
    AccountPage(),
  ];
  String token = '';
  @override
  void initState() {
    AuthLocalDataSource().getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    super.initState();
  }

  onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.electric_scooter,
            ),
            label: 'Find',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description_outlined,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onTapItem,
        selectedItemColor: ColorResources.primaryMaterial,
        unselectedItemColor: const Color.fromARGB(255, 192, 189, 189),
      ),
    );
  }
}
