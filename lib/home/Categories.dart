import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Config/property.dart';
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
              icon: const Icon(
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
                    childAspectRatio: getWidth(context, 0.20),

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
                            width: getHeight(context, 12),
                            height: getHeight(context, 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: mainColorBlack.withOpacity(0.1)),
                                // color: mainColorLightGrey,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: dotenv.env['imageUrlServer']! +
                                    cateItem.img!,
                                placeholder: (context, url) => Image.asset(
                                    "assets/images/Logo-Type-2.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        "assets/images/Logo-Type-2.png"),
                                filterQuality: FilterQuality.low,
                                width: getHeight(context, 9),
                                height: getHeight(context, 9),
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
