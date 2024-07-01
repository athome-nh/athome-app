import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/landing/login_page.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../home/oneitem.dart';

Widget listItemsShimer(BuildContext context) {
  return SizedBox(
    height: getHeight(context, 27),
    // decoration: BoxDecoration(border: Border.all()),
    child: Skeletonizer(
      effect: ShimmerEffect.raw(colors: [
        mainColorGrey.withOpacity(0.1),
        mainColorWhite,
        // mainColorRed.withOpacity(0.1),
      ]),
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 1.5)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 1.5)),
              child: Container(
                width: getWidth(context, 45),
                height: getHeight(context, 27),
                decoration: BoxDecoration(
                    border: Border.all(color: mainColorBlack.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(15)),
                child: Stack(
                  alignment:
                      lang == "en" ? Alignment.topLeft : Alignment.topRight,
                  children: [
                    Stack(
                      alignment: lang == "en"
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // rectangle
                                  Image.asset(
                                    "assets/images/home.png",
                                    width: getWidth(context, 30),
                                    height: getWidth(context, 30),
                                  ),
                                  // space
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "I dont know",
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontFamily: mainFontbold,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "900 ml",
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: mainColorGrey.withOpacity(0.5),
                                        fontFamily: mainFontbold,
                                        fontSize: 11),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "900000",
                                        maxLines: 1,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.green,
                                            fontFamily: mainFontbold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Skeleton.keep(
                                child: GestureDetector(
                                  onTap: () {
                                    if (!isLogin) {
                                      loiginPopup(context);
                                      return;
                                    }
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Icon(LineIcons.heart,
                                          color: mainColorGrey,
                                          size: getHeight(context, 3.5))),
                                ),
                              ),
                              // isItemInCart
                              //     ? // button
                              Skeleton.keep(
                                  child: AnimatedContainer(
                                padding: EdgeInsets.all(4),
                                width: 35,
                                height: 35,
                                duration: Duration(milliseconds: 600),
                                decoration: BoxDecoration(
                                    color: mainColorGrey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: mainColorGrey.withOpacity(0.2))),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(LineIcons.plus,
                                      color: mainColorBlack,
                                      size: getHeight(context, 2)),
                                ),
                              ))
                            ],
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
    ),
  );
}

Widget listItemsBigShimer(BuildContext context) {
  return SizedBox(
    height: getHeight(context, 80),
    //   decoration: BoxDecoration(border: Border.all()),
    child: Skeletonizer(
      effect: ShimmerEffect.raw(colors: [
        mainColorGrey.withOpacity(0.1),
        mainColorWhite,
        //mainColorRed.withOpacity(0.1),
      ]),
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 2.5)),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            childAspectRatio: getWidth(context, 0.19),
          ),

          itemCount: 8, // Number of items in the grid
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 1.5)),
              child: Container(
                width: getWidth(context, 45),
                height: getHeight(context, 27),
                decoration: BoxDecoration(
                    border: Border.all(color: mainColorBlack.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(15)),
                child: Stack(
                  alignment:
                      lang == "en" ? Alignment.topLeft : Alignment.topRight,
                  children: [
                    Stack(
                      alignment: lang == "en"
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Image.asset(
                                    "assets/images/home.png",
                                    width: getWidth(context, 30),
                                    height: getWidth(context, 30),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "slaw chonn bashn",
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontFamily: mainFontbold,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "900 ml",
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: mainColorGrey.withOpacity(0.5),
                                        fontFamily: mainFontbold,
                                        fontSize: 11),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "900000",
                                        maxLines: 1,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.green,
                                            fontFamily: mainFontbold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getHeight(context, 3),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Skeleton.keep(
                                child: GestureDetector(
                                  onTap: () {
                                    if (!isLogin) {
                                      loiginPopup(context);
                                      return;
                                    }
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Icon(LineIcons.heart,
                                          color: mainColorGrey,
                                          size: getHeight(context, 3.5))),
                                ),
                              ),
                              // isItemInCart
                              //     ? // button
                              Skeleton.keep(
                                  child: AnimatedContainer(
                                padding: EdgeInsets.all(4),
                                width: 35,
                                height: 35,
                                duration: Duration(milliseconds: 600),
                                decoration: BoxDecoration(
                                    color: mainColorGrey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: mainColorGrey.withOpacity(0.2))),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(LineIcons.plus,
                                      color: mainColorBlack,
                                      size: getHeight(context, 2)),
                                ),
                              ))
                            ],
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
    ),
  );
}

