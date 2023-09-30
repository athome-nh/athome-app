import 'package:athome/Home/ItemDeatil.dart';
import 'package:athome/Switchscreen.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/landing/login_page.dart';
import 'package:athome/main.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Home/AllItem.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../Config/athome_functions.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    late List<ProductModel> products =
        productPro.getProductsBySearch(productPro.searchproduct);
    searchCon.text = productPro.searchproduct;
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: getHeight(context, 3)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Row(
                      children: [
                        Container(
                          width: getWidth(context, 80),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 4)),
                                child: Icon(
                                  Ionicons.search_outline,
                                  color: mainColorGrey.withOpacity(0.45),
                                  size: 30,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    controller: searchCon,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: mainColorGrey,
                                        fontFamily: mainFontbold),
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      productPro.setsearch(searchCon.text);
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search".tr,
                                        hintStyle: TextStyle(
                                            color: mainColorGrey
                                                .withOpacity(0.45))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              searchCon.text = "";
                              productPro.setsearch("");
                            },
                            child: Text(
                              "Clear".tr,
                              style: TextStyle(
                                  color: mainColorRed,
                                  fontFamily: mainFontbold,
                                  fontSize: 16),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 2),
                  ),
                  productPro.searchproduct.isNotEmpty
                      ? Container(
                          height: getHeight(context, 80),
                          width: getWidth(context, 95),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: getWidth(context, 0.5),
                              mainAxisSpacing: getHeight(context, 2),
                              childAspectRatio: getHeight(context, 0.07),
                            ),

                            itemCount:
                                products.length, // Number of items in the grid
                            itemBuilder: (BuildContext context, int index) {
                              final product = products[index];
                              final isItemInCart =
                                  cartProvider.itemExistsInCart(product);
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 2)),
                                child: Container(
                                  // decoration: BoxDecoration(border: Border.all()),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: product.coverImg!,
                                                    placeholder: (context,
                                                            url) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    width:
                                                        getHeight(context, 18),
                                                    height:
                                                        getHeight(context, 18),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (!isLogin) {
                                                      // loginFirstModal(context);
                                                      return;
                                                    }
                                                    final cartItem = CartItem(
                                                        product: product.id!);
                                                    cartProvider
                                                        .addToCart(cartItem);
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: isItemInCart
                                                            ? mainColorRed
                                                                .withOpacity(
                                                                    0.1)
                                                            : mainColorGrey
                                                                .withOpacity(
                                                                    0.2)),
                                                    child: isItemInCart
                                                        ? Icon(
                                                            FontAwesomeIcons
                                                                .heartCircleCheck,
                                                            color: mainColorRed,
                                                            size: getHeight(
                                                                context, 2.5))
                                                        : Icon(
                                                            FontAwesomeIcons
                                                                .heartCirclePlus,
                                                            color:
                                                                mainColorWhite,
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
                                                                Radius.circular(
                                                                    20.0),
                                                            // bottomLeft: Radius.circular(0.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20.0),
                                                          )
                                                        : BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20.0),
                                                          ),
                                                    color: mainColorRed,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        calculatePercentageDiscount(
                                                            double.parse(product
                                                                .price!
                                                                .toString()),
                                                            double.parse(product
                                                                .offerPrice!
                                                                .toString())),
                                                        style: TextStyle(
                                                            color:
                                                                mainColorWhite,
                                                            fontFamily:
                                                                mainFontnormal,
                                                            fontSize: 12),
                                                      ),
                                                      Icon(
                                                          Icons
                                                              .discount_rounded,
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
                                                      ? product.nameEn
                                                          .toString()
                                                      : lang == "ar"
                                                          ? product.nameAr
                                                              .toString()
                                                          : product.nameKu
                                                              .toString(),
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: mainColorGrey,
                                                      fontFamily: mainFontbold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  lang == "en"
                                                      ? product.contentsEn
                                                          .toString()
                                                      : lang == "ar"
                                                          ? product.contentsAr
                                                              .toString()
                                                          : product.contentsKu
                                                              .toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: mainColorGrey
                                                          .withOpacity(0.5),
                                                      fontFamily: mainFontbold,
                                                      fontSize: 9),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  product.price!.toString() +
                                                      " IQD",
                                                  style: TextStyle(
                                                      decoration: product
                                                                  .offerPrice! >
                                                              0
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                      color: mainColorGrey,
                                                      fontFamily:
                                                          mainFontnormal,
                                                      fontSize: 11),
                                                ),
                                                product.offerPrice! > 0
                                                    ? Text(
                                                        product.offerPrice!
                                                                .toString() +
                                                            " IQD",
                                                        style: TextStyle(
                                                            color: mainColorRed,
                                                            fontFamily:
                                                                mainFontbold,
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
                                                  // loginFirstModal(context);
                                                  return;
                                                }
                                                final cartItem = CartItem(
                                                    product: product.id!);
                                                cartProvider
                                                    .addToCart(cartItem);
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                  width: getWidth(context, 10),
                                                  height: getHeight(context, 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: mainColorGrey
                                                              .withOpacity(
                                                                  0.5)),
                                                      color: mainColorGrey),
                                                  child: isItemInCart
                                                      ? Center(
                                                          child: Text(
                                                            cartProvider
                                                                .calculateQuantityForProduct(
                                                                    int.parse(
                                                                        product
                                                                            .id
                                                                            .toString()))
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    mainColorWhite),
                                                          ),
                                                        )
                                                      : Icon(
                                                          FontAwesomeIcons
                                                              .cartShopping,
                                                          color: mainColorWhite,
                                                          size: getHeight(
                                                              context, 2))),
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
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Container(
                            width: getWidth(context, 100),
                            height: getHeight(context, 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CarouselSlider(
                                items: [
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://images.unsplash.com/photo-1563636619-e9143da7973b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG1pbGt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                      width: getWidth(context, 100),
                                      height: getHeight(context, 20),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  CachedNetworkImage(
                                    imageUrl:
                                        "https://images.unsplash.com/photo-1563636619-e9143da7973b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG1pbGt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                    width: getWidth(context, 100),
                                    height: getHeight(context, 20),
                                    fit: BoxFit.fill,
                                  ),
                                  CachedNetworkImage(
                                    imageUrl:
                                        "https://images.unsplash.com/photo-1563636619-e9143da7973b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG1pbGt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                    width: getWidth(context, 100),
                                    height: getHeight(context, 20),
                                    fit: BoxFit.fill,
                                  ),
                                ],
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: true,
                                  autoPlayInterval: Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 3000),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: getHeight(context, 2),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 2)),
                        child: Text(
                          "Highlight".tr,
                          style: TextStyle(
                              color: mainColorGrey,
                              fontSize: 16,
                              fontFamily: mainFontbold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 2)),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                productPro.settype("Highlight");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllItem()),
                                );
                              },
                              child: Text("View All".tr,
                                  style: TextStyle(
                                    color: mainColorRed,
                                    fontSize: 14,
                                    fontFamily: mainFontnormal,
                                  )),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: mainColorRed,
                              size: 13,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: getHeight(context, 28),
                    //  decoration: BoxDecoration(border: Border.all()),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productPro.getProductsByHighlight().length,
                      itemBuilder: (BuildContext context, int index) {
                        final product =
                            productPro.getProductsByHighlight()[index];
                        final isItemInCart =
                            cartProvider.itemExistsInCart(product);
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: lang == "en"
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ItemDeatil()),
                                      );
                                    },
                                    child: Container(
                                      width: getWidth(context, 32),
                                      height: getHeight(context, 14),
                                      decoration: BoxDecoration(
                                          //  border: Border.all(color: mainColorRed),
                                          color: Color(0xffF2F2F2),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl: product.coverImg.toString(),
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  "assets/images/002_logo_1.png"),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/002_logo_1.png"),
                                          width: getHeight(context, 13),
                                          height: getHeight(context, 13),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (!isLogin) {
                                          confirmAlertlogin(
                                              context,
                                              "Login Please".tr,
                                              "You need to login first".tr);
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
                                          width: getWidth(context, 8),
                                          height: getHeight(context, 4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
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
                                              : Icon(Icons.add,
                                                  color: mainColorWhite,
                                                  size: getHeight(context, 3))),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                //decoration: BoxDecoration(border: Border.all()),
                                width: getWidth(context, 32),
                                height: getHeight(context, 13),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          fontFamily: mainFontbold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      lang == "en"
                                          ? product.contentsEn.toString()
                                          : lang == "ar"
                                              ? product.contentsAr.toString()
                                              : product.contentsKu.toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: mainColorGrey.withOpacity(0.5),
                                          fontFamily: mainFontbold,
                                          fontSize: 9),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      product.price!.toString() + " IQD",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontFamily: mainFontbold,
                                          fontSize: 11),
                                    ),
                                  ],
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
          ),
        ),
      ),
    );
  }

  // confirm Alert
  Future<void> confirmAlertlogin(
      BuildContext context, String title, String content) {
    return QuickAlert.show(
      context: context,
      confirmBtnColor: mainColorRed,
      type: QuickAlertType.info,
      title: title,
      text: content,
      confirmBtnText: "Login",
      onConfirmBtnTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterWithPhoneNumber()),
        );
      },
    );
  }
}
