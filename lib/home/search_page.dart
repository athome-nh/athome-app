import 'package:athome/Config/my_widget.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:athome/Config/property.dart';
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

  TextEditingController searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    searchCon.text = productPro.searchproduct;
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productPro.nointernetCheck
          ? noInternetWidget(context)
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  "Search".tr,
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 4)),
                        child: Container(
                          width: getWidth(context, 92),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              color: const Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(5)),
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
                              suffixIcon: productPro.searchproduct.isNotEmpty
                                  ? TextButton(
                                      onPressed: () {
                                        searchCon.text = "";
                                        productPro.setsearch("");
                                      },
                                      child: Icon(
                                        Ionicons.close,
                                        color: mainColorGrey.withOpacity(0.45),
                                        size: 25,
                                      ),
                                    )
                                  : const SizedBox(),
                              border: InputBorder.none,
                              hintText: "Search".tr,
                              hintStyle: TextStyle(
                                  fontFamily: mainFontnormal,
                                  color: mainColorGrey.withOpacity(0.45),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      productPro
                              .getProductsBySearch(productPro.searchproduct)
                              .isEmpty
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
                                        fontFamily: mainFontnormal,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                          : listItemsShowSearch(
                              context,
                              productPro.getProductsBySearch(
                                  productPro.searchproduct),
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