// Home items
Widget listItemsSmall(BuildContext context, var data) {
  final productrovider = Provider.of<productProvider>(context, listen: true);
  final cartProvider = Provider.of<CartProvider>(context, listen: true);
  return SizedBox(
    height: getHeight(context, 30),
    //  decoration: BoxDecoration(border: Border.all()),
    child: Visibility(
      visible: productrovider.show,
      replacement: listItemsShimer(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 2.5)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            final product = data[index];
            final isItemInCart = cartProvider.itemExistsInCart(product);
            final isFavInCart = cartProvider.FavExistsInCart(product);
            int count = cartProvider
                .calculateQuantityForProduct(int.parse(product.id.toString()));
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 1.5)),
              child: Container(
                width: getWidth(context, 45),
                height: getWidth(context, 28),
                decoration: BoxDecoration(
                    border: Border.all(color: mainColorBlack.withOpacity(0.1)),
                    // color: mainColorLightGrey,
                    borderRadius: BorderRadius.circular(15)),
                child: Stack(
                  alignment:
                      lang == "en" ? Alignment.topLeft : Alignment.topRight,
                  children: [
                    Stack(
                      alignment: lang == "en"
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      children: [
                        Center(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      productrovider.setidItem(product.id!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Oneitem()),
                                      );
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: dotenv.env['imageUrlServer']! +
                                          product.coverImg,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              "assets/images/Logo-Type-2.png"),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/Logo-Type-2.png"),
                                      filterQuality: FilterQuality.low,
                                      width: getWidth(context, 30),
                                      height: getWidth(context, 30),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    lang == "en"
                                        ? product.nameEn.toString()
                                        : lang == "ar"
                                            ? product.nameAr.toString()
                                            : product.nameKu.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: mainColorBlack,
                                        fontFamily: mainFontnormal,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    lang == "en"
                                        ? product.contentsEn.toString()
                                        : lang == "ar"
                                            ? product.contentsAr.toString()
                                            : product.contentsKu.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: mainColorGrey.withOpacity(0.5),
                                        fontFamily: mainFontbold,
                                        fontSize: 11),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        addCommasToPrice(product.price2! > -1
                                            ? product.price2!
                                            : product.price!),
                                        maxLines: 1,
                                        style: TextStyle(
                                            decoration: checkOferPrice(product)
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            color: checkOferPrice(product)
                                                ? mainColorRed
                                                : Colors.green,
                                            fontFamily: checkOferPrice(product)
                                                ? mainFontnormal
                                                : mainFontbold,
                                            fontSize: 14),
                                      ),
                                      checkOferPrice(product)
                                          ? const Text("/")
                                          : const SizedBox(),
                                      checkOferPrice(product)
                                          ? Text(
                                              addCommasToPrice(
                                                  product.offerPrice!),
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontFamily: mainFontbold,
                                                  fontSize: 14),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (!isLogin) {
                                  loiginPopup(context);
                                  return;
                                }
                                final cartItem = CartItem(product: product.id!);
                                cartProvider.addFavToCart(cartItem);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: isFavInCart
                                    ? Icon(LineIcons.heartAlt,
                                        color: mainColorRed,
                                        size: getHeight(context, 3.5))
                                    : Icon(LineIcons.heart,
                                        color: mainColorBlack,
                                        size: getHeight(context, 3.5)),
                              ),
                            ),
                            // isItemInCart
                            //     ? // button
                            Padding(
                              padding: EdgeInsets.all(6),
                              child: AnimatedContainer(
                                padding: EdgeInsets.all(4),
                                width: isItemInCart ? 110 : 30,
                                height: isItemInCart ? 30 : 30,
                                duration: Duration(milliseconds: 600),
                                decoration: BoxDecoration(
                                    color: mainColorGrey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: mainColorGrey.withOpacity(0.2))),
                                child: isItemInCart
                                    ? FlipInX(
                                        delay:
                                            const Duration(milliseconds: 300),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                final cartItem = CartItem(
                                                    product: product.id!);
                                                cartProvider
                                                    .removeFromCart(cartItem);
                                              },
                                              child: Icon(Icons.remove,
                                                  color: mainColorBlack,
                                                  size:
                                                      getHeight(context, 2.5)),
                                            ),
                                            Text(
                                              count.toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: mainColorBlack,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: checkProductStock(
                                                          product, count) ||
                                                      checkProductLimit(
                                                          product, count)
                                                  ? null
                                                  : () {
                                                      final cartItem = CartItem(
                                                          product: product.id!);
                                                      cartProvider
                                                          .addToCart(cartItem);
                                                    },
                                              child: Icon(LineIcons.plus,
                                                  color: checkProductStock(
                                                              product, count) ||
                                                          checkProductLimit(
                                                              product, count)
                                                      ? mainColorGrey
                                                          .withOpacity(0.5)
                                                      : mainColorBlack,
                                                  size:
                                                      getHeight(context, 2.5)),
                                            ),
                                          ],
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          if (!isLogin) {
                                            loiginPopup(context);
                                            return;
                                          }
                                          final cartItem =
                                              CartItem(product: product.id!);
                                          cartProvider.addToCart(cartItem);
                                        },
                                        child: Icon(LineIcons.plus,
                                            color: mainColorBlack,
                                            size: getHeight(context, 2)),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    checkOferPrice(product)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                                width: getWidth(context, 10),
                                height: getWidth(context, 6),
                                decoration: BoxDecoration(
                                  borderRadius: lang == "en"
                                      ? const BorderRadius.only(
                                          //  topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(5.0),
                                          // bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(5.0),
                                        )
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(5.0),
                                          bottomLeft: Radius.circular(5.0),
                                        ),
                                  color: mainColorRed,
                                ),
                                child: Center(
                                  child: Text(
                                    calculatePercentageDiscount(
                                        double.parse(product.price2 > -1
                                            ? product.price2!.toString()
                                            : product.price!.toString()),
                                        double.parse(
                                            product.offerPrice!.toString())),
                                    style: TextStyle(
                                        color: mainColorWhite,
                                        fontFamily: mainFontnormal,
                                        fontSize: 12),
                                  ),
                                )),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

