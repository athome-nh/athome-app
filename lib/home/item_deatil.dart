import 'package:athome/Config/value.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/home/my_cart.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:athome/model/products_image/products_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:athome/Config/property.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/my_widget.dart';
import '../controller/productprovider.dart';
import '../main.dart';

class ItemDeatil extends StatefulWidget {
  const ItemDeatil({super.key});

  @override
  State<ItemDeatil> createState() => _ItemDeatilState();
}

class _ItemDeatilState extends State<ItemDeatil> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    ProductModel Item = productrovider.getoneProductById(productrovider.idItem);
    final isItemInCart = cartProvider.itemExistsInCart(Item);
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
                color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
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
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      width: getWidth(context, 90),
                      height: getHeight(context, 60),
                      decoration: BoxDecoration(
                          color: const Color(0xffF2F2F2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 2)),
                            child: images.isNotEmpty
                                ? SizedBox(
                                    width: getWidth(context, 100),
                                    height: getHeight(context, 30),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: CarouselSlider(
                                        items: images.map((imageUrl) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return ClipRRect(
                                                child: CachedNetworkImage(
                                                  imageUrl: imageUrlServer +
                                                      imageUrl.img!,
                                                  width: getWidth(context, 100),
                                                  height:
                                                      getHeight(context, 30),
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
                                    height: getHeight(context, 30),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF2F2F2),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            imageUrlServer + Item.coverImg!,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                                "assets/images/002_logo_1.png"),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                "assets/images/002_logo_1.png"),
                                        width: getWidth(context, 100),
                                        height: getHeight(context, 30),
                                      ),
                                    ),
                                  ),
                          ),
                          Text(
                            lang == "en"
                                ? Item.nameEn!
                                : lang == "ar"
                                    ? Item.nameAr!
                                    : Item.nameKu!,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontbold,
                                fontSize: 24),
                          ),
                          SizedBox(
                            height: getHeight(context, 1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "info:".tr,
                                style: TextStyle(
                                    color: mainColorGrey,
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
                                    color: mainColorGrey,
                                    fontFamily: mainFontnormal,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Container(
                          //                  width: getWidth(context, 95),
                          //                 height: getHeight(context, 3),
                          //                 child: ListView.builder(
                          //                   scrollDirection: Axis.horizontal,
                          //                   itemCount: 15,
                          //                   itemBuilder: (BuildContext context, int index) {
                          //                     return Padding(
                          //                       padding: EdgeInsets.symmetric(
                          //   horizontal: getWidth(context, 2)),
                          //                       child: GestureDetector(
                          //                         onTap: () {},
                          //                         child: Container(
                          //   width: getHeight(context, 7),
                          //   height: getHeight(context, 2),
                          //   decoration: BoxDecoration(
                          //       color: mainColorRed,
                          //       borderRadius: BorderRadius.circular(5)),
                          //   child: Center(
                          //     child: Text(
                          //       "5Kg",
                          //       style: TextStyle(
                          //           color: mainColorWhite,
                          //           fontFamily: mainFontbold,
                          //           fontSize: 13),
                          //     ),
                          //   ),
                          //                         ),
                          //                       ),
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          // ),
                          SizedBox(
                            height: getHeight(context, 1),
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
                                                "you can not add more this item"
                                                    .tr);
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
                              : const SizedBox(),
                          isItemInCart
                              ? SizedBox(
                                  height: getHeight(context, 5),
                                )
                              : SizedBox(
                                  height: getHeight(context, 2),
                                ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyCart()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF2F2F2),
                              fixedSize: Size(
                                  getWidth(context, 65), getHeight(context, 5)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side:
                                    BorderSide(color: mainColorRed, width: 1.0),
                              ),
                            ),
                            child: Text("Place Order".tr,
                                style: TextStyle(
                                  color: mainColorGrey,
                                  fontSize: 18,
                                  fontFamily: mainFontnormal,
                                )),
                          ),
                          SizedBox(
                            height: getHeight(context, 1),
                          ),
                          isItemInCart
                              ? const SizedBox()
                              : TextButton(
                                  onPressed: () {
                                    final cartItem =
                                        CartItem(product: Item.id!);
                                    cartProvider.addToCart(cartItem);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 65),
                                        getHeight(context, 5)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                          color: mainColorRed, width: 1.0),
                                    ),
                                  ),
                                  child: Text("Add To Cart".tr,
                                      style: TextStyle(
                                        color: mainColorWhite,
                                        fontSize: 18,
                                        fontFamily: mainFontnormal,
                                      )),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context, 3),
              ),
              Container(
                width: getWidth(context, 90),
                height: getHeight(context, 25),
                decoration: BoxDecoration(
                    color: const Color(0xffF2F2F2),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 7)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      lang == "en"
                          ? Item.descriptionEn!
                          : lang == "ar"
                              ? Item.descriptionAr!
                              : Item.descriptionKu!,
                      style: TextStyle(
                          height: 1.5,
                          color: mainColorGrey,
                          fontFamily: mainFontnormal,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
