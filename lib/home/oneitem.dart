import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/value.dart';

import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/my_cart.dart';

import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:athome/model/products_image/products_image.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/my_widget.dart';
import '../Config/property.dart';
import '../main.dart';

class Oneitem extends StatefulWidget {
  const Oneitem({super.key});

  @override
  State<Oneitem> createState() => _OneitemState();
}

class _OneitemState extends State<Oneitem> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    ProductModel Item = productrovider.getoneProductById(productrovider.idItem);
    final isItemInCart = cartProvider.itemExistsInCart(Item);
    final isFavInCart = cartProvider.FavExistsInCart(Item);
    int count =
        cartProvider.calculateQuantityForProduct(int.parse(Item.id.toString()));
    List<ProductsImage> images =
        productrovider.getproductimages(productrovider.idItem);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            lang == "en"
                ? Item.nameEn!
                : lang == "ar"
                    ? Item.nameAr!
                    : Item.nameKu!,
          ),

          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              )),

          // Change the color of the unselected tab labels
        ),
        body: Column(
          children: [
            Expanded(
              flex: 12,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment:
                          lang == "en" ? Alignment.topRight : Alignment.topLeft,
                      children: [
                        Container(
                          width: getWidth(context, 100),
                          height: getHeight(context, 30),
                          decoration: BoxDecoration(
                              //    color: Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              images.isNotEmpty
                                  ? SizedBox(
                                      width: getWidth(context, 100),
                                      height: getHeight(context, 25),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: CarouselSlider(
                                          items: images.map((imageUrl) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return ClipRRect(
                                                  child: CachedNetworkImage(
                                                    imageUrl: imageUrlServer +
                                                        imageUrl.img!,
                                                    width:
                                                        getWidth(context, 100),
                                                    height:
                                                        getHeight(context, 25),
                                                  ),
                                                );
                                              },
                                            );
                                          }).toList(),
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            aspectRatio: 16 / 9,
                                            viewportFraction: 1.0,
                                            enlargeCenterPage: true,
                                            autoPlayInterval:
                                                const Duration(seconds: 2),
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                    milliseconds: 2000),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: getWidth(context, 100),
                                      height: getHeight(context, 25),
                                      decoration: BoxDecoration(
                                          //       color: Color(0xffF2F2F2),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              imageUrlServer + Item.coverImg!,
                                          // imageUrlServer + Item.coverImg!,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  "assets/images/Logo-Type-2.png"),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/Logo-Type-2.png"),
                                          width: getWidth(context, 100),
                                          height: getHeight(context, 20),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!isLogin) {
                              loiginPopup(context);

                              return;
                            }
                            final cartItem = CartItem(product: Item.id!);
                            cartProvider.addFavToCart(cartItem);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: isFavInCart
                                ? Icon(FontAwesomeIcons.solidHeart,
                                    color: mainColorRed,
                                    size: getHeight(context, 3))
                                : Icon(FontAwesomeIcons.heart,
                                    color: mainColorGrey,
                                    size: getHeight(context, 3)),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang == "en"
                                ? Item.nameEn!
                                : lang == "ar"
                                    ? Item.nameAr!
                                    : Item.nameKu!,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: mainColorBlack,
                                fontFamily: mainFontnormal,
                                fontSize: 24),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            lang == "en"
                                ? Item.contentsEn!
                                : lang == "ar"
                                    ? Item.contentsAr!
                                    : Item.contentsKu!,
                            style: TextStyle(
                                color: mainColorGrey.withOpacity(0.5),
                                fontFamily: mainFontnormal,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                addCommasToPrice(Item.price2! > -1
                                    ? Item.price2!
                                    : Item.price!),
                                maxLines: 1,
                                style: TextStyle(
                                    decoration: checkOferPrice(Item)
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: checkOferPrice(Item)
                                        ? mainColorRed
                                        : Colors.green,
                                    fontFamily: checkOferPrice(Item)
                                        ? mainFontnormal
                                        : mainFontbold,
                                    fontSize: 16),
                              ),
                              checkOferPrice(Item) ? Text("/") : SizedBox(),
                              checkOferPrice(Item)
                                  ? Text(
                                      addCommasToPrice(Item.offerPrice!),
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: mainFontbold,
                                          fontSize: 16),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 3)),
                      child: Text(
                        lang == "en"
                            ? Item.descriptionEn!
                            : lang == "ar"
                                ? Item.descriptionAr!
                                : Item.descriptionKu!,
                        style: TextStyle(
                            color: mainColorBlack,
                            fontFamily: mainFontnormal,
                            fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 4),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 3)),
                      child: Text(
                        "Similar item",
                        style: TextStyle(
                            color: mainColorBlack,
                            fontSize: 20,
                            fontFamily: mainFontbold),
                      ),
                    ),
                    listItemsSmall(
                        context,
                        productrovider.getProductsBySubCategory2(
                            Item.subCategoryId!, Item.id!)),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Row(
          children: [
            Container(
              width: getWidth(context, 100),
              height: getHeight(context, 8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: mainColorGrey),
                ),
                color: mainColorWhite,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
                child: Row(
                  mainAxisAlignment: isItemInCart
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    isItemInCart
                        ? const SizedBox()
                        : TextButton(
                            onPressed: checkProductStock(Item, count) ||
                                    checkProductLimit(Item, count)
                                ? null
                                : () {
                                    if (!isLogin) {
                                      loiginPopup(context);
                                      return;
                                    }
                                    final cartItem =
                                        CartItem(product: Item.id!);
                                    cartProvider.addToCart(cartItem);
                                  },
                            style: TextButton.styleFrom(
                              fixedSize: Size(
                                  getWidth(context, 40), getHeight(context, 4)),
                            ),
                            child: Text(
                              "Add To Cart".tr,
                            ),
                          ),
                    isItemInCart
                        ? TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyCart(true)),
                              );
                            },
                            style: TextButton.styleFrom(
                              fixedSize: Size(
                                  getWidth(context, 30), getHeight(context, 4)),
                            ),
                            child: Text(
                              "My Cart".tr,
                            ),
                          )
                        : const SizedBox(),
                    isItemInCart ? const Spacer() : const SizedBox(),
                    isItemInCart
                        ? Container(
                            width: getWidth(context, 30),
                            height: getHeight(context, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: mainColorWhite,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: checkProductStock(Item, count) ||
                                          checkProductLimit(Item, count)
                                      ? null
                                      : () {
                                          final cartItem =
                                              CartItem(product: Item.id!);
                                          cartProvider.addToCart(cartItem);
                                        },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: checkProductStock(
                                                        Item, count) ||
                                                    checkProductLimit(
                                                        Item, count)
                                                ? mainColorGrey.withOpacity(0.5)
                                                : Colors.green)),
                                    child: Icon(Icons.add,
                                        color: checkProductStock(Item, count) ||
                                                checkProductLimit(Item, count)
                                            ? mainColorGrey.withOpacity(0.5)
                                            : Colors.green,
                                        size: getHeight(context, 2.5)),
                                  ),
                                ),
                                Text(
                                  count.toString(),
                                  style: TextStyle(
                                      color: mainColorGrey,
                                      fontFamily: mainFontnormal,
                                      fontSize: 18),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final cartItem =
                                        CartItem(product: Item.id!);
                                    cartProvider.removeFromCart(cartItem);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: mainColorRed)),
                                    child: Icon(Icons.remove,
                                        color: mainColorRed,
                                        size: getHeight(context, 2.5)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