// all items
Widget listItemsShow(BuildContext context, var data) {
  final productrovider = Provider.of<productProvider>(context, listen: true);
  final cartProvider = Provider.of<CartProvider>(context, listen: true);
  return Visibility(
    visible: productrovider.show,
    replacement: listItemsBigShimer(context),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 2.5)),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          childAspectRatio: getWidth(context, 0.19),
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final product = data[index];
          final isItemInCart = cartProvider.itemExistsInCart(product);
          final isFavInCart = cartProvider.FavExistsInCart(product);
          int count = cartProvider
              .calculateQuantityForProduct(int.parse(product.id.toString()));
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 1.5)),
            child: Container(
              width: getWidth(context, 45),
              height: getHeight(context, 27),
              decoration: BoxDecoration(
                  border: Border.all(color: mainColorBlack.withOpacity(0.1)),
                  // color: mainColorLightGrey,
                  borderRadius: BorderRadius.circular(15)),
              child: Stack(
                alignment:
                    lang == "en" ? Alignment.topLeft : Alignment.topRight,
                children: [
                  Stack(
                    alignment: lang == "en"
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    productrovider.setidItem(product.id!);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Oneitem()),
                                    );
                                  },
                                  child: Hero(
                                    tag: product.coverImg,
                                    child: CachedNetworkImage(
                                      imageUrl: dotenv.env['imageUrlServer']! +
                                          product.coverImg,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              "assets/images/Logo-Type-2.png"),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/Logo-Type-2.png"),
                                      filterQuality: FilterQuality.low,
                                      width: getWidth(context, 30),
                                      height: getWidth(context, 30),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  lang == "en"
                                      ? product.nameEn.toString()
                                      : lang == "ar"
                                          ? product.nameAr.toString()
                                          : product.nameKu.toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  lang == "en"
                                      ? product.contentsEn.toString()
                                      : lang == "ar"
                                          ? product.contentsAr.toString()
                                          : product.contentsKu.toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: mainColorGrey.withOpacity(0.5),
                                      fontFamily: mainFontbold,
                                      fontSize: 11),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      addCommasToPrice(product.price2! > -1
                                          ? product.price2!
                                          : product.price!),
                                      maxLines: 1,
                                      style: TextStyle(
                                          decoration: checkOferPrice(product)
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          color: checkOferPrice(product)
                                              ? mainColorRed
                                              : Colors.green,
                                          fontFamily: checkOferPrice(product)
                                              ? mainFontnormal
                                              : mainFontbold,
                                          fontSize: 14),
                                    ),
                                    checkOferPrice(product)
                                        ? const Text("/")
                                        : const SizedBox(),
                                    checkOferPrice(product)
                                        ? Text(
                                            addCommasToPrice(
                                                product.offerPrice!),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: mainFontbold,
                                                fontSize: 14),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!isLogin) {
                                loiginPopup(context);
                                return;
                              }
                              final cartItem = CartItem(product: product.id!);
                              cartProvider.addFavToCart(cartItem);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: isFavInCart
                                  ? Icon(LineIcons.heartAlt,
                                      color: mainColorRed,
                                      size: getHeight(context, 3.5))
                                  : Icon(LineIcons.heart,
                                      color: mainColorBlack,
                                      size: getHeight(context, 3.5)),
                            ),
                          ),
                          // isItemInCart
                          //     ? // button

                          Padding(
                            padding: EdgeInsets.all(4),
                            child: AnimatedContainer(
                              padding: EdgeInsets.all(4),
                              width: isItemInCart ? 110 : 30,
                              height: isItemInCart ? 30 : 30,
                              duration: Duration(milliseconds: 600),
                              decoration: BoxDecoration(
                                  color: mainColorGrey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: mainColorGrey.withOpacity(0.2))),
                              child: isItemInCart
                                  ? FlipInX(
                                      delay: const Duration(milliseconds: 300),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              final cartItem = CartItem(
                                                  product: product.id!);
                                              cartProvider
                                                  .removeFromCart(cartItem);
                                            },
                                            child: Icon(Icons.remove,
                                                color: mainColorBlack,
                                                size: getHeight(context, 2.5)),
                                          ),
                                          Text(
                                            count.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: mainColorBlack,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: checkProductStock(
                                                        product, count) ||
                                                    checkProductLimit(
                                                        product, count)
                                                ? null
                                                : () {
                                                    final cartItem = CartItem(
                                                        product: product.id!);
                                                    cartProvider
                                                        .addToCart(cartItem);
                                                  },
                                            child: Icon(LineIcons.plus,
                                                color: checkProductStock(
                                                            product, count) ||
                                                        checkProductLimit(
                                                            product, count)
                                                    ? mainColorGrey
                                                        .withOpacity(0.5)
                                                    : mainColorBlack,
                                                size: getHeight(context, 2.5)),
                                          ),
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        if (!isLogin) {
                                          loiginPopup(context);
                                          return;
                                        }
                                        final cartItem =
                                            CartItem(product: product.id!);
                                        cartProvider.addToCart(cartItem);
                                      },
                                      child: Icon(LineIcons.plus,
                                          color: mainColorBlack,
                                          size: getHeight(context, 2)),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  checkOferPrice(product)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                              width: getWidth(context, 10),
                              height: getWidth(context, 6),
                              decoration: BoxDecoration(
                                borderRadius: lang == "en"
                                    ? const BorderRadius.only(
                                        //  topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(5.0),
                                        // bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(5.0),
                                      )
                                    : const BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        bottomLeft: Radius.circular(5.0),
                                      ),
                                color: mainColorRed,
                              ),
                              child: Center(
                                child: Text(
                                  calculatePercentageDiscount(
                                      double.parse(product.price2 > -1
                                          ? product.price2!.toString()
                                          : product.price!.toString()),
                                      double.parse(
                                          product.offerPrice!.toString())),
                                  style: TextStyle(
                                      color: mainColorWhite,
                                      fontFamily: mainFontnormal,
                                      fontSize: 12),
                                ),
                              )),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

