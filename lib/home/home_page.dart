import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/value.dart';
import 'package:athome/Home/all_item.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/item_categories.dart';
import 'package:athome/landing/login_page.dart';
import 'package:athome/landing/splash_screen.dart';
import 'package:athome/main.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Home/Categories.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'oneitem.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  update(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: false);
    productrovider.updatePost(false);
  }

  Future<void> checkinternet() async {
    if (await noInternet(context)) {
      return;
    }

    if (loaddata) {
      update(context);
    } else {
      loaddata = true;
    }
  }

  @override
  void initState() {
    checkinternet();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productrovider = Provider.of<productProvider>(context, listen: true);

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              title: Image.asset(
                "assets/images/logoB.png",
                width: getWidth(context, 30),
              ),

              //
              automaticallyImplyLeading: false,
              backgroundColor: mainColorLightGrey,
              expandedHeight:
                  getHeight(context, 30), // Height of the app bar when expanded
              floating: false, // The app bar won't disappear on scroll
              pinned: true, // The app bar remains pinned at the top
              flexibleSpace: Visibility(
                visible: productrovider.show,
                replacement: Skeletonizer(
                  enabled: true,
                  child: FlexibleSpaceBar(
                    background: Center(
                      child: Stack(
                        // alignment: Alignment.bottomRight,
                        children: [
                          Image.asset(
                            "assets/images/banner.jpg",
                            // placeholder: (context, url) =>
                            //     Image.asset("assets/images/002_logo_1.png"),
                            // errorWidget: (context, url, error) =>
                            //     Image.asset("assets/images/002_logo_1.png"),
                            width: getWidth(context, 100),
                            height: getHeight(context, 100),
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.all(getHeight(context, 1.5)),
                            child: Align(
                              alignment: lang == "en"
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: Container(
                                width: getWidth(context, 25),
                                height: getWidth(context, 9),
                                decoration: BoxDecoration(
                                    color: mainColorRed,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Order now".tr,
                                      style: TextStyle(
                                          color: mainColorWhite, fontSize: 14),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                child: FlexibleSpaceBar(
                  background: Center(
                    child: Stack(
                      // alignment: Alignment.bottomRight,
                      children: [
                        CachedNetworkImage(
                          imageUrl: productrovider.show
                              ? lang == "en"
                                  ? imageUrlServer +
                                      productrovider.tops[0].imgEn!
                                  : lang == "ar"
                                      ? imageUrlServer +
                                          productrovider.tops[0].imgAr!
                                      : imageUrlServer +
                                          productrovider.tops[0].imgKur!
                              : "",
                          placeholder: (context, url) =>
                              Image.asset("assets/images/002_logo_1.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/002_logo_1.png"),
                          width: getWidth(context, 100),
                          height: getHeight(context, 100),
                          fit: BoxFit.fill,
                        ),
                        productrovider.show
                            ? productrovider.tops[0].brandId! > 0
                                ? Padding(
                                    padding:
                                        EdgeInsets.all(getHeight(context, 1.5)),
                                    child: Align(
                                      alignment: lang == "en"
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      child: Container(
                                        width: getWidth(context, 25),
                                        height: getWidth(context, 9),
                                        decoration: BoxDecoration(
                                            color: mainColorRed,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextButton(
                                            onPressed: () {
                                              productrovider.settype("brand");
                                              productrovider.setidItem(
                                                  productrovider
                                                      .tops[0].brandId!);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AllItem()),
                                              );
                                            },
                                            child: Text(
                                              "Order now".tr,
                                              style: TextStyle(
                                                  color: mainColorWhite,
                                                  fontSize: 14),
                                            )),
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Text(
                            "Categories".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontSize: 16,
                                fontFamily: mainFontbold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: TextButton(
                            onPressed: () {
                              !productrovider.show
                                  ? const SizedBox()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Categories()),
                                    );
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: mainColorRed),
                            child: Row(
                              children: [
                                Text(
                                  "View All".tr,
                                  style: TextStyle(
                                    color: mainColorRed,
                                    fontSize: 14,
                                    fontFamily: mainFontnormal,
                                  ),
                                ),
                                SizedBox(
                                  width: getWidth(context, 2),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: mainColorRed,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 14),
                      child: Visibility(
                        visible: productrovider.show,
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
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {},
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              100), // Adjust the corner radius
                                        ),
                                        child: Container(
                                          width: getHeight(context, 8),
                                          height: getHeight(context, 8),
                                          decoration: BoxDecoration(
                                              color: mainColorLightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Center(
                                              child: CircleAvatar(
                                            backgroundColor:
                                                mainColorGrey.withOpacity(0.05),
                                          )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getHeight(context, 1),
                                    ),
                                    Text(
                                      "cateItem".tr,
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontFamily: mainFontnormal,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productrovider.categores.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cateItem = productrovider.categores[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 2)),
                              child: Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      productrovider.setcatetype(cateItem.id!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                itemCategories()),
                                      ).then((value) {
                                        productrovider.setsubcateSelect(0);
                                      });
                                    },
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            100), // Adjust the corner radius
                                      ),
                                      child: Container(
                                        width: getHeight(context, 8),
                                        height: getHeight(context, 8),
                                        decoration: BoxDecoration(
                                            color: mainColorLightGrey,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                imageUrlServer + cateItem.img!,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            width: getHeight(context, 5),
                                            height: getHeight(context, 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(context, 1),
                                  ),
                                  Text(
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
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    productrovider.Orderitems.isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 2)),
                                    child: Text(
                                      "Recent Order".tr,
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
                                            if (productrovider.show) {
                                              productrovider.settype("orders");
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AllItem()),
                                              );
                                            }
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
                              SizedBox(
                                height: getHeight(context, 28),
                                //  decoration: BoxDecoration(border: Border.all()),
                                child: Visibility(
                                  visible: productrovider.show,
                                  replacement: Skeletonizer(
                                    enabled: true,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 10,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getWidth(context, 2)),
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
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const Oneitem()),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: getWidth(
                                                              context, 32),
                                                          height: getHeight(
                                                              context, 14),
                                                          decoration:
                                                              BoxDecoration(
                                                                  //  border: Border.all(color: mainColorRed),
                                                                  color:
                                                                      mainColorLightGrey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                          child: Center(
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "assets/images/002_logo_1.png",
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Image.asset(
                                                                      "assets/images/002_logo_1.png"),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                      "assets/images/002_logo_1.png"),
                                                              width: getHeight(
                                                                  context, 13),
                                                              height: getHeight(
                                                                  context, 13),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: Container(
                                                              width: getWidth(
                                                                  context, 8),
                                                              height: getWidth(
                                                                  context, 8),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          100),
                                                                  border: Border.all(
                                                                      color: mainColorGrey.withOpacity(
                                                                          0.5)),
                                                                  color:
                                                                      mainColorGrey),
                                                              child: Icon(
                                                                  Icons.add,
                                                                  color:
                                                                      mainColorWhite,
                                                                  size: getHeight(context, 1.5))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                //decoration: BoxDecoration(border: Border.all()),
                                                width: getWidth(context, 32),
                                                height: getHeight(context, 13),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
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
                                                          color: mainColorGrey
                                                              .withOpacity(0.5),
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 9),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      "product" " IQD",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: mainColorGrey,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          fontSize: 11),
                                                    ),
                                                    Text(
                                                      "product" " IQD",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: mainColorRed,
                                                          fontFamily:
                                                              mainFontbold,
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
                                    itemCount: productrovider
                                        .getProductsByIds(productrovider
                                            .listOrderProductIds())
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final product = productrovider
                                          .getProductsByIds(productrovider
                                              .listOrderProductIds())[index];
                                      final isItemInCart = cartProvider
                                          .itemExistsInCart(product);
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getWidth(context, 2)),
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        productrovider
                                                            .setidItem(
                                                                product.id!);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Oneitem()),
                                                        );
                                                      },
                                                      child: Container(
                                                        width: getWidth(
                                                            context, 32),
                                                        height: getHeight(
                                                            context, 14),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                mainColorLightGrey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Center(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                imageUrlServer +
                                                                    product
                                                                        .coverImg
                                                                        .toString(),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Image.asset(
                                                                    "assets/images/002_logo_1.png"),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    "assets/images/002_logo_1.png"),
                                                            width: getHeight(
                                                                context, 13),
                                                            height: getHeight(
                                                                context, 13),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (!isLogin) {
                                                            // confirmAlertlogin(
                                                            //     context,
                                                            //     "Login Please"
                                                            //         .tr,
                                                            //     "You need to login first"
                                                            //         .tr);
                                                            return;
                                                          }
                                                          if (product.offerPrice! >
                                                                  -1 &&
                                                              product.orderLimit ==
                                                                  cartProvider.calculateQuantityForProduct(
                                                                      int.parse(
                                                                          product
                                                                              .id
                                                                              .toString()))) {
                                                            toastLong(
                                                                "you can not add more this item"
                                                                    .tr);
                                                            return;
                                                          }
                                                          final cartItem =
                                                              CartItem(
                                                                  product:
                                                                      product
                                                                          .id!);
                                                          cartProvider
                                                              .addToCart(
                                                                  cartItem);
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Container(
                                                            width: getWidth(
                                                                context, 8),
                                                            height: getWidth(
                                                                context, 8),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        100),
                                                                border: Border.all(
                                                                    color: mainColorGrey
                                                                        .withOpacity(
                                                                            0.5)),
                                                                color:
                                                                    mainColorGrey),
                                                            child: isItemInCart
                                                                ? Center(
                                                                    child: Text(
                                                                      cartProvider
                                                                          .calculateQuantityForProduct(int.parse(product
                                                                              .id
                                                                              .toString()))
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              mainColorWhite),
                                                                    ),
                                                                  )
                                                                : Icon(
                                                                    Icons.add,
                                                                    color:
                                                                        mainColorWhite,
                                                                    size: getHeight(
                                                                        context,
                                                                        3))),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                product.offerPrice! > -1
                                                    ? Container(
                                                        width: getHeight(
                                                            context, 8),
                                                        height: getHeight(
                                                            context, 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: lang ==
                                                                  "en"
                                                              ? const BorderRadius
                                                                  .only(
                                                                  //  topLeft: Radius.circular(20.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20.0),
                                                                  // bottomLeft: Radius.circular(0.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20.0),
                                                                )
                                                              : const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
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
                                                                  double.parse(
                                                                      product
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
                                                                color:
                                                                    mainColorWhite,
                                                                size: 12),
                                                          ],
                                                        ))
                                                    : const SizedBox(),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                productrovider
                                                    .setidItem(product.id!);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Oneitem()),
                                                );
                                              },
                                              child: SizedBox(
                                                //decoration: BoxDecoration(border: Border.all()),
                                                width: getWidth(context, 32),
                                                height: getHeight(context, 13),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      lang == "en"
                                                          ? product.contentsEn
                                                              .toString()
                                                          : lang == "ar"
                                                              ? product
                                                                  .contentsAr
                                                                  .toString()
                                                              : product
                                                                  .contentsKu
                                                                  .toString(),
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: mainColorGrey
                                                              .withOpacity(0.5),
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      addCommasToPrice(
                                                          product.price!),
                                                      style: TextStyle(
                                                          decoration: product
                                                                      .offerPrice! >
                                                                  -1
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                          color: mainColorGrey,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          fontSize: 14),
                                                    ),
                                                    product.offerPrice! > -1
                                                        ? Text(
                                                            addCommasToPrice(
                                                                product
                                                                    .offerPrice!),
                                                            style: TextStyle(
                                                                color:
                                                                    mainColorRed,
                                                                fontFamily:
                                                                    mainFontbold,
                                                                fontSize: 14),
                                                          )
                                                        : const SizedBox(),
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
                          )
                        : const SizedBox(),
                    productrovider.getProductsByDiscount().isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 2)),
                                    child: Text(
                                      "Discount".tr,
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontSize: 16,
                                          fontFamily: mainFontbold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 2)),
                                    child: TextButton(
                                      onPressed: () {
                                        if (productrovider.show) {
                                          productrovider.settype("discount");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AllItem()),
                                          );
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: mainColorRed),
                                      child: Row(
                                        children: [
                                          Text(
                                            "View All".tr,
                                            style: TextStyle(
                                              color: mainColorRed,
                                              fontSize: 14,
                                              fontFamily: mainFontnormal,
                                            ),
                                          ),
                                          SizedBox(
                                            width: getWidth(context, 2),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: mainColorRed,
                                            size: 14,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getHeight(context, 28),
                                //  decoration: BoxDecoration(border: Border.all()),
                                child: Visibility(
                                  visible: productrovider.show,
                                  replacement: Skeletonizer(
                                    enabled: true,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 10,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getWidth(context, 2)),
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
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const Oneitem()),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: getWidth(
                                                              context, 32),
                                                          height: getHeight(
                                                              context, 14),
                                                          decoration:
                                                              BoxDecoration(
                                                                  //  border: Border.all(color: mainColorRed),
                                                                  color:
                                                                      mainColorLightGrey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                          child: Center(
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "assets/images/002_logo_1.png",
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Image.asset(
                                                                      "assets/images/002_logo_1.png"),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                      "assets/images/002_logo_1.png"),
                                                              width: getHeight(
                                                                  context, 13),
                                                              height: getHeight(
                                                                  context, 13),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: Container(
                                                              width: getWidth(
                                                                  context, 8),
                                                              height: getWidth(
                                                                  context, 8),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          100),
                                                                  border: Border.all(
                                                                      color: mainColorGrey.withOpacity(
                                                                          0.5)),
                                                                  color:
                                                                      mainColorGrey),
                                                              child: Icon(
                                                                  Icons.add,
                                                                  color:
                                                                      mainColorWhite,
                                                                  size: getHeight(context, 1.5))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      width:
                                                          getHeight(context, 6),
                                                      height:
                                                          getHeight(context, 3),
                                                      decoration: BoxDecoration(
                                                        borderRadius: lang ==
                                                                "en"
                                                            ? const BorderRadius
                                                                .only(
                                                                //  topLeft: Radius.circular(20.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20.0),
                                                                // bottomLeft: Radius.circular(0.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20.0),
                                                              )
                                                            : const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20.0),
                                                                bottomLeft: Radius
                                                                    .circular(
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
                                                                double.parse(5
                                                                    .toString()),
                                                                double.parse(6
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
                                                              color:
                                                                  mainColorWhite,
                                                              size: 12),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                //decoration: BoxDecoration(border: Border.all()),
                                                width: getWidth(context, 32),
                                                height: getHeight(context, 13),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
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
                                                          color: mainColorGrey
                                                              .withOpacity(0.5),
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 9),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      "product" " IQD",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: mainColorGrey,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          fontSize: 11),
                                                    ),
                                                    Text(
                                                      "product" " IQD",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: mainColorRed,
                                                          fontFamily:
                                                              mainFontbold,
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
                                    itemCount: productrovider
                                        .getProductsByDiscount()
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final product = productrovider
                                          .getProductsByDiscount()[index];
                                      final isItemInCart = cartProvider
                                          .itemExistsInCart(product);
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getWidth(context, 2)),
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        productrovider
                                                            .setidItem(
                                                                product.id!);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Oneitem()),
                                                        );
                                                      },
                                                      child: Container(
                                                        width: getWidth(
                                                            context, 32),
                                                        height: getHeight(
                                                            context, 14),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                mainColorLightGrey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Center(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                imageUrlServer +
                                                                    product
                                                                        .coverImg
                                                                        .toString(),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Image.asset(
                                                                    "assets/images/002_logo_1.png"),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    "assets/images/002_logo_1.png"),
                                                            width: getHeight(
                                                                context, 13),
                                                            height: getHeight(
                                                                context, 13),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (!isLogin) {
                                                            AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    animType: AnimType
                                                                        .scale,
                                                                    dialogType:
                                                                        DialogType
                                                                            .warning,
                                                                    showCloseIcon:
                                                                        true,
                                                                    title: "Login Please"
                                                                        .tr,
                                                                    desc:
                                                                        "You need login to add item in cart"
                                                                            .tr,
                                                                    btnOkColor:
                                                                        mainColorRed,
                                                                    btnCancelOnPress:
                                                                        () {},
                                                                    btnOkText:
                                                                        "Login"
                                                                            .tr,
                                                                    btnOkOnPress:
                                                                        () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const RegisterWithPhoneNumber()),
                                                                      );
                                                                    },
                                                                    btnCancelColor:
                                                                        mainColorGrey)
                                                                .show();
                                                            return;
                                                          }
                                                          if (product.offerPrice! >
                                                                  -1 &&
                                                              product.orderLimit ==
                                                                  cartProvider.calculateQuantityForProduct(
                                                                      int.parse(
                                                                          product
                                                                              .id
                                                                              .toString()))) {
                                                            toastLong(
                                                                "you can not add more this item"
                                                                    .tr);
                                                            return;
                                                          }
                                                          final cartItem =
                                                              CartItem(
                                                                  product:
                                                                      product
                                                                          .id!);
                                                          cartProvider
                                                              .addToCart(
                                                                  cartItem);
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Container(
                                                            width: getWidth(
                                                                context, 8),
                                                            height: getWidth(
                                                                context, 8),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        100),
                                                                border: Border.all(
                                                                    color: mainColorGrey
                                                                        .withOpacity(
                                                                            0.5)),
                                                                color:
                                                                    mainColorGrey),
                                                            child: isItemInCart
                                                                ? Center(
                                                                    child: Text(
                                                                      cartProvider
                                                                          .calculateQuantityForProduct(int.parse(product
                                                                              .id
                                                                              .toString()))
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              mainColorWhite),
                                                                    ),
                                                                  )
                                                                : Icon(
                                                                    Icons.add,
                                                                    color:
                                                                        mainColorWhite,
                                                                    size: getHeight(
                                                                        context,
                                                                        3))),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                    width:
                                                        getHeight(context, 6),
                                                    height:
                                                        getHeight(context, 3),
                                                    decoration: BoxDecoration(
                                                      borderRadius: lang == "en"
                                                          ? const BorderRadius
                                                              .only(
                                                              //  topLeft: Radius.circular(20.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20.0),
                                                              // bottomLeft: Radius.circular(0.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20.0),
                                                            )
                                                          : const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20.0),
                                                              bottomLeft: Radius
                                                                  .circular(
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
                                                            color:
                                                                mainColorWhite,
                                                            size: 12),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                productrovider
                                                    .setidItem(product.id!);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Oneitem()),
                                                );
                                              },
                                              child: SizedBox(
                                                //decoration: BoxDecoration(border: Border.all()),
                                                width: getWidth(context, 32),
                                                height: getHeight(context, 13),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      lang == "en"
                                                          ? product.contentsEn
                                                              .toString()
                                                          : lang == "ar"
                                                              ? product
                                                                  .contentsAr
                                                                  .toString()
                                                              : product
                                                                  .contentsKu
                                                                  .toString(),
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: mainColorGrey
                                                              .withOpacity(0.5),
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      addCommasToPrice(
                                                          product.price2! > -1
                                                              ? product.price2!
                                                              : product.price!),
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: mainColorGrey,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      addCommasToPrice(
                                                          product.offerPrice!),
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: mainColorRed,
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 12),
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
                          )
                        : const SizedBox(),
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
                          child: TextButton(
                            onPressed: () {
                              if (productrovider.show) {
                                productrovider.settype("Highlight");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AllItem()),
                                );
                              }
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: mainColorRed),
                            child: Row(
                              children: [
                                Text(
                                  "View All".tr,
                                  style: TextStyle(
                                    color: mainColorRed,
                                    fontSize: 14,
                                    fontFamily: mainFontnormal,
                                  ),
                                ),
                                SizedBox(
                                  width: getWidth(context, 2),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: mainColorRed,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 28),
                      //  decoration: BoxDecoration(border: Border.all()),
                      child: Visibility(
                        visible: productrovider.show,
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
                                                    color: mainColorLightGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "assets/images/002_logo_1.png",
                                                    placeholder: (context,
                                                            url) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    width:
                                                        getHeight(context, 13),
                                                    height:
                                                        getHeight(context, 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Container(
                                                    width: getWidth(context, 8),
                                                    height:
                                                        getWidth(context, 8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                            color: mainColorGrey
                                                                .withOpacity(
                                                                    0.5)),
                                                        color: mainColorGrey),
                                                    child: Icon(Icons.add,
                                                        color: mainColorWhite,
                                                        size: getHeight(
                                                            context, 1.5))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      //decoration: BoxDecoration(border: Border.all()),
                                      width: getWidth(context, 32),
                                      height: getHeight(context, 13),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                          const SizedBox(
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
                                                color: mainColorGrey
                                                    .withOpacity(0.5),
                                                fontFamily: mainFontbold,
                                                fontSize: 9),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "product" " IQD",
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
                          itemCount:
                              productrovider.getProductsByHighlight().length,
                          itemBuilder: (BuildContext context, int index) {
                            final product =
                                productrovider.getProductsByHighlight()[index];
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
                                          productrovider.setidItem(product.id!);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Oneitem()),
                                          );
                                        },
                                        child: Container(
                                          width: getWidth(context, 32),
                                          height: getHeight(context, 14),
                                          decoration: BoxDecoration(
                                              //  border: Border.all(color: mainColorRed),
                                              color: mainColorLightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: CachedNetworkImage(
                                              imageUrl: imageUrlServer +
                                                  product.coverImg.toString(),
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
                                        onTap: () {
                                          setState(() {
                                            if (!isLogin) {
                                              AwesomeDialog(
                                                      context: context,
                                                      animType: AnimType.scale,
                                                      dialogType:
                                                          DialogType.info,
                                                      showCloseIcon: true,
                                                      title: "Login Please".tr,
                                                      desc:
                                                          "You need login to add item in cart"
                                                              .tr,
                                                      btnOkColor: mainColorRed,
                                                      btnCancelOnPress: () {},
                                                      btnOkText: "Login",
                                                      btnOkOnPress: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const RegisterWithPhoneNumber()),
                                                        );
                                                      },
                                                      btnCancelColor:
                                                          mainColorGrey)
                                                  .show();
                                              return;
                                            }
                                            if (product.offerPrice! > -1 &&
                                                product.orderLimit ==
                                                    cartProvider
                                                        .calculateQuantityForProduct(
                                                            int.parse(product.id
                                                                .toString()))) {
                                              toastLong(
                                                  "you can not add more this item"
                                                      .tr);
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
                                              height: getWidth(context, 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      color: mainColorGrey
                                                          .withOpacity(0.5)),
                                                  color: mainColorGrey),
                                              child: isItemInCart
                                                  ? Center(
                                                      child: Text(
                                                        cartProvider
                                                            .calculateQuantityForProduct(
                                                                int.parse(product
                                                                    .id
                                                                    .toString()))
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                mainColorWhite),
                                                      ),
                                                    )
                                                  : Icon(Icons.add,
                                                      color: mainColorWhite,
                                                      size: getHeight(
                                                          context, 3))),
                                        ),
                                      ),
                                    ],
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
                                    child: SizedBox(
                                      //decoration: BoxDecoration(border: Border.all()),
                                      width: getWidth(context, 32),
                                      height: getHeight(context, 13),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
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
                                                fontFamily: mainFontbold,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            addCommasToPrice(
                                                product.price2! > -1
                                                    ? product.price2!
                                                    : product.price!),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: mainColorGrey,
                                                fontFamily: mainFontbold,
                                                fontSize: 12),
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
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 2)),
                      child: Visibility(
                        visible: productrovider.show,
                        replacement: Skeletonizer(
                          enabled: true,
                          child: SizedBox(
                            width: getWidth(context, 100),
                            height: getHeight(context, 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CarouselSlider(
                                items: [
                                  ClipRRect(
                                    child: Image.asset(
                                      "assets/images/002_logo_1.png",
                                      width: getWidth(context, 100),
                                      height: getHeight(context, 20),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: true,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 3000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: getWidth(context, 100),
                          height: getHeight(context, 25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: CarouselSlider(
                              items: productrovider.slides.map((item) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        productrovider.settype("brand");
                                        productrovider.setidItem(item.brandId!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllItem()),
                                        );
                                      },
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl: imageUrlServer + item.img!,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  "assets/images/002_logo_1.png"),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/002_logo_1.png"),
                                          width: getWidth(context, 100),
                                          height: getHeight(context, 20),
                                          fit: BoxFit.fill,
                                        ),
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
                                autoPlayInterval: const Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 3000),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Text(
                            "Best Seller".tr,
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
                                  if (productrovider.show) {
                                    productrovider.settype("best");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AllItem()),
                                    );
                                  }
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor: mainColorRed),
                                child: Row(
                                  children: [
                                    Text(
                                      "View All".tr,
                                      style: TextStyle(
                                        color: mainColorRed,
                                        fontSize: 14,
                                        fontFamily: mainFontnormal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: getWidth(context, 2),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: mainColorRed,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 28),
                      //  decoration: BoxDecoration(border: Border.all()),
                      child: Visibility(
                        visible: productrovider.show,
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
                                                    color: mainColorLightGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "assets/images/002_logo_1.png",
                                                    placeholder: (context,
                                                            url) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    width:
                                                        getHeight(context, 13),
                                                    height:
                                                        getHeight(context, 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Container(
                                                    width: getWidth(context, 8),
                                                    height:
                                                        getWidth(context, 8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                            color: mainColorGrey
                                                                .withOpacity(
                                                                    0.5)),
                                                        color: mainColorGrey),
                                                    child: Icon(Icons.add,
                                                        color: mainColorWhite,
                                                        size: getHeight(
                                                            context, 1.5))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      //decoration: BoxDecoration(border: Border.all()),
                                      width: getWidth(context, 32),
                                      height: getHeight(context, 13),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                          const SizedBox(
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
                                                color: mainColorGrey
                                                    .withOpacity(0.5),
                                                fontFamily: mainFontbold,
                                                fontSize: 9),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "product" " IQD",
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
                          itemCount:
                              productrovider.getProductsByBestsell().length,
                          itemBuilder: (BuildContext context, int index) {
                            final product =
                                productrovider.getProductsByBestsell()[index];
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
                                          productrovider.setidItem(product.id!);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Oneitem()),
                                          );
                                        },
                                        child: Container(
                                          width: getWidth(context, 32),
                                          height: getHeight(context, 14),
                                          decoration: BoxDecoration(
                                              //  border: Border.all(color: mainColorRed),
                                              color: mainColorLightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: CachedNetworkImage(
                                              imageUrl: imageUrlServer +
                                                  product.coverImg.toString(),
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
                                        onTap: () {
                                          setState(() {
                                            if (!isLogin) {
                                              AwesomeDialog(
                                                      context: context,
                                                      animType: AnimType.scale,
                                                      dialogType:
                                                          DialogType.info,
                                                      showCloseIcon: true,
                                                      title: 'Login Please'.tr,
                                                      desc:
                                                          "You need login to add item in cart"
                                                              .tr,
                                                      btnOkColor: mainColorRed,
                                                      btnCancelOnPress: () {},
                                                      btnOkText: "Login".tr,
                                                      btnOkOnPress: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const RegisterWithPhoneNumber()),
                                                        );
                                                      },
                                                      btnCancelColor:
                                                          mainColorGrey)
                                                  .show();
                                              return;
                                            }
                                            if (product.offerPrice! > -1 &&
                                                product.orderLimit ==
                                                    cartProvider
                                                        .calculateQuantityForProduct(
                                                            int.parse(product.id
                                                                .toString()))) {
                                              toastLong(
                                                  "you can not add more this item"
                                                      .tr);
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
                                              height: getWidth(context, 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      color: mainColorGrey
                                                          .withOpacity(0.5)),
                                                  color: mainColorGrey),
                                              child: isItemInCart
                                                  ? Center(
                                                      child: Text(
                                                        cartProvider
                                                            .calculateQuantityForProduct(
                                                                int.parse(product
                                                                    .id
                                                                    .toString()))
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                mainColorWhite),
                                                      ),
                                                    )
                                                  : Icon(Icons.add,
                                                      color: mainColorWhite,
                                                      size: getHeight(
                                                          context, 3))),
                                        ),
                                      ),
                                    ],
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
                                    child: SizedBox(
                                      //decoration: BoxDecoration(border: Border.all()),
                                      width: getWidth(context, 32),
                                      height: getHeight(context, 13),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
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
                                                fontFamily: mainFontbold,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            addCommasToPrice(
                                                product.price2! > -1
                                                    ? product.price2!
                                                    : product.price!),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: mainColorGrey,
                                                fontFamily: mainFontbold,
                                                fontSize: 12),
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
            )
          ]),
        ),
      ),
    );
  }
}
