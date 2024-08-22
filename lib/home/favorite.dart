// Import necessary packages and libraries
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../controller/productprovider.dart';

/// The `Favorite` widget displays a list of favorite products or a message indicating that
/// there are no favorite items. It also handles different states like no internet connection and login status.
class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    /// Access the product provider to get product data and the cart provider for favorite items.
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    return productPro.nointernetCheck
        ? noInternetWidget(
            context) // Display no internet connection widget if needed
        : Directionality(
            /// Set the text direction based on the language setting (LTR for English, RTL for others).
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  "Favorite".tr, // Localized title for the AppBar
                ),
              ),
              body: !isLogin
                  ? loginFirstContainer(
                      context) // Prompt the user to log in if not logged in
                  : cartProvider.ListFavId().isEmpty
                      ? !productPro.show
                          ? listItemsBigShimer(
                              context) // Display a loading shimmer effect if products are still loading
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: getWidth(context, 100),
                                  height: getWidth(context, 100),
                                  child: Image.asset(
                                      "assets/Victors/fav_empty.png"), // Image indicating no favorite items
                                ),
                                SizedBox(
                                  height: getHeight(context, 2),
                                ),
                                Text(
                                  "No have any favorite"
                                      .tr, // Localized text indicating no favorites
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
                          productPro.getProductsByIds(cartProvider
                              .ListFavId()), // Display the list of favorite products
                        ),
            ),
          );
  }
}