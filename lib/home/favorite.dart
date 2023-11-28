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
              appBar: AppBar(
                title: Text(
                  "Favorite".tr,
                ),
              ),
              body: cartProvider.ListFavId().isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: getWidth(context, 100),
                          height: getWidth(context, 100),
                          child: Image.asset("assets/Victors/fav_empty.png"),
                        ),
                        SizedBox(
                          height: getHeight(context, 2),
                        ),
                        Text(
                          "No have any favorite".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: mainFontnormal,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: listItemsShow(
                        context,
                        productPro.getProductsByIds(cartProvider.ListFavId()),
                      ),
                    ),
            ),
    );
  }
}