// Search items
Widget listItemsShowSearch(BuildContext context, var data) {
  final productrovider = Provider.of<productProvider>(context, listen: true);
  final cartProvider = Provider.of<CartProvider>(context, listen: true);
  return Visibility(
    visible: productrovider.show,
    replacement: listItemsBigShimer(context),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 2.5)),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          childAspectRatio: getWidth(context, 0.20),
        ),

        itemCount: data.length, // Number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          final product = data[index];
          final isItemInCart = cartProvider.itemExistsInCart(product);
          final isFavInCart = cartProvider.FavExistsInCart(product);
          int count = cartProvider
              .calculateQuantityForProduct(int.parse(product.id.toString()));
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 1.5)),
            child: Container(
              width: getWidth(context, 45),
              height: getHeight(context, 27),
              decoration: BoxDecoration(
                  border: Border.all(color: mainColorBlack.withOpacity(0.1)),
                  //  color: mainColorBlack,
                  borderRadius: BorderRadius.circular(15)),
              child: Stack(
                alignment:
                    lang == "en" ? Alignment.topLeft : Alignment.topRight,
                children: [
                  Stack(
                    alignment: lang == "en"
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    productrovider.setidItem(product.id!);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Oneitem()),
                                    );
                                  },
                                  child: Hero(
                                    tag: product.coverImg,
                                    child: CachedNetworkImage(
                                      imageUrl: dotenv.env['imageUrlServer']! +
                                          product.coverImg,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              "assets/images/Logo-Type-2.png"),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/Logo-Type-2.png"),
                                      filterQuality: FilterQuality.low,
                                      width: getWidth(context, 30),
                                      height: getWidth(context, 30),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  lang == "en"
                                      ? product.nameEn.toString()
                                      : lang == "ar"
                                          ? product.nameAr.toString()
                                          : product.nameKu.toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  lang == "en"
                                      ? product.contentsEn.toString()
                                      : lang == "ar"
                                          ? product.contentsAr.toString()
                                          : product.contentsKu.toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: mainColorGrey.withOpacity(0.5),
                                      fontFamily: mainFontbold,
                                      fontSize: 11),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      addCommasToPrice(product.price2! > -1
                                          ? product.price2!
                                          : product.price!),
                                      maxLines: 1,
                                      style: TextStyle(
                                          decoration: checkOferPrice(product)
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          color: checkOferPrice(product)
                                              ? mainColorRed
                                              : Colors.green,
                                          fontFamily: checkOferPrice(product)
                                              ? mainFontnormal
                                              : mainFontbold,
                                          fontSize: 14),
                                    ),
                                    checkOferPrice(product)
                                        ? const Text("/")
                                        : const SizedBox(),
                                    checkOferPrice(product)
                                        ? Text(
                                            addCommasToPrice(
                                                product.offerPrice!),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: mainFontbold,
                                                fontSize: 14),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!isLogin) {
                                loiginPopup(context);
                                return;
                              }
                              final cartItem = CartItem(product: product.id!);
                              cartProvider.addFavToCart(cartItem);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: isFavInCart
                                  ? Icon(LineIcons.heartAlt,
                                      color: mainColorRed,
                                      size: getHeight(context, 3.5))
                                  : Icon(LineIcons.heart,
                                      color: mainColorBlack,
                                      size: getHeight(context, 3.5)),
                            ),
                          ),
                          // isItemInCart
                          //     ? // button
                          Padding(
                            padding: EdgeInsets.all(6),
                            child: AnimatedContainer(
                              padding: EdgeInsets.all(4),
                              width: isItemInCart ? 110 : 30,
                              height: isItemInCart ? 30 : 30,
                              duration: Duration(milliseconds: 600),
                              decoration: BoxDecoration(
                                  color: mainColorGrey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: mainColorGrey.withOpacity(0.2))),
                              child: isItemInCart
                                  ? FlipInX(
                                      delay: const Duration(milliseconds: 300),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              final cartItem = CartItem(
                                                  product: product.id!);
                                              cartProvider
                                                  .removeFromCart(cartItem);
                                            },
                                            child: Icon(Icons.remove,
                                                color: mainColorBlack,
                                                size: getHeight(context, 2.5)),
                                          ),
                                          Text(
                                            count.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: mainColorBlack,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: checkProductStock(
                                                        product, count) ||
                                                    checkProductLimit(
                                                        product, count)
                                                ? null
                                                : () {
                                                    final cartItem = CartItem(
                                                        product: product.id!);
                                                    cartProvider
                                                        .addToCart(cartItem);
                                                  },
                                            child: Icon(LineIcons.plus,
                                                color: checkProductStock(
                                                            product, count) ||
                                                        checkProductLimit(
                                                            product, count)
                                                    ? mainColorGrey
                                                        .withOpacity(0.5)
                                                    : mainColorBlack,
                                                size: getHeight(context, 2.5)),
                                          ),
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        if (!isLogin) {
                                          loiginPopup(context);
                                          return;
                                        }
                                        final cartItem =
                                            CartItem(product: product.id!);
                                        cartProvider.addToCart(cartItem);
                                      },
                                      child: Icon(LineIcons.plus,
                                          color: mainColorBlack,
                                          size: getHeight(context, 2)),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  checkOferPrice(product)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                              width: getWidth(context, 10),
                              height: getWidth(context, 6),
                              decoration: BoxDecoration(
                                borderRadius: lang == "en"
                                    ? const BorderRadius.only(
                                        //  topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(5.0),
                                        // bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(5.0),
                                      )
                                    : const BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        bottomLeft: Radius.circular(5.0),
                                      ),
                                color: mainColorRed,
                              ),
                              child: Center(
                                child: Text(
                                  calculatePercentageDiscount(
                                      double.parse(product.price2 > -1
                                          ? product.price2!.toString()
                                          : product.price!.toString()),
                                      double.parse(
                                          product.offerPrice!.toString())),
                                  style: TextStyle(
                                      color: mainColorWhite,
                                      fontFamily: mainFontnormal,
                                      fontSize: 12),
                                ),
                              )),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

