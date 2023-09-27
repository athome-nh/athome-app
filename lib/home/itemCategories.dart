import 'package:athome/Switchscreen.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/NavSwitch.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:athome/Config/property.dart';
import 'package:provider/provider.dart';

class itemCategories extends StatefulWidget {
  itemCategories();

  @override
  State<itemCategories> createState() => _itemCategoriesState();
}

class _itemCategoriesState extends State<itemCategories> {
  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          productPro.cateType.toString(),
          style: TextStyle(
              color: mainColorGrey,
              fontFamily: mainFontMontserrat4,
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

        // Change the color of the unselected tab labels
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: getWidth(context, 95),
                  height: getHeight(context, 3),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        productPro.getsubcateById(productPro.cateType).length,
                    itemBuilder: (BuildContext context, int index) {
                      final cateItem =
                          productPro.getsubcateById(productPro.cateType)[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 2)),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: getHeight(context, 9),
                            height: getHeight(context, 2),
                            decoration: BoxDecoration(
                                color: mainColorRed,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                cateItem.name!,
                                style: TextStyle(
                                    color: mainColorWhite,
                                    fontFamily: mainFontMontserrat6,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                Container(
                  height: getHeight(context, 85),
                  width: getWidth(context, 95),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: getWidth(context, 0.5),
                      mainAxisSpacing: getHeight(context, 2),
                      childAspectRatio: getHeight(context, 0.085),
                    ),

                    itemCount: productPro
                        .getProductsByCategory(productPro.cateType)
                        .length, // Number of items in the grid
                    itemBuilder: (BuildContext context, int index) {
                      final product = productPro
                          .getProductsByCategory(productPro.cateType)[index];
                      final isItemInCart =
                          cartProvider.itemExistsInCart(product);
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 2)),
                        child: Container(
                          // decoration: BoxDecoration(border: Border.all()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
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
                                            imageUrl: product.imageUrl!,
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
                                              //loginFirstModal(context);
                                              return;
                                            }
                                            final cartItem =
                                                CartItem(product: product.id!);
                                            cartProvider.addToCart(cartItem);
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
                                                color: isItemInCart
                                                    ? mainColorRed
                                                        .withOpacity(0.1)
                                                    : mainColorGrey
                                                        .withOpacity(0.2)),
                                            child: isItemInCart
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
                                  product.discount!
                                      ? Container(
                                          width: getHeight(context, 8),
                                          height: getHeight(context, 3),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              //  topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                              // bottomLeft: Radius.circular(0.0),
                                              bottomRight:
                                                  Radius.circular(20.0),
                                            ),
                                            color: mainColorRed,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "30\%",
                                                style: TextStyle(
                                                    color: mainColorWhite,
                                                    fontFamily:
                                                        mainFontMontserrat4,
                                                    fontSize: 12),
                                              ),
                                              Icon(Icons.discount_rounded,
                                                  color: mainColorWhite,
                                                  size: 15),
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
                                    //   width: getHeight(context, 1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name!,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontFamily: mainFontMontserrat6,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          product.content.toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: mainColorGrey
                                                  .withOpacity(0.5),
                                              fontFamily: mainFontMontserrat6,
                                              fontSize: 9),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "200,000 IQD",
                                          style: TextStyle(
                                              decoration: product.discount!
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: mainColorGrey,
                                              fontFamily: mainFontMontserrat4,
                                              fontSize: 11),
                                        ),
                                        product.discount!
                                            ? Text(
                                                "100,500 IQD",
                                                style: TextStyle(
                                                    color: mainColorRed,
                                                    fontFamily:
                                                        mainFontMontserrat6,
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
                                          //   loginFirstModal(context);
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
      ),
      floatingActionButton: buildFAB(context),
    );
  }
}
