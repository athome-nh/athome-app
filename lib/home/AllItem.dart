import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Switchscreen.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';

import 'package:athome/home/NavSwitch.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Config/athome_functions.dart';
import '../main.dart';

class AllItem extends StatefulWidget {
  const AllItem({super.key});

  @override
  State<AllItem> createState() => _AllItemState();
}

class _AllItemState extends State<AllItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    String type = productPro.allitemType;

    late List<ProductModel> products = type == "discount"
        ? productPro.getProductsByDiscount()
        : type == "Highlight".tr
            ? productPro.getProductsByHighlight()
            : productPro.getProductsByBestsell();
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            type == "discount"
                ? "Discount".tr
                : type == "Highlight"
                    ? "Highlight".tr
                    : "Best Sell".tr,
            style: TextStyle(
                color: mainColorGrey, fontFamily: Speda, fontSize: 24),
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

          // Change the color of the unselected tab labels
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: getHeight(context, 90),
                  width: getWidth(context, 95),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: getWidth(context, 0.5),
                      mainAxisSpacing: getHeight(context, 2),
                      childAspectRatio: getHeight(context, 0.07),
                    ),

                    itemCount: products.length, // Number of items in the grid
                    itemBuilder: (BuildContext context, int index) {
                      final product = products[index];
                      final isItemInCart =
                          cartProvider.itemExistsInCart(product);
                      final isFavInCart = cartProvider.FavExistsInCart(product);
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 2)),
                        child: Container(
                          // decoration: BoxDecoration(border: Border.all()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: lang == "en"
                                    ? Alignment.bottomLeft
                                    : Alignment.bottomRight,
                                children: [
                                  Stack(
                                    alignment: lang == "en"
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    children: [
                                      Container(
                                        width: getHeight(context, 20),
                                        height: getHeight(context, 20),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF2F2F2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: product.coverImg!,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            width: getHeight(context, 18),
                                            height: getHeight(context, 18),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (!isLogin) {
                                              loginFirstModal(context);
                                              return;
                                            }
                                            final cartItem =
                                                CartItem(product: product.id!);
                                            cartProvider.addFavToCart(cartItem);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: isFavInCart
                                                    ? mainColorRed
                                                        .withOpacity(0.1)
                                                    : mainColorGrey
                                                        .withOpacity(0.2)),
                                            child: isFavInCart
                                                ? Icon(
                                                    FontAwesomeIcons
                                                        .heartCircleCheck,
                                                    color: mainColorRed,
                                                    size:
                                                        getHeight(context, 2.5))
                                                : Icon(
                                                    FontAwesomeIcons
                                                        .heartCirclePlus,
                                                    color: mainColorWhite,
                                                    size: getHeight(
                                                        context, 2.5)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  product.offerPrice! > 0
                                      ? Container(
                                          width: getHeight(context, 8),
                                          height: getHeight(context, 3),
                                          decoration: BoxDecoration(
                                            borderRadius: lang == "en"
                                                ? BorderRadius.only(
                                                    //  topLeft: Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                    // bottomLeft: Radius.circular(0.0),
                                                    bottomRight:
                                                        Radius.circular(20.0),
                                                  )
                                                : BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                  ),
                                            color: mainColorRed,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                calculatePercentageDiscount(
                                                    double.parse(product.price!
                                                        .toString()),
                                                    double.parse(product
                                                        .offerPrice!
                                                        .toString())),
                                                style: TextStyle(
                                                    color: mainColorWhite,
                                                    fontFamily: Speda,
                                                    fontSize: 12),
                                              ),
                                              Icon(Icons.discount_rounded,
                                                  color: mainColorWhite,
                                                  size: 12),
                                            ],
                                          ))
                                      : SizedBox(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: getWidth(context, 32),
                                    height: getHeight(context, 13),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang == "en"
                                              ? product.nameEn.toString()
                                              : lang == "ar"
                                                  ? product.nameAr.toString()
                                                  : product.nameKu.toString(),
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontFamily: spedaBold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          lang == "en"
                                              ? product.contentsEn.toString()
                                              : lang == "ar"
                                                  ? product.contentsAr
                                                      .toString()
                                                  : product.contentsKu
                                                      .toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: mainColorGrey
                                                  .withOpacity(0.5),
                                              fontFamily: spedaBold,
                                              fontSize: 9),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          product.price!.toString() + " IQD",
                                          style: TextStyle(
                                              decoration: product.offerPrice! >
                                                      0
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: mainColorGrey,
                                              fontFamily: Speda,
                                              fontSize: 11),
                                        ),
                                        product.offerPrice! > 0
                                            ? Text(
                                                product.offerPrice!.toString() +
                                                    " IQD",
                                                style: TextStyle(
                                                    color: mainColorRed,
                                                    fontFamily: spedaBold,
                                                    fontSize: 11),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (!isLogin) {
                                          loginFirstModal(context);
                                          return;
                                        }
                                        final cartItem =
                                            CartItem(product: product.id!);
                                        cartProvider.addToCart(cartItem);
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                          width: getWidth(context, 10),
                                          height: getHeight(context, 4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: mainColorGrey
                                                      .withOpacity(0.5)),
                                              color: mainColorGrey),
                                          child: isItemInCart
                                              ? Center(
                                                  child: Text(
                                                    cartProvider
                                                        .calculateQuantityForProduct(
                                                            int.parse(product.id
                                                                .toString()))
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: mainColorWhite),
                                                  ),
                                                )
                                              : Icon(
                                                  FontAwesomeIcons.cartShopping,
                                                  color: mainColorWhite,
                                                  size: getHeight(context, 2))),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: buildFAB(context),
      ),
    );
  }
}
