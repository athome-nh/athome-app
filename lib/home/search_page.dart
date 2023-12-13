import 'package:DllyLas/Config/my_widget.dart';
import 'package:DllyLas/controller/productprovider.dart';
import 'package:DllyLas/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:DllyLas/Config/property.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var subscription;
  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      final pro = Provider.of<productProvider>(context, listen: false);
      if (result == ConnectivityResult.none) {
        pro.setnointernetcheck(true);
      } else {
        if (pro.nointernetCheck) {
          pro.updatePost(false);
          pro.setnointernetcheck(false);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

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
                automaticallyImplyLeading: false,
                title: TextField(
                  controller: searchCon,
                  style: TextStyle(
                      fontSize: 16,
                      color: mainColorWhite,
                      fontFamily: mainFontbold),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    productPro.setsearch(searchCon.text);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Ionicons.search_outline,
                      color: mainColorWhite,
                      size: 25,
                    ),
                    hintText: "Search".tr,
                    hintStyle: TextStyle(
                        fontFamily: mainFontnormal,
                        color: mainColorWhite.withOpacity(0.8),
                        fontSize: 14),
                  ),
                ),
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
                                SizedBox(
                                  height: getHeight(context, 10),
                                ),
                                SizedBox(
                                  width: getWidth(context, 100),
                                  height: getWidth(context, 100),
                                  child: Image.asset(
                                      "assets/Victors/serach_empty.png"),
                                ),
                                SizedBox(
                                  height: getHeight(context, 2),
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
                          )
                        // if have item
                        : listItemsShowSearch(
                            context,
                            productPro.getProductsBySearch(
                                productPro.searchproduct),
                          ),
              ),
            ),
          );
  }
}