// here we check for internet availability
Future<bool> checkInternet(BuildContext context) async {
  bool retrive = false;
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult[0] == ConnectivityResult.none) {
    retrive = true;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          child: Text(
            'No internet connection, check your connection'.tr,
            style: TextStyle(
              color: mainColorWhite,
              fontFamily: "RK",
            ),
          ),
        ),
        backgroundColor: mainColorGrey,
      ),
    );
  } else {
    retrive = false;
  }
  return retrive;
}

Future noInternet(BuildContext context) {
  return checkInternet(context);
}

// SnackBar No Internet
SnackBar noInternetSnackBar = SnackBar(
  duration: const Duration(seconds: 4),
  content: Text(
    'You are offline, connect to a network.'.tr,
    style: TextStyle(fontFamily: mainFontnormal),
  ),
  backgroundColor: mainColorGrey,
);

// SnackBar Internet Back
SnackBar internetBackSnackBar = SnackBar(
  duration: const Duration(seconds: 3),
  content: Text(
    "You are online".tr + " ✅",
    style: TextStyle(fontFamily: mainFontnormal),
  ),
  backgroundColor: Colors.green,
);

Future toastShort(
  String message,
) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColorRed.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 14.0);
}

Future toastLong(
  String message,
) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColorRed.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 14.0);
}

