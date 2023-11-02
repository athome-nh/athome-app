import 'package:athome/Config/my_widget.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
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
          backgroundColor: mainColorWhite,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Image.asset(
            "assets/images/logoB.png",
            width: getWidth(context, 30),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(context, 1),
                ),
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                    child: Row(
                      children: [
                        Container(
                          width: getWidth(context,
                              productPro.searchproduct.isNotEmpty ? 74 : 90),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              color: const Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Expanded(
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
                                    color: mainColorGrey.withOpacity(0.45),
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        productPro.searchproduct.isNotEmpty
                            ? SizedBox(width: getWidth(context, 4))
                            : const SizedBox(),
                        productPro.searchproduct.isNotEmpty
                            ? SizedBox(
                                width: getWidth(context, 12),
                                child: GestureDetector(
                                    onTap: () {
                                      searchCon.text = "";
                                      productPro.setsearch("");
                                    },
                                    child: Text(
                                      "Clear".tr,
                                      style: TextStyle(
                                          color: mainColorRed,
                                          fontFamily: mainFontbold,
                                          fontSize: 14),
                                    )),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 1),
                ),
                productPro.getProductsBySearch(productPro.searchproduct).isEmpty
                    ? Container(
                        padding: EdgeInsets.only(top: getWidth(context, 40)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: getWidth(context, 60),
                              height: getWidth(context, 60),
                              child:
                                  Image.asset("assets/images/gif_favorite.gif"),
                            ),
                            Text(
                              "Not found any item".tr,
                              style: TextStyle(
                                  fontFamily: mainFontnormal, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : listItemsShow(
                        context,
                        productPro
                            .getProductsBySearch(productPro.searchproduct)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
