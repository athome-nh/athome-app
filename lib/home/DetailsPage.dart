import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/my_cart.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/cart.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:dllylas/model/products_image/products_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailsPage extends StatelessWidget {
  int color = 0;
  DetailsPage({Key? key, required this.color}) : super(key: key);

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
        appBar: AppBar(
          backgroundColor: categoryColors[color],
          title: productrovider.show
              ? Text(
                  lang == "en"
                      ? Item.nameEn!
                      : lang == "ar"
                          ? Item.nameAr!
                          : Item.nameKu!,
                )
              : Text(""),

          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCart(true)),
                  );
                },
                icon: cartProvider.cartItems.isNotEmpty
                    ? Badge(
                        label: Text(
                          cartProvider.cartItems.length.toString(),
                        ),
                        backgroundColor: mainColorRed,
                        child: Icon(
                          size: 30,
                          LineIcons.shoppingCart,
                          color: mainColorGrey,
                        ),
                      )
                    : Icon(
                        size: 30,
                        LineIcons.shoppingCart,
                        color: mainColorGrey,
                      ),
              ),
            )
          ],

          // Change the color of the unselected tab labels
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: productrovider.show,
                  replacement: Skeletonizer(
                    effect: ShimmerEffect.raw(colors: [
                      mainColorGrey.withOpacity(0.1),
                      mainColorWhite,
                      // mainColorRed.withOpacity(0.1),
                    ]),
                    child: Column(
                      children: [
                        Stack(
                          alignment: lang == "en"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          children: [
                            Skeleton.leaf(
                              child: Container(
                                height: getHeight(context, 35),
                                width: getWidth(context, 100),
                                decoration: BoxDecoration(
                                  color: categoryColors[color],
                                  boxShadow: [
                                    BoxShadow(
                                      color: categoryColors[color]
                                          .withOpacity(0.2),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(60),
                                    bottomRight: Radius.circular(60),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: getWidth(context, 10),
                                  height: getWidth(context, 12),
                                  decoration: BoxDecoration(
                                    color: mainColorGrey,
                                    borderRadius: lang == "en"
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            bottomLeft: Radius.circular(100),
                                          )
                                        : const BorderRadius.only(
                                            //  topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(100),
                                            // bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(100),
                                          ),
                                  ),
                                  child: Skeleton.keep(
                                    child: Icon(FontAwesomeIcons.solidHeart,
                                        color: mainColorWhite,
                                        size: getHeight(context, 2.5)),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Hello good bad ",
                                          style: TextStyle(
                                            color:
                                                mainColorBlack.withOpacity(0.8),
                                            fontFamily: mainFontbold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "500 ml",
                                          style: TextStyle(
                                            color:
                                                mainColorBlack.withOpacity(0.5),
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: getHeight(context, 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Chip(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            backgroundColor: mainColorGrey,
                                            label: Text(
                                              "Add to cart".tr,
                                              style: TextStyle(
                                                  color: mainColorWhite),
                                            ),
                                            avatar: Skeleton.keep(
                                              child: Icon(
                                                  LineIcons.shoppingCart,
                                                  color: mainColorGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: addCommasToPrice(1500),
                                      style: TextStyle(
                                        color: mainColorBlack.withOpacity(0.8),
                                        fontFamily: mainFontbold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              RichText(
                                text: TextSpan(
                                  text:
                                      """As the  , skeletonizer will reduce your already existing layouts into mere skeletons and apply painting effects on them, typically a shimmer """,
                                  style: TextStyle(
                                    color: mainColorBlack.withOpacity(0.5),
                                    fontSize: 15.0,
                                    height: 1.4,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                "Similar item",
                                style: TextStyle(
                                  color: mainColorBlack.withOpacity(0.9),
                                  fontSize: 18.0,
                                  height: 1.4,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: lang == "en"
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        children: [
                          Container(
                            height: getHeight(context, 35),
                            width: getWidth(context, 100),
                            decoration: BoxDecoration(
                              color: categoryColors[color],
                              boxShadow: [
                                BoxShadow(
                                  color: categoryColors[color].withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(60),
                                bottomRight: Radius.circular(60),
                              ),
                            ),
                            child: Hero(
                              tag: Item.coverImg!,
                              child: CachedNetworkImage(
                                imageUrl: dotenv.env['imageUrlServer']! +
                                    Item.coverImg!,
                                // dotenv.env['imageUrlServer']! + Item.coverImg!,
                                placeholder: (context, url) => Image.asset(
                                    "assets/images/Logo-Type-2.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        "assets/images/Logo-Type-2.png"),
                              ),
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
                              child: Container(
                                width: getWidth(context, 10),
                                height: getWidth(context, 12),
                                decoration: BoxDecoration(
                                  color: mainColorGrey,
                                  borderRadius: lang == "en"
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          bottomLeft: Radius.circular(100),
                                        )
                                      : const BorderRadius.only(
                                          //  topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(100),
                                          // bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(100),
                                        ),
                                ),
                                child: isFavInCart
                                    ? Icon(FontAwesomeIcons.solidHeart,
                                        color: mainColorRed,
                                        size: getHeight(context, 2.5))
                                    : Icon(FontAwesomeIcons.solidHeart,
                                        color: mainColorWhite,
                                        size: getHeight(context, 2.5)),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: lang == "en"
                                            ? Item.nameEn!
                                            : lang == "ar"
                                                ? Item.nameAr!
                                                : Item.nameKu!,
                                        style: TextStyle(
                                          color:
                                              mainColorBlack.withOpacity(0.8),
                                          fontFamily: mainFontbold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '  (${lang == "en" ? Item.contentsEn! : lang == "ar" ? Item.contentsAr! : Item.contentsKu!})',
                                        style: TextStyle(
                                          color:
                                              mainColorBlack.withOpacity(0.5),
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: getHeight(context, 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      isItemInCart
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: checkProductStock(
                                                          Item, count) ||
                                                      checkProductLimit(
                                                          Item, count)
                                                  ? null
                                                  : () {
                                                      if (!isLogin) {
                                                        loiginPopup(context);
                                                        return;
                                                      }
                                                      final cartItem = CartItem(
                                                          product: Item.id!);
                                                      cartProvider
                                                          .addToCart(cartItem);
                                                    },
                                              child: Chip(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                backgroundColor: mainColorGrey,
                                                label: Text(
                                                  "Add to cart".tr,
                                                  style: TextStyle(
                                                      color: mainColorWhite),
                                                ),
                                                avatar: Icon(
                                                    LineIcons.shoppingCart,
                                                    color: mainColorWhite),
                                              ),
                                            ),
                                      isItemInCart
                                          ? Container(
                                              width: getWidth(context, 32),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        getHeight(context, 4),
                                                    height:
                                                        getHeight(context, 4),
                                                    decoration: BoxDecoration(
                                                        color: mainColorRed,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        if (!isLogin) {
                                                          loiginPopup(context);
                                                          return;
                                                        }
                                                        final cartItem =
                                                            CartItem(
                                                                product:
                                                                    Item.id!);
                                                        cartProvider
                                                            .removeFromCart(
                                                                cartItem);
                                                      },
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color: mainColorWhite,
                                                        size: getHeight(
                                                            context, 2),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    count.toString().length == 1
                                                        ? "0" + count.toString()
                                                        : count.toString(),
                                                    style: TextStyle(
                                                        color: mainColorGrey,
                                                        fontFamily:
                                                            mainFontnormal,
                                                        fontSize: 20),
                                                  ),
                                                  Container(
                                                    width:
                                                        getHeight(context, 4),
                                                    height:
                                                        getHeight(context, 4),
                                                    decoration: BoxDecoration(
                                                        color: mainColorGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        if (!isLogin) {
                                                          loiginPopup(context);
                                                          return;
                                                        }
                                                        final cartItem =
                                                            CartItem(
                                                                product:
                                                                    Item.id!);
                                                        cartProvider.addToCart(
                                                            cartItem);
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: mainColorWhite,
                                                        size: getHeight(
                                                            context, 2),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: checkOferPrice(Item)
                                        ? addCommasToPrice(Item.offerPrice!)
                                        : addCommasToPrice(Item.price2! > -1
                                            ? Item.price2!
                                            : Item.price!),
                                    style: TextStyle(
                                      color: mainColorBlack.withOpacity(0.8),
                                      fontFamily: mainFontbold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  checkOferPrice(Item)
                                      ? TextSpan(
                                          text: "/" +
                                              addCommasToPrice(Item.price2! > -1
                                                  ? Item.price2!
                                                  : Item.price!),
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: mainColorRed,
                                            fontSize: 14.0,
                                          ),
                                        )
                                      : TextSpan(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            RichText(
                              text: TextSpan(
                                text: lang == "en"
                                    ? Item.descriptionEn!
                                    : lang == "ar"
                                        ? Item.descriptionAr!
                                        : Item.descriptionKu!,
                                style: TextStyle(
                                  color: mainColorBlack.withOpacity(0.5),
                                  fontSize: 15.0,
                                  height: 1.4,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              "Similar item".tr,
                              style: TextStyle(
                                color: mainColorBlack.withOpacity(0.9),
                                fontSize: 18.0,
                                height: 1.4,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                listItemsSmall(
                    context,
                    productrovider.getProductsBySubCategory2(
                        Item.subCategoryId!, Item.id!)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
