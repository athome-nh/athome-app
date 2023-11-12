import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controller/productprovider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productPro.nointernetCheck
          ? noInternetWidget(context)
          : Scaffold(
              backgroundColor: mainColorWhite,
              appBar: AppBar(
                title: Text(
                  "Favorite".tr,
                  style: TextStyle(
                      color: mainColorGrey,
                      fontFamily: mainFontnormal,
                      fontSize: 20),
                ),
                centerTitle: true,
                backgroundColor: mainColorWhite,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (cartProvider.ListFavId().isEmpty) {
                      // list is empty
                      return SizedBox(
                        width: getWidth(context, 100),
                        height: getHeight(context, 60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: getWidth(context, 50),
                              height: getWidth(context, 70),
                              child:
                                  Image.asset("assets/images/gif_favorite.gif"),
                            ),
                            Text(
                              "No have any favorite".tr,
                              style: TextStyle(
                                  fontFamily: mainFontnormal, fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // list is not empty
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: listItemsShow(
                          context,
                          productPro.getProductsByIds(cartProvider.ListFavId()),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
    );
  }
}
