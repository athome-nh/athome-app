import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/value.dart';
import 'package:athome/Home/all_item.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/item_categories.dart';
import 'package:athome/landing/splash_screen.dart';
import 'package:athome/main.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Home/Categories.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

  // Check Internet
  Future<void> checkinternet() async {
    if (await noInternet(context)) {
      Provider.of<productProvider>(context, listen: false)
          .setnointernetcheck(true);
      return;
    }

    if (loaddata) {
      // update(context);
    } else {
      final productrovider =
          Provider.of<productProvider>(context, listen: false);
      final cartprovider = Provider.of<CartProvider>(context, listen: false);
      List<CartItem> mycart = cartprovider.cartItems;
      for (var item in mycart) {
        final existingItemIndex = productrovider.products.indexWhere(
          (element) => element.id == item.product,
        );
        if (existingItemIndex == -1) {
          cartprovider.cartItems.remove(cartprovider.cartItems[item.product]);
        }
      }
      List<CartItem> myfav = cartprovider.FavItems;
      for (var item in myfav) {
        final existingItemIndex = productrovider.products.indexWhere(
          (element) => element.id == item.product,
        );
        if (existingItemIndex == -1) {
          cartprovider.FavItems.remove(cartprovider.FavItems[item.product]);
        }
      }
      loaddata = true;
    }
  }

  var subscription;
  @override
  void initState() {
    checkinternet();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      final pro = Provider.of<productProvider>(context, listen: false);
      if (result == ConnectivityResult.none) {
        pro.setnointernetcheck(true);
      } else {
        if (pro.nointernetCheck) {
          pro.updatePost(false);
          pro.setnointernetcheck(false);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productrovider = Provider.of<productProvider>(context, listen: true);

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.nointernetCheck
          ? noInternetWidget(context)
          : Scaffold(
              body: SafeArea(
                child: CustomScrollView(slivers: <Widget>[
                  // top
                  SliverAppBar(
                    title: Image.asset(
                      "assets/images/dlly_Logo.png",
                      width: getWidth(context, 30),
                    ),

                    //
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    centerTitle: false,
                    expandedHeight: getHeight(context, 25),
                    floating: false,
                    pinned: false,

                    flexibleSpace: Visibility(
                      visible: productrovider.show,
                      replacement: Skeletonizer(
                        effect: ShimmerEffect.raw(colors: [
                          mainColorGrey.withOpacity(0.1),
                          mainColorWhite,
                          // mainColorRed.withOpacity(0.1),
                        ]),
                        enabled: true,
                        child: FlexibleSpaceBar(
                          background: Center(
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: "assets/images/Logo-Type-2.png",
                                  placeholder: (context, url) => Image.asset(
                                      "assets/images/Logo-Type-2.png"),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/Logo-Type-2.png"),
                                  width: getWidth(context, 100),
                                  height: getHeight(context, 100),
                                ),
                                Padding(
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
                                          color: mainColorGrey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                            color: mainColorGrey, fontSize: 14),
                                      ),
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
                                placeholder: (context, url) => Image.asset(
                                    "assets/images/Logo-Type-2.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        "assets/images/Logo-Type-2.png"),
                                width: getWidth(context, 100),
                                height: getHeight(context, 100),
                                fit: BoxFit.fill,
                              ),
                              productrovider.show
                                  ? productrovider.tops[0].brandId! > 0
                                      ? Padding(
                                          padding: EdgeInsets.all(
                                              getHeight(context, 1.5)),
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
                                                    productrovider
                                                        .settype("brand");
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

                  // body
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Categories
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 2)),
                                child: Text(
                                  "Categories".tr,
                                  style: TextStyle(
                                      color: mainColorBlack,
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
                                      foregroundColor: mainColorRed,
                                      backgroundColor: Colors.transparent),
                                  child: Row(
                                    children: [
                                      Text(
                                        "View All".tr,
                                      ),
                                      // SizedBox(
                                      //   width: getWidth(context, 2),
                                      // ),
                                      // Icon(
                                      //   Icons.arrow_forward_ios_outlined,
                                      //   color: mainColorRed,
                                      //   size: 14,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Shimmer Effect
                          SizedBox(
                            height: getHeight(context, 14),
                            child: Visibility(
                              visible: productrovider.show,
                              replacement: Skeletonizer(
                                effect: ShimmerEffect.raw(colors: [
                                  mainColorGrey.withOpacity(0.1),
                                  mainColorWhite,
                                  //   mainColorRed.withOpacity(0.1),
                                ]),
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
                                        children: <Widget>[
                                          Container(
                                            width: getHeight(context, 8),
                                            height: getHeight(context, 8),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: mainColorBlack
                                                        .withOpacity(0.1)),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Center(
                                                child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "assets/images/shimer.png",
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        "assets/images/shimer.png"),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/images/shimer.png"),
                                                fit: BoxFit.fill,
                                                width: getHeight(context, 5),
                                                height: getHeight(context, 5),
                                              ),
                                            )),
                                          ),
                                          SizedBox(
                                            height: getHeight(context, 1),
                                          ),
                                          Text(
                                            "cateItem",
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
                                  final cateItem =
                                      productrovider.categores[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 2)),
                                    child: Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            productrovider
                                                .setcatetype(cateItem.id!);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      itemCategories()),
                                            ).then((value) {
                                              productrovider
                                                  .setsubcateSelect(0);
                                            });
                                          },
                                          child: Container(
                                            width: getHeight(context, 8),
                                            height: getHeight(context, 8),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: mainColorBlack
                                                        .withOpacity(0.1)),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Center(
                                              child: CachedNetworkImage(
                                                imageUrl: imageUrlServer +
                                                    cateItem.img!,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        "assets/images/Logo-Type-2.png"),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/images/Logo-Type-2.png"),
                                                width: getHeight(context, 5),
                                                height: getHeight(context, 5),
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
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainColorBlack,
                                              fontFamily: mainFontnormal,
                                              fontSize: 12),
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
                                    // Recent Order
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
                                                color: mainColorBlack,
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
                                                    productrovider
                                                        .settype("orders");
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AllItem()),
                                                    );
                                                  }
                                                },
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        mainColorRed,
                                                    backgroundColor:
                                                        Colors.transparent),
                                                child: Text(
                                                  "View All".tr,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    listItemsSmall(
                                      context,
                                      productrovider.getProductsByIds2(
                                        productrovider.listOrderProductIds(),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),

                          productrovider.getProductsByDiscount().isNotEmpty
                              ? Column(
                                  children: [
                                    // Discount
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
                                                color: mainColorBlack,
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
                                                productrovider
                                                    .settype("discount");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AllItem()),
                                                );
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                                foregroundColor: mainColorRed,
                                                backgroundColor:
                                                    Colors.transparent),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "View All".tr,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    listItemsSmall(
                                      context,
                                      productrovider.getProductsByDiscount(),
                                    ),
                                  ],
                                )
                              : const SizedBox(),

                          // Highlight
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 2)),
                                child: Text(
                                  "Highlight".tr,
                                  style: TextStyle(
                                      color: mainColorBlack,
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
                                            builder: (context) =>
                                                const AllItem()),
                                      );
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: mainColorRed,
                                      backgroundColor: Colors.transparent),
                                  child: Row(
                                    children: [
                                      Text(
                                        "View All".tr,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          listItemsSmall(
                            context,
                            productrovider.getProductsByHighlight(),
                          ),

                          // Space
                          SizedBox(
                            height: getHeight(context, 1),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 2)),
                            child: Visibility(
                              visible: productrovider.show,
                              replacement: Skeletonizer(
                                effect: ShimmerEffect.raw(colors: [
                                  mainColorGrey.withOpacity(0.1),
                                  mainColorWhite,
                                  //  mainColorRed.withOpacity(0.1),
                                ]),
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
                                            "assets/images/Logo-Type-2.png",
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
                                        autoPlayInterval:
                                            const Duration(seconds: 5),
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
                                              productrovider
                                                  .setidItem(item.brandId!);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AllItem()),
                                              );
                                            },
                                            child: ClipRRect(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    imageUrlServer + item.img!,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        "assets/images/Logo-Type-2.png"),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/images/Logo-Type-2.png"),
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
                                      autoPlayInterval:
                                          const Duration(seconds: 5),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 3000),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Space
                          SizedBox(
                            height: getHeight(context, 1),
                          ),

                          // Best Seller
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 2)),
                                child: Text(
                                  "Best Sell".tr,
                                  style: TextStyle(
                                      color: mainColorBlack,
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
                                          foregroundColor: mainColorRed,
                                          backgroundColor: Colors.transparent),
                                      child: Row(
                                        children: [
                                          Text(
                                            "View All".tr,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          listItemsSmall(
                              context, productrovider.getProductsByBestsell()),

                          // Space
                          SizedBox(
                            height: getHeight(context, 2),
                          )
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
