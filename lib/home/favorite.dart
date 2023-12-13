import 'package:DllyLas/Config/my_widget.dart';
import 'package:DllyLas/Config/property.dart';
import 'package:DllyLas/controller/cartprovider.dart';
import 'package:DllyLas/main.dart';
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
    return productPro.nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  "Favorite".tr,
                ),
              ),
              body: cartProvider.ListFavId().isEmpty
                  ? !productPro.show
                      ? listItemsBigShimer(context)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: getWidth(context, 100),
                              height: getWidth(context, 100),
                              child:
                                  Image.asset("assets/Victors/fav_empty.png"),
                            ),
                            SizedBox(
                              height: getHeight(context, 2),
                            ),
                            Text(
                              "No have any favorite".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: mainColorBlack,
                                fontFamily: mainFontnormal,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                  : listItemsShow(
                      context,
                      productPro.getProductsByIds(cartProvider.ListFavId()),
                    ),
            ),
          );
  }
}
