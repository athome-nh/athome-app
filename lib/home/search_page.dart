// Import necessary packages and libraries
import 'dart:async';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/my_cart.dart';
import 'package:dllylas/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:dllylas/Config/property.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

/// A screen that allows users to search for products.
/// It handles connectivity issues and displays search results or appropriate messages.
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // Keeps track of the current connectivity status
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  
  // Used to listen for connectivity changes
  final Connectivity _connectivity = Connectivity();
  
  // Subscription to manage connectivity change events
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  
  // FocusNode for the search TextField to manage its focus
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    
    // Start listening to connectivity changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    // Initialize FocusNode to manage search TextField's focus
    _searchFocusNode = FocusNode();

    // Automatically open the keyboard after a slight delay
    _openKeyboard();
  }

  @override
  void dispose() {
    // Cancel the connectivity subscription when the widget is disposed
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Updates the connectivity status and informs the product provider
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final pro = Provider.of<productProvider>(context, listen: false);

    // Check if there is no internet connection
    if (result[0] == ConnectivityResult.none) {
      pro.setnointernetcheck(true);
    } else {
      // If there was no internet previously, update the product provider
      if (pro.nointernetCheck) {
        pro.updatePost(false);
        pro.setnointernetcheck(false);
      }
    }
    setState(() {
      _connectionStatus = result;
    });
  }

  // Opens the keyboard after a slight delay to ensure the TextField is rendered
  void _openKeyboard() {
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  // GlobalKey for form state management
  final formKey = GlobalKey<FormState>();
  
  // Controller to manage the search text field's text
  TextEditingController searchCon = TextEditingController();
  
  // Flag to manage search state (whether it is active or not)
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    // Access the product provider and cart provider
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    // Set the search text controller to the current search text
    searchCon.text = productPro.searchproduct;

    return productPro.nointernetCheck
        // Display a no internet connection widget if the connectivity check fails
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    // Clear the search field and navigate back
                    isSearch = false;
                    searchCon.text = "";
                    productPro.setsearch("");
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                automaticallyImplyLeading: true,
                title: Text("Search".tr),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyCart(true)),
                        );
                      },
                      icon: cartProvider.cartItems.isNotEmpty
                          // Show a badge with the number of items if the cart is not empty
                          ? Badge(
                              label: Text(
                                cartProvider.cartItems.length.toString(),
                              ),
                              backgroundColor: mainColorRed,
                              child: Icon(
                                size: 30,
                                LineIcons.shoppingCart,
                                color: mainColorGrey,
                              ),
                            )
                          : Icon(
                              size: 30,
                              LineIcons.shoppingCart,
                              color: mainColorGrey,
                            ),
                    ),
                  ),
                ],
              ),
              body: GestureDetector(
                onTap: () {
                  // Dismiss the keyboard when tapping outside the TextField
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: !productPro.show
                    // Show a loading shimmer effect while products are being fetched
                    ? listItemsBigShimer(context)
                    : productPro
                            .getProductsBySearch(productPro.searchproduct)
                            .isEmpty
                        // Show a message when no products are found
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      left: 10,
                                      right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: mainColorlightGrey,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: mainColorlightGrey)),
                                    height: getHeight(context, 7),
                                    child: TextField(
                                      key: formKey,
                                      focusNode: _searchFocusNode,
                                      controller: searchCon,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: mainColorGrey,
                                          fontFamily: mainFontbold),
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        // Update the search query in the provider
                                        productPro.setsearch(searchCon.text);
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: searchCon.text.isNotEmpty
                                            ? IconButton(
                                                icon: const Icon(Icons.cancel),
                                                onPressed: () {
                                                  setState(() {
                                                    // Clear the search field
                                                    isSearch = false;
                                                    searchCon.text = "";
                                                    productPro.setsearch("");
                                                  });
                                                },
                                              )
                                            : const SizedBox(),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Ionicons.search_outline,
                                                color: mainColorGrey,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                  width: getWidth(context, 2)),
                                              Container(
                                                height: 20,
                                                width: 2,
                                                color: mainColorGrey2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: mainColorlightGrey),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: mainColorlightGrey,
                                          ),
                                        ),
                                        hintText: "What are you searching for?",
                                        hintStyle: TextStyle(
                                            fontFamily: mainFontnormal,
                                            color:
                                                mainColorBlack.withOpacity(0.4),
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: getWidth(context, 80),
                                          height: getWidth(context, 80),
                                          child: Image.asset(
                                              "assets/Victors/serach_empty.png"),
                                        ),
                                        SizedBox(
                                          height: getHeight(context, 5),
                                        ),
                                        Text(
                                          "Not found any item".tr,
                                          style: TextStyle(
                                              color: mainColorBlack,
                                              fontFamily: mainFontnormal,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        // Show the list of search results if any items are found
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      left: 10,
                                      right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: mainColorlightGrey,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: mainColorlightGrey)),
                                    height: getHeight(context, 7),
                                    child: TextField(
                                      key: formKey,
                                      focusNode: _searchFocusNode,
                                      controller: searchCon,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: mainColorGrey,
                                          fontFamily: mainFontbold),
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        // Update the search query in the provider
                                        productPro.setsearch(searchCon.text);
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: searchCon.text.isNotEmpty
                                            ? IconButton(
                                                icon: const Icon(Icons.cancel),
                                                onPressed: () {
                                                  setState(() {
                                                    // Clear the search field
                                                    isSearch = false;
                                                    searchCon.text = "";
                                                    productPro.setsearch("");
                                                  });
                                                },
                                              )
                                            : const SizedBox(),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Ionicons.search_outline,
                                                color: mainColorGrey,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                  width: getWidth(context, 2)),
                                              Container(
                                                height: 20,
                                                width: 2,
                                                color: mainColorGrey2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: mainColorlightGrey),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: mainColorlightGrey),
                                        ),
                                        hintText: "What are you searching for?",
                                        hintStyle: TextStyle(
                                            fontFamily: mainFontnormal,
                                            color:
                                                mainColorBlack.withOpacity(0.4),
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: listItemsShow(
                                    context,
                                    productPro.getProductsBySearch(
                                        productPro.searchproduct),
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
            ),
          );
  }
}
