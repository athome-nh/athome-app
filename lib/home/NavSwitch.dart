import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:athome/Account/account_screen.dart';
import 'package:athome/Account/order_screen.dart';

import 'package:athome/configuration.dart';
import 'package:athome/home/Homepage.dart';
import 'package:athome/home/MyCart.dart';
import 'package:athome/home/Search.dart';

class NavSwitch extends StatefulWidget {
  const NavSwitch({super.key});

  @override
  State<NavSwitch> createState() => _NavSwitchState();
}

class _NavSwitchState extends State<NavSwitch> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const Home_SC(),
    Search(),
      OrderScreen(),
   AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: mainColorGrey.withOpacity(0.1), // Border color
              width: 1.0, // Border width
            ),
          ),
        ),
        child: BottomNavigationBar(
          //showUnselectedLabels: false,

          backgroundColor: Color(0xffF2F2F2),
          selectedItemColor: mainColorRed,
          unselectedItemColor: mainColorGrey,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Ionicons.home,
                ),
                icon: Icon(
                  Ionicons.home_outline,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.search_outline,
              ),
              activeIcon: Icon(
                Ionicons.search,
              ),
              label: 'Search',
            ),
              BottomNavigationBarItem(
              icon: Icon(
                     Icons.shopping_bag_outlined,
              ),
              activeIcon: Icon(
                  Icons.shopping_bag,
              ),
              label: 'My Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.person_outline,
              ),
              activeIcon: Icon(
                Ionicons.person,
              ),
              label: 'Account',
            ),
          ],

          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCart()),
            );
          },
          child: Icon(
            Ionicons.cart_sharp,
            size: getHeight(context, 5),
          ),
          backgroundColor: mainColorRed,
        ),
      ),
    );
  }
}
