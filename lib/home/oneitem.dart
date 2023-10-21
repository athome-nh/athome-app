import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/MyCart.dart';
import 'package:athome/landing/login_page.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:athome/model/products_image/products_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
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
              style: TextStyle(
                  color: mainColorGrey,
                  fontFamily: mainFontnormal,
                  fontSize: 22),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 2)),
                                child: images.length > 0
                                    ? Container(
                                        width: getWidth(context, 100),
                                        height: getHeight(context, 25),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: CarouselSlider(
                                            items: images.map((imageUrl) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return ClipRRect(
                                                    child: CachedNetworkImage(
                                                      imageUrl: imageUrl.img!,
                                                      width: getWidth(
                                                          context, 100),
                                                      height: getHeight(
                                                          context, 25),
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
                                                  Duration(seconds: 2),
                                              autoPlayAnimationDuration:
                                                  Duration(milliseconds: 2000),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: getWidth(context, 100),
                                        height: getHeight(context, 30),
                                        decoration: BoxDecoration(
                                            //       color: Color(0xffF2F2F2),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: Item.coverImg!,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            width: getWidth(context, 100),
                                            height: getHeight(context, 25),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                if (!isLogin) {
                                  PanaraInfoDialog.show(
                                    context,
                                    title: "Hello",
                                    message:
                                        "This is the Panara Info Dialog Success.",
                                    buttonText: "Login",
                                    onTapDismiss: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterWithPhoneNumber()),
                                      );
                                    },
                                    // color:
                                    //     PanaraColors
                                    //         .warning,
                                    panaraDialogType: PanaraDialogType.warning,
                                    // imagePath:
                                    //     "assets/images/logoB.png",
                                    noImage: false,
                                  );
                                  return;
                                }
                                final cartItem = CartItem(product: Item.id!);
                                cartProvider.addFavToCart(cartItem);
                              },
                              icon: isFavInCart
                                  ? Icon(
                                      Icons.favorite,
                                      color: mainColorRed,
                                      size: 30,
                                    )
                                  : Icon(
                                      Icons.favorite_border_outlined,
                                      color: mainColorGrey.withOpacity(0.5),
                                      size: 30,
                                    )),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: getWidth(context, 50),
                            child: Text(
                              lang == "en"
                                  ? Item.nameEn!
                                  : lang == "ar"
                                      ? Item.nameAr!
                                      : Item.nameKu!,
                              maxLines: 3,
                              style: TextStyle(
                                  color: mainColorGrey,
                                  fontFamily: mainFontbold,
                                  fontSize: 20),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "info: ".tr,
                                style: TextStyle(
                                    color: mainColorGrey.withOpacity(0.5),
                                    fontFamily: mainFontnormal,
                                    fontSize: 16),
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
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Price: ",
                            style: TextStyle(
                                color: mainColorRed,
                                fontFamily: mainFontbold,
                                fontSize: 16),
                          ),
                          Text(
                            Item.price!.toString() + " IQD",
                            style: TextStyle(
                                color: mainColorRed,
                                fontFamily: mainFontbold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(13),
                  child: Container(
                    width: getWidth(context, 100),
                    height: getHeight(context, 6),
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: isItemInCart
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          isItemInCart
                              ? SizedBox()
                              : TextButton(
                                  onPressed: () {
                                    final cartItem =
                                        CartItem(product: Item.id!);
                                    cartProvider.addToCart(cartItem);
                                  },
                                  child: Text("Add To Cart".tr,
                                      style: TextStyle(
                                        color: mainColorWhite,
                                        fontSize: 16,
                                        fontFamily: mainFontnormal,
                                      )),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 40),
                                        getHeight(context, 4)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                          color: mainColorRed, width: 1.0),
                                    ),
                                  ),
                                ),
                          isItemInCart
                              ? Container(
                                  width: getWidth(context, 30),
                                  height: getHeight(context, 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: mainColorWhite,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (Item.offerPrice! > -1 &&
                                              Item.orderLimit ==
                                                  cartProvider
                                                      .calculateQuantityForProduct(
                                                          int.parse(Item.id
                                                              .toString()))) {
                                            toastLong(
                                                "you can not add more this item");
                                            return;
                                          }
                                          if (Item.offerPrice! > -1 &&
                                              Item.orderLimit ==
                                                  cartProvider
                                                      .calculateQuantityForProduct(
                                                          int.parse(Item.id
                                                              .toString()))) {
                                            toastLong(
                                                "you can not add more this item");
                                            return;
                                          }
                                          final cartItem =
                                              CartItem(product: Item.id!);
                                          cartProvider.addToCart(cartItem);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                              width: getHeight(context, 4),
                                              height: getHeight(context, 4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: mainColorGrey
                                                          .withOpacity(0.5)),
                                                  color: mainColorGrey),
                                              child: Icon(Icons.add,
                                                  color: mainColorWhite,
                                                  size: getHeight(context, 3))),
                                        ),
                                      ),
                                      Text(
                                        cartProvider
                                            .calculateQuantityForProduct(
                                                int.parse(Item.id.toString()))
                                            .toString(),
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                              width: getHeight(context, 4),
                                              height: getHeight(context, 4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: mainColorGrey
                                                          .withOpacity(0.5)),
                                                  color: mainColorGrey),
                                              child: Icon(Icons.delete,
                                                  color: mainColorWhite,
                                                  size: getHeight(context, 3))),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          isItemInCart ? Spacer() : SizedBox(),
                          isItemInCart
                              ? TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyCart()),
                                    );
                                  },
                                  child: Text("My Cart".tr,
                                      style: TextStyle(
                                        color: mainColorWhite,
                                        fontSize: 16,
                                        fontFamily: mainFontnormal,
                                      )),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 30),
                                        getHeight(context, 4)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                          color: mainColorRed, width: 1.0),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                            color: mainColorGrey,
                            fontFamily: mainFontbold,
                            fontSize: 20),
                      ),
                      Text(
                        "Welcome to athome online market application! We're here to provide you with a convenient and efficient way to shop for your groceries and have them delivered right to your doorstep. Our platform is designed to enhance your shopping experience and make grocery shopping hassle-free. Here's a brief overview of what our application offers",
                        style: TextStyle(
                            color: mainColorGrey,
                            fontFamily: mainFontnormal,
                            fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
