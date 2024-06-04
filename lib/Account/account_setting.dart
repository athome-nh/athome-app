import 'dart:convert';
import 'package:dllylas/Account/profilo.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/Order/order_screen.dart';
import 'package:dllylas/Privacy.dart';
import 'package:dllylas/TermsandCondition.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/nav_switch.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {



  @override
  Widget build(BuildContext context) {
    return Provider.of<productProvider>(context, listen: true).nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              // appbar
              appBar: AppBar(
                backgroundColor: mainColorGrey,
                toolbarHeight: 0,
              ),

              // body
              body: !isLogin
                  ? loginFirstContainer(context)
                  : SingleChildScrollView(
                          child: Column(
                            children: [

                              // Title 1
                              SizedBox(height: getHeight(context, 2)),
                              _titles("Account & Security"),

                              // Account Information
                              _listTiles(Icons.person_outline,
                                  'Account Information', Setting()),

                              // Orders
                              _listTiles(Ionicons.bag_outline, 'Orders', OrderScreen()),

                              // Refer a friend
                              _listTiles(Icons.person_add_outlined,
                                  'Refer a friend', TermsandCondition()),

                              // Coin & Reward
                              _listTiles(
                                  Icons.monetization_on_outlined,
                                  'Coin & Reward', TermsandCondition()),

                              // My Voucher
                              _listTiles(
                                  Icons.card_giftcard, 'My Voucher', TermsandCondition()),

                              // Account Settings
                              _listTiles(Icons.settings_outlined,
                                  'Account Settings', TermsandCondition() ),

                              // Title 2
                              SizedBox(height: getHeight(context, 2)),
                              _titles("General"),

                              // Terms & Conditions
                              _listTiles(Icons.description_outlined,
                                  "Terms & Conditions", TermsandCondition()),

                              // Privacy Policy
                              _listTiles(Icons.privacy_tip_outlined,
                                  'Privacy Policy', PrivacyScreen()),

                              // Customer Services
                              _listTiles(
                                  Icons.support_agent, 'Customer Services', TermsandCondition()),

                              // Logout
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    var data = {
                                      "id": userdata["id"].toString()
                                    };
                                    Network(false)
                                        .postData("logout", data, context)
                                        .then((value) {
                                      getStringPrefs("data").then((map) {
                                        Map<String, dynamic> myMap =
                                            json.decode(map);
                                        myMap["islogin"] = false;
                                        myMap["token"] = "";
                                        setStringPrefs(
                                            "data", json.encode(myMap));
                                      });

                                      final cartProvider =
                                          Provider.of<CartProvider>(context,
                                              listen: false);
                                      final product =
                                          Provider.of<productProvider>(context,
                                              listen: false);

                                      setState(() {
                                        userdata = {};
                                        token = "";
                                        isLogin = false;
                                      });
                                      product.Orderitems.clear();
                                      product.location.clear();
                                      product.Orders.clear();
                                      cartProvider.cartItems.clear();
                                      cartProvider.FavItems.clear();

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NavSwitch()),
                                      );
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    minimumSize: Size(double.infinity, 50),
                                    side: BorderSide(color: Colors.grey),
                                  ),
                                  child: Text('Logout'),
                                ),
                              ),
                            
                            ],
                          ),
                        ),
            ),
          );
  }

  Widget _listTiles(IconData icon, String title, Widget destination) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 24),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              title,
              style: TextStyle(                
                fontFamily: mainFontnormal,
                color: mainColorGrey,
                fontSize: 16,
              ),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => destination,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(height: 1, thickness: 1),
        ),
      ],
    );
  }

  Widget _titles(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: mainFontbold,
          color: mainColorGrey,
          fontSize: 16,
        ),
      ),
    );
  }
}
