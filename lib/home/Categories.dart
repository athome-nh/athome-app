import 'package:athome/Config/value.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/item_categories.dart';
import 'package:athome/main.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:athome/Config/property.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    late List<ProductModel> products = productPro.products;

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            "All Categories".tr,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getHeight(context, 90),
                width: getWidth(context, 100),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: getWidth(context, 0.25),

                    crossAxisCount: 3, // Number of columns
                  ),
                  itemCount: productPro
                      .categores.length, // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    final cateItem = productPro.categores[index];
                    // Build each grid item here
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            productPro.setcatetype(cateItem.id!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => itemCategories()),
                            ).then((value) {
                              productPro.setsubcateSelect(0);
                            });
                          },
                          child: Container(
                            width: getHeight(context, 10),
                            height: getHeight(context, 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: mainColorBlack.withOpacity(0.1)),
                                // color: mainColorLightGrey,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: imageUrlServer + cateItem.img!,
                                placeholder: (context, url) => Image.asset(
                                    "assets/images/Logo-Type-2.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        "assets/images/Logo-Type-2.png"),
                                filterQuality: FilterQuality.low,
                                width: getHeight(context, 6),
                                height: getHeight(context, 6),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          lang == "en"
                              ? cateItem.nameEn!
                              //cateItem.nameEn!
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
