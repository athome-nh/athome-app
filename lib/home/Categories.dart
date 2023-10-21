import 'package:athome/Config/my_widget.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Home/itemCategories.dart';
import 'package:provider/provider.dart';

import 'nav_switch.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    late List<ProductModel> products = productPro.products;

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          backgroundColor: mainColorWhite,
          appBar: AppBar(
            title: Text(
              "All Categories".tr,
              style: TextStyle(
                  color: mainColorGrey,
                  fontFamily: mainFontnormal,
                  fontSize: 24),
            ),
            centerTitle: true,
            backgroundColor: mainColorWhite,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: mainColorRed,
                )),
            bottom: TabBar(
              labelColor: mainColorGrey,
              labelStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: mainFontnormal,
                  color: mainColorGrey),
              // Change the color of the selected tab indicator
              indicatorColor: mainColorRed,
              tabs: [
                Tab(
                  text: "Categories".tr,
                ),
                Tab(text: "Favorite".tr),
              ],
            ),

            // Change the color of the unselected tab labels
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: getHeight(context, 90),
                        width: getWidth(context, 95),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: getWidth(context, 0.25),

                            crossAxisCount: 3, // Number of columns
                          ),
                          itemCount: productPro
                              .categores.length, // Number of items in the grid
                          itemBuilder: (BuildContext context, int index) {
                            final cateItem = productPro.categores[index];
                            // Build each grid item here
                            return Container(
                              //decoration: BoxDecoration(border: Border.all()),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      productPro.setcatetype(cateItem.id!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                itemCategories()),
                                      ).then((value) {
                                        productPro.setsubcateSelect(0);
                                      });
                                    },
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            100), // Adjust the corner radius
                                      ),
                                      child: Container(
                                        width: getHeight(context, 10),
                                        height: getHeight(context, 10),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF2F2F2),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: cateItem.img!,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            width: getHeight(context, 7),
                                            height: getHeight(context, 7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      lang == "en"
                                          ? cateItem.nameEn!
                                          : lang == "ar"
                                              ? cateItem.nameAr!
                                              : cateItem.nameKu!,
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontFamily: mainFontnormal,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (cartProvider.ListFavId().isEmpty) {
                        // list is empty
                        return Container(
                          width: getWidth(context, 100),
                          height: getHeight(context, 75),
                          child: Center(
                            child: Text(
                              "You have no favorite yet",
                              style: TextStyle(
                                  fontFamily: mainFontbold, fontSize: 16),
                            ),
                          ),
                        );
                      } else {
                        // list is not empty
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: listItemsShow(
                            context,
                            productPro
                                .getProductsByIds(cartProvider.ListFavId()),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: buildFAB(context),
        ),
      ),
    );
  }
}
