import 'package:athome/Config/my_widget.dart';
import 'package:athome/Home/ItemDeatil.dart';
import 'package:athome/Switchscreen.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/NavSwitch.dart';
import 'package:athome/home/oneitem.dart';
import 'package:athome/landing/login_page.dart';
import 'package:athome/main.dart';
import 'package:athome/model/cart.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Home/AllItem.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

import 'package:skeletonizer/skeletonizer.dart';

import '../Config/athome_functions.dart';
import 'Homepage.dart';

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

    searchCon.text = productPro.searchproduct;
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logoB.png",
            width: getWidth(context, 30),
          ),
          backgroundColor: mainColorWhite,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              Expanded(
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
                                      prefixIcon: Icon(
                                        Ionicons.search_outline,
                                        color: mainColorGrey.withOpacity(0.45),
                                        size: 25,
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Search".tr,
                                      hintStyle: TextStyle(
                                          fontFamily: mainFontnormal,
                                          color:
                                              mainColorGrey.withOpacity(0.45))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        productPro.searchproduct.isNotEmpty
                            ? TextButton(
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
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                true
                    ? listItemsShow(
                        context,
                        productPro
                            .getProductsBySearch(productPro.searchproduct))
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
                  child: Visibility(
                    visible: showitems,
                    replacement: Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 2)),
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
                                        GestureDetector(
                                          onTap: () {},
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
                                                imageUrl: "product",
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        "assets/images/002_logo_1.png"),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/images/002_logo_1.png"),
                                                width: getHeight(context, 13),
                                                height: getHeight(context, 13),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                                width: getWidth(context, 8),
                                                height: getHeight(context, 4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        color: mainColorGrey
                                                            .withOpacity(0.5)),
                                                    color: mainColorGrey),
                                                child: false
                                                    ? Center(
                                                        child: Text(
                                                          "1",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  mainColorWhite),
                                                        ),
                                                      )
                                                    : Icon(Icons.add,
                                                        color: mainColorWhite,
                                                        size: getHeight(
                                                            context, 1.5))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  //decoration: BoxDecoration(border: Border.all()),
                                  width: getWidth(context, 32),
                                  height: getHeight(context, 13),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lang == "en"
                                            ? "product"
                                            : lang == "ar"
                                                ? "product"
                                                : "product",
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
                                            ? "product"
                                            : lang == "ar"
                                                ? "product"
                                                : "product",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color:
                                                mainColorGrey.withOpacity(0.5),
                                            fontFamily: mainFontbold,
                                            fontSize: 9),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "product" + " IQD",
                                        maxLines: 1,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: mainColorGrey,
                                            fontFamily: mainFontnormal,
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
                                      productPro.setidItem(product.id!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Oneitem()),
                                      );
                                    },
                                    child: Container(
                                      width: getWidth(context, 32),
                                      height: getHeight(context, 14),
                                      decoration: BoxDecoration(
                                          //  border: Border.all(color: mainColorRed),
                                          color: Color(0xffF2F2F2),
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                          PanaraInfoDialog.show(
                                            context,
                                            title: "Hello",
                                            message:
                                                "This is the Panara Info Dialog Success.",
                                            buttonText: "Okay",
                                            onTapDismiss: () {
                                              Navigator.pop(context);
                                            },
                                            panaraDialogType:
                                                PanaraDialogType.warning,
                                          );
                                          return;
                                        }
                                        if (product.offerPrice! > -1 &&
                                            product.orderLimit ==
                                                cartProvider
                                                    .calculateQuantityForProduct(
                                                        int.parse(product.id
                                                            .toString()))) {
                                          toastLong(
                                              "you can not add more this item");
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
                              GestureDetector(
                                onTap: () {
                                  productPro.setidItem(product.id!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Oneitem()),
                                  );
                                },
                                child: Container(
                                  //decoration: BoxDecoration(border: Border.all()),
                                  width: getWidth(context, 32),
                                  height: getHeight(context, 13),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            color:
                                                mainColorGrey.withOpacity(0.5),
                                            fontFamily: mainFontbold,
                                            fontSize: 9),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        addCommasToPrice(product.price2! > -1
                                            ? product.price2!
                                            : product.price!),
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: mainColorGrey,
                                            fontFamily: mainFontbold,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
