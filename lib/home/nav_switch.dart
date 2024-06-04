import 'dart:io';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:dllylas/Account/profile.dart';
import 'package:dllylas/Account/profilo.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/home/favorite.dart';
import 'package:dllylas/home/my_cart.dart';
import 'package:dllylas/home/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:dllylas/Config/property.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'home_page.dart';
import 'package:line_icons/line_icons.dart';

class NavSwitch extends StatefulWidget {
  int pageNum = 0;
  NavSwitch({this.pageNum = 0, Key? key}) : super(key: key);

  @override
  State<NavSwitch> createState() => _NavSwitchState();
}

// Widget buildFAB(BuildContext context) {
//   final cartProvider = Provider.of<CartProvider>(context, listen: true);
//   return Visibility(
//     visible: Provider.of<productProvider>(context, listen: true).nointernetCheck
//         ? false
//         : cartProvider.cartItems.isNotEmpty
//             ? true
//             : false,
//     child: Badge(
//       label: Text(cartProvider.cartItems.length.toString()),
//       backgroundColor: mainColorWhite,
//       textColor: mainColorRed,
//       child: FloatingActionButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const MyCart()),
//           );
//         },
//         backgroundColor: mainColorRed,
//         child: Icon(
//           Ionicons.cart_sharp,
//           size: getHeight(context, 5),
//         ),
//       ),
//     ),
//   );
// }

class _NavSwitchState extends State<NavSwitch> {
  int selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeSreen(),
    // const Search(),
    MyCart(false),
    const Favorite(),
    ProfileScreen(),
  ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    setState(() {
      selectedIndex = widget.pageNum;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          yesNoOption(context);
          return false;
        },
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(selectedIndex),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: mainColorGrey,
                  hoverColor: mainColorGrey,
                  gap: 6,
                  activeColor: mainColorWhite,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: mainColorGrey,
                  color: mainColorGrey,
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: "Home".tr,
                    ),
                    GButton(
                      iconColor: mainColorGrey,
                      textColor: mainColorWhite,
                      rippleColor: mainColorGrey,
                      hoverColor: mainColorGrey,
                      backgroundColor: mainColorGrey,
                      gap: 6,
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      icon: LineIcons.shoppingCart,
                      text: 'Cart'.tr,
                      duration: Duration(milliseconds: 400),
                      leading: cartProvider.cartItems.isNotEmpty
                          ? Badge(
                              label: Text(
                                cartProvider.cartItems.length.toString(),
                              ),
                              backgroundColor: mainColorRed,
                              child: Icon(
                                LineIcons.shoppingCart,
                                color: selectedIndex == 1
                                    ? mainColorWhite
                                    : mainColorGrey,
                              ),
                            )
                          : Icon(
                              LineIcons.shoppingCart,
                              color: selectedIndex == 1
                                  ? mainColorWhite
                                  : mainColorGrey,
                            ),
                    ),
                    GButton(
                      icon: LineIcons.heart,
                      text: 'Favorite'.tr,
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Account'.tr,
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dialogbox ( yes and no )
  Future<void> yesNoOption(
    BuildContext context,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, state) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ClipRect(
                child: Container(
                  width: getWidth(context, 90),
                  height: getHeight(context, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: getHeight(context, 20),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(),
                          Text(
                            "Are you sure exiting the app".tr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(),
                          const SizedBox(),
                          // const SizedBox(),
                          // const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 30),
                                        getHeight(context, 4))),
                                child: Text(
                                  "No".tr,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  exit(0);
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(getWidth(context, 30),
                                        getHeight(context, 4))),
                                child: Text(
                                  "Yes".tr,
                                ),
                              ),
                              const SizedBox(),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
