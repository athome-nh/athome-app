import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Account/reward.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Config/slideshow.dart';
import 'package:dllylas/Landing/splash_screen.dart';
import 'package:dllylas/Notifications/notification_page.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/Categories.dart';
import 'package:dllylas/home/alBrands.dart';
import 'package:dllylas/home/all_item.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/home/search_page.dart';
import 'package:dllylas/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class newhomePage extends StatefulWidget {
  const newhomePage({super.key});

  @override
  State<newhomePage> createState() => _newhomePageState();
}

class _newhomePageState extends State<newhomePage> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 1;
  int _oldPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wellcome to".tr,
                style: TextStyle(fontSize: 12, fontFamily: mainFontnormal),
              ),
              RichText(
                text: new TextSpan(
                  children: <TextSpan>[
                    new TextSpan(
                      text: 'Dlly Las'.tr + " ",
                      style: TextStyle(
                          fontSize: 16,
                          color: mainColorGrey,
                          fontWeight: FontWeight.bold,
                          fontFamily: mainFontnormal),
                    ),
                    new TextSpan(
                      text: 'Supermarket'.tr,
                      style: TextStyle(
                          fontSize: 11,
                          color: mainColorRed,
                          fontWeight: FontWeight.bold,
                          fontFamily: mainFontnormal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton.filledTonal(
              style: IconButton.styleFrom(backgroundColor: mainColorlightGrey),
              icon: Icon(
                Icons.notifications,
                color: mainColorGrey2,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Search()),
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 1)),
                  decoration: BoxDecoration(
                      color: mainColorlightGrey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: mainColorlightGrey)),
                  height: 50,
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.search_outline,
                        color: mainColorGrey2,
                        size: 22,
                      ),
                      SizedBox(
                        width: getWidth(context, 2),
                      ),
                      Container(
                        height: 20,
                        width: 2,
                        color: mainColorGrey2,
                      ),
                      SizedBox(
                        width: getWidth(context, 2),
                      ),
                      Text(
                        "What are you searching for?",
                        style: TextStyle(
                            fontFamily: mainFontnormal,
                            color: mainColorGrey2,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Carousel(productrovider),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Text(
                "Categories",
                style: TextStyle(
                    color: mainColorBlack,
                    fontSize: 20,
                    fontFamily: mainFontbold),
              ),
              Visibility(
                visible: productrovider.show,
                replacement: Skeletonizer(
                  effect: ShimmerEffect.raw(colors: [
                    mainColorGrey.withOpacity(0.1),
                    mainColorWhite,
                    //mainColorRed.withOpacity(0.1),
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: getWidth(context, 55),
                          height: getHeight(context, 22),
                          decoration: BoxDecoration(
                              color: mainColorlightGrey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            width: getWidth(context, 55),
                            height: getHeight(context, 22),
                            color: mainColorlightGrey,
                          )),
                      Container(
                        width: getWidth(context, 35),
                        height: getHeight(context, 22),
                        decoration: BoxDecoration(
                            color: mainColorlightGrey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          alignment: lang == "en"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              onPageChanged: (int page) {},
                              scrollDirection: Axis.vertical,
                              itemCount: productrovider.categores.length,
                              itemBuilder: (context, index) {
                                final category =
                                    productrovider.categores[index];

                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Hello baby njas",
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainColorBlack,
                                              fontFamily: mainFontbold,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        Expanded(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(10)),
                                              child: Image.asset(
                                                "assets/images/category.png",
                                              )),
                                        ),
                                        Container(
                                          height: getHeight(context, 2.5),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: mainColorGrey,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "See More",
                                                style: TextStyle(
                                                    color: mainColorWhite,
                                                    fontFamily: mainFontnormal,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: mainColorWhite,
                                                size: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        !productrovider.show
                            ? const SizedBox()
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Categories()),
                              );
                      },
                      child: Stack(
                        alignment: lang == "en"
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        children: [
                          Stack(
                            alignment: lang == "en"
                                ? Alignment.bottomLeft
                                : Alignment.bottomRight,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                width: getWidth(context, 55),
                                height: getHeight(context, 22),
                                decoration: BoxDecoration(
                                    color: mainColorlightGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: RichText(
                                  text: new TextSpan(
                                    text: 'All You Need'.tr + " \n",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: mainColorGrey,
                                        fontFamily: mainFontbold),
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: "Categories".tr,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: mainColorRed,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: mainFontnormal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Image.asset(
                                  "assets/images/category.png",
                                  width: getHeight(context, 15),
                                  height: getHeight(context, 15),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: CachedNetworkImage(
                                  imageUrl: dotenv.env['imageUrlServer']! +
                                      productrovider.categores[2].img!,
                                  placeholder: (context, url) => Image.asset(
                                      "assets/images/Logo-Type-2.png"),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/Logo-Type-2.png"),
                                  filterQuality: FilterQuality.low,
                                  width: getHeight(context, 7),
                                  height: getHeight(context, 7),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: CachedNetworkImage(
                                  imageUrl: dotenv.env['imageUrlServer']! +
                                      productrovider.categores[3].img!,
                                  placeholder: (context, url) => Image.asset(
                                      "assets/images/Logo-Type-2.png"),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/Logo-Type-2.png"),
                                  filterQuality: FilterQuality.low,
                                  width: getHeight(context, 7),
                                  height: getHeight(context, 7),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: CachedNetworkImage(
                                  imageUrl: dotenv.env['imageUrlServer']! +
                                      productrovider.categores[4].img!,
                                  placeholder: (context, url) => Image.asset(
                                      "assets/images/Logo-Type-2.png"),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/Logo-Type-2.png"),
                                  filterQuality: FilterQuality.low,
                                  width: getHeight(context, 7),
                                  height: getHeight(context, 7),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: getWidth(context, 35),
                      height: getHeight(context, 22),
                      decoration: BoxDecoration(
                          color: mainColorlightGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        alignment: lang == "en"
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (int page) {
                              setState(() {
                                if (_activePage == 5) {
                                  if (_oldPage < page) {
                                    _oldPage = page;
                                    _activePage = 1;
                                  } else {
                                    _oldPage = page;
                                    _activePage = 4;
                                  }
                                } else {
                                  if (_oldPage < page) {
                                    _oldPage = page;
                                    _activePage++;
                                  } else {
                                    if (_activePage == 1) {
                                      _oldPage = page;
                                      _activePage = 5;
                                    } else {
                                      _oldPage = page;
                                      _activePage--;
                                    }
                                  }
                                }
                              });
                            },
                            scrollDirection: Axis.vertical,
                            itemCount: productrovider.categores.length,
                            itemBuilder: (context, index) {
                              final category = productrovider.categores[index];

                              return GestureDetector(
                                onTap: () {
                                  productrovider.setcatetype(category.id!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => itemCategories()),
                                  ).then((value) {
                                    productrovider.setsubcateSelect(0);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        lang == "en"
                                            ? category.nameEn!
                                            : lang == "ar"
                                                ? category.nameAr!
                                                : category.nameKu!,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: mainColorBlack,
                                            fontFamily: mainFontbold,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10)),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                dotenv.env['imageUrlServer']! +
                                                    category.img!,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    "assets/images/Logo-Type-2.png"),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/Logo-Type-2.png"),
                                            filterQuality: FilterQuality.low,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: getHeight(context, 2.5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: mainColorGrey,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "See More",
                                              style: TextStyle(
                                                  color: mainColorWhite,
                                                  fontFamily: mainFontnormal,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: mainColorWhite,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            height: getHeight(context, 10),
                            width: getWidth(context, 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 3,
                                    backgroundColor: _activePage == 1
                                        ? mainColorGrey
                                        : mainColorGrey2,
                                  ),
                                  CircleAvatar(
                                    radius: 3,
                                    backgroundColor: _activePage == 2
                                        ? mainColorGrey
                                        : mainColorGrey2,
                                  ),
                                  CircleAvatar(
                                    radius: 3,
                                    backgroundColor: _activePage == 3
                                        ? mainColorGrey
                                        : mainColorGrey2,
                                  ),
                                  CircleAvatar(
                                    radius: 3,
                                    backgroundColor: _activePage == 4
                                        ? mainColorGrey
                                        : mainColorGrey2,
                                  ),
                                  CircleAvatar(
                                    radius: 3,
                                    backgroundColor: _activePage == 5
                                        ? mainColorGrey
                                        : mainColorGrey2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),

              Visibility(
                visible: productrovider.show,
                replacement: Skeletonizer(
                  child: Stack(
                    alignment: lang == "en"
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    children: [
                      Container(
                        width: getWidth(context, 100),
                        height: getHeight(context, 11),
                        decoration: BoxDecoration(
                            color: mainColorlightGrey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: new TextSpan(
                                      children: <TextSpan>[
                                        new TextSpan(
                                          text: 'Hi'.tr + " ",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mainColorGrey,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: mainFontnormal),
                                        ),
                                        new TextSpan(
                                          text: "sdjjsdkjd",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mainColorRed,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: mainFontnormal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("You are doing so well",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: mainColorRed,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: mainFontnormal)),
                                  Row(
                                    children: [
                                      Skeleton.keep(
                                        child: Image.asset(
                                          "assets/images/star.png",
                                          width: getWidth(context, 6),
                                          height: getWidth(context, 6),
                                        ),
                                      ),
                                      Text(
                                        "5000",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: mainColorRed,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: mainFontbold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("data "),
                                  Text("data sdjj dhhdhd d dhdh"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: mainColorRed),
                        iconAlignment: IconAlignment.end,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                        label: Text(
                          "See More",
                          style: TextStyle(
                              color: mainColorRed,
                              fontFamily: mainFontnormal,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                        onPressed: productrovider.show ? () {} : null,
                      )
                    ],
                  ),
                ),
                child: Stack(
                  alignment: lang == "en"
                      ? Alignment.bottomRight
                      : Alignment.bottomLeft,
                  children: [
                    Container(
                      width: getWidth(context, 100),
                      height: getHeight(context, 11),
                      decoration: BoxDecoration(
                          color: mainColorlightGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: new TextSpan(
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: 'Hi'.tr + " ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mainColorGrey,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: mainFontnormal),
                                      ),
                                      new TextSpan(
                                        text:
                                            userdata["name"] ?? "Guest Account",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mainColorRed,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: mainFontnormal),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "You are doing so well",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: mainColorGrey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: mainFontnormal),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/star.png",
                                      width: getWidth(context, 6),
                                      height: getWidth(context, 6),
                                    ),
                                    Text(
                                      (userdata["point"] ?? "0").toString(),
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: mainColorRed,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: mainFontbold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/images/gobuy.png",
                              width: getWidth(context, 45),
                            )
                          ],
                        ),
                      ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: mainColorRed),
                      iconAlignment: IconAlignment.end,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                      label: Text(
                        "See More",
                        style: TextStyle(
                            color: mainColorRed,
                            fontFamily: mainFontnormal,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                      onPressed: productrovider.show && isLogin
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const coinReward()),
                              );
                            }
                          : null,
                    )
                  ],
                ),
              ),

              productrovider.Orderitems.isNotEmpty &&
                      productrovider
                          .getProductsByIds2(
                            productrovider.listOrderProductIds(),
                          )
                          .isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Order".tr,
                              style: TextStyle(
                                  color: mainColorBlack,
                                  fontSize: 16,
                                  fontFamily: mainFontbold),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
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
                                  child: Text(
                                    "View All".tr,
                                    style: TextStyle(color: mainColorRed),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
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
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount".tr,
                              style: TextStyle(
                                  color: mainColorBlack,
                                  fontSize: 16,
                                  fontFamily: mainFontbold),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (productrovider.show) {
                                  productrovider.settype("discount");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AllItem()),
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View All".tr,
                                    style: TextStyle(color: mainColorRed),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        listItemsSmall(
                          context,
                          productrovider.getProductsByDiscount(),
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: getHeight(context, 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Highlight".tr,
                    style: TextStyle(
                        color: mainColorBlack,
                        fontSize: 16,
                        fontFamily: mainFontbold),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (productrovider.show) {
                        productrovider.settype("Highlight");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllItem()),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          "View All".tr,
                          style: TextStyle(color: mainColorRed),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context, 1),
              ),
              listItemsSmall(
                context,
                productrovider.getProductsByHighlight(),
              ),
              SizedBox(
                height: getHeight(context, 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Brands".tr,
                    style: TextStyle(
                        color: mainColorBlack,
                        fontSize: 16,
                        fontFamily: mainFontbold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (productrovider.show) {
                            productrovider.settype("best");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const allBrands()),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "View All".tr,
                              style: TextStyle(color: mainColorRed),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context, 1),
              ),
              listitemsBrands(context, productrovider.brands),
              SizedBox(
                height: getHeight(context, 1),
              ),
              // Best Seller
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best Sell".tr,
                    style: TextStyle(
                        color: mainColorBlack,
                        fontSize: 16,
                        fontFamily: mainFontbold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (productrovider.show) {
                            productrovider.settype("best");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AllItem()),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "View All".tr,
                              style: TextStyle(color: mainColorRed),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              listItemsSmall(context, productrovider.getProductsByBestsell()),

              // Space
              SizedBox(
                height: getHeight(context, 2),
              ),

              Visibility(
                visible: productrovider.show,
                replacement: Skeletonizer(
                  effect: ShimmerEffect.raw(colors: [
                    mainColorGrey.withOpacity(0.1),
                    mainColorWhite,
                    // mainColorRed.withOpacity(0.1),
                  ]),
                  child: Container(
                      height: getHeight(context, 22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/Reklam.jpg",
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                child: GestureDetector(
                  onTap: () {
                    productrovider.settype("brand");
                    productrovider
                        .setidbrand(productrovider.tops.first.brandId!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllItem()),
                    );
                  },
                  child: Container(
                      height: getHeight(context, 22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: dotenv.env['imageUrlServer']! +
                              productrovider.tops.first.imgEn!,
                          placeholder: (context, url) =>
                              Image.asset("assets/images/Logo-Type-2.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/Logo-Type-2.png"),
                          filterQuality: FilterQuality.low,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
              ),
              // Space
              SizedBox(
                height: getHeight(context, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
