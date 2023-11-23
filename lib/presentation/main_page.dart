import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/presentation/account/account_page.dart';
import 'package:flutter_garasi_ev/presentation/my_order/my_order_page.dart';
// import 'package:flutter_garasi_ev/presentation/search/search_page.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

import '../data/datasources/auth_local_datasource.dart';
import 'auth/login_page.dart';
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

  // onTapItem(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  onTapItem(int index) {
    if (index == 2 || index == 3) {
      if (token.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Sorry, the feature cannot be accessed. Please login first"),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
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
            label: 'SmartMatch',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books_outlined,
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
