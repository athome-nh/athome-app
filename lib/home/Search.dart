
import 'package:athome/Config/my_widget.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';

import 'package:athome/main.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'package:athome/Config/property.dart';

import 'package:provider/provider.dart';

import 'package:skeletonizer/skeletonizer.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    searchCon.text = productPro.searchproduct;
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logoB.png",
            width: getWidth(context, 30),
          ),
          backgroundColor: mainColorWhite,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: getWidth(context, 80),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
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
                                        color: mainColorGrey.withOpacity(0.45),
                                        size: 25,
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Search".tr,
                                      hintStyle: TextStyle(
                                          fontFamily: mainFontnormal,
                                          color:
                                              mainColorGrey.withOpacity(0.45))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        productPro.searchproduct.isNotEmpty
                            ? TextButton(
                                onPressed: () {
                                  searchCon.text = "";
                                  productPro.setsearch("");
                                },
                                child: Text(
                                  "Clear".tr,
                                  style: TextStyle(
                                      color: mainColorRed,
                                      fontFamily: mainFontbold,
                                      fontSize: 16),
                                ))
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                listItemsShow(context,
                    productPro.getProductsBySearch(productPro.searchproduct)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
