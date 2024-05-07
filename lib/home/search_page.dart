import 'dart:async';

import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:dllylas/Config/property.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late FocusNode _searchFocusNode;
  @override
  void initState() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // Initialize the FocusNode
    _searchFocusNode = FocusNode();

    // Call a method to open the keyboard when the page is opened
    _openKeyboard();
    super.initState();
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final pro = Provider.of<productProvider>(context, listen: false);
    if (result[0] == ConnectivityResult.none) {
      pro.setnointernetcheck(true);
    } else {
      if (pro.nointernetCheck) {
        pro.updatePost(false);
        pro.setnointernetcheck(false);
      }
    }
    setState(() {
      _connectionStatus = result;
    });
  }

  void _openKeyboard() {
    // Delay opening the keyboard slightly to ensure that the text field is fully rendered
    Future.delayed(Duration(milliseconds: 300), () {
      // Request focus on the text field
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  bool isSearch = false;
  TextEditingController searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    searchCon.text = productPro.searchproduct;
    return productPro.nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
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
                  searchCon.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              isSearch = false;
                              searchCon.text = "";
                              productPro.setsearch("");
                            });
                          },
                        )
                      : const SizedBox(),
                ],
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: !productPro.show
                    ? listItemsBigShimer(context)
                    : productPro
                            .getProductsBySearch(productPro.searchproduct)
                            .isEmpty
                        // if not have item
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: getHeight(context, 6),
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
                                        productPro.setsearch(searchCon.text);
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Ionicons.search_outline,
                                          color: mainColorGrey,
                                          size: 20,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: mainColorGrey
                                                  .withOpacity(0.3)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: mainColorGrey.withOpacity(
                                                0.3), // Customize border color
                                          ),
                                        ),
                                        hintText: "Search".tr,
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
                        // if have item
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, left: 15, right: 15),
                                child: Container(
                                  height: getHeight(context, 6),
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
                                      productPro.setsearch(searchCon.text);
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Ionicons.search_outline,
                                        color: mainColorGrey,
                                        size: 20,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color:
                                                mainColorGrey.withOpacity(0.3)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color:
                                                mainColorGrey.withOpacity(0.3)),
                                      ),
                                      hintText: "Search".tr,
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
                                child: listItemsShowSearch(
                                  context,
                                  productPro.getProductsBySearch(
                                      productPro.searchproduct),
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          );
  }
}