Widget waitingWiget(BuildContext context) {
  return SizedBox(
    height: getWidth(context, 40),
    child: Image.asset("assets/images/LogoLoading.gif"),
  );
}

Widget waitingWiget2(BuildContext context) {
  return SizedBox(
    height: getWidth(context, 40),
    child: Image.asset("assets/images/LogoLoading.gif"),
  );
}

// Dialogbox ( Register )
Future<void> loiginPopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Directionality(
          textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
          child: Stack(
            alignment: lang == "en" ? Alignment.topLeft : Alignment.topRight,
            children: [
              //textcheck
              SizedBox(
                width: getWidth(context, 70),
                height: getHeight(context, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/Victors/first.png",
                      width: getWidth(context, 40),
                      height: getWidth(context, 40),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Register First".tr,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        color: mainColorBlack,
                        fontFamily: mainFontbold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterWithPhoneNumber()),
                        );
                      },
                      style: TextButton.styleFrom(
                        fixedSize:
                            Size(getWidth(context, 70), getHeight(context, 5)),
                      ),
                      child: Text(
                        "Register".tr,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: mainColorRed,
                        fixedSize:
                            Size(getWidth(context, 70), getHeight(context, 5)),
                      ),
                      child: Text(
                        "Cancel".tr,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
        ),
      );
    },
  );
}

// Page --> No Internet
noInternetWidget(BuildContext context) {
  return Directionality(
    textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/Dlly Las Logo White.png",
          width: getWidth(context, 30),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: getWidth(context, 100),
            height: getWidth(context, 100),
            child: Image.asset("assets/Victors/wifi.png"),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            "no internet".tr,
            style: TextStyle(fontFamily: mainFontnormal, fontSize: 18),
          ),
        ],
      )),
    ),
  );
}

// Page --> Login First
loginFirstContainer(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/Victors/first.png",
        ),
        SizedBox(
          height: getWidth(context, 12),
          width: getWidth(context, 75),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterWithPhoneNumber()),
              );
            },
            style: TextButton.styleFrom(
              fixedSize: Size(getWidth(context, 70), getHeight(context, 5)),
            ),
            child: Text(
              "Register".tr,
              style: TextStyle(
                  color: mainColorWhite,
                  fontSize: 22,
                  fontFamily: mainFontnormal),
            ),
          ),
        )
      ],
    ),
  );
}
