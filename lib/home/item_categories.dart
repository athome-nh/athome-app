import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:dllylas/Config/property.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class itemCategories extends StatefulWidget {
  const itemCategories({super.key});

  @override
  State<itemCategories> createState() => _itemCategoriesState();
}

class _itemCategoriesState extends State<itemCategories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  update(BuildContext context, int data) {}
  bool first = true;
  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    String namecategore = productPro.getCategoryNameById(productPro.cateType);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            namecategore,
          ),

          leading: IconButton(
              onPressed: () {
                productPro.setsubcateSelect(0);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
          actions: [
            productPro.subcateSelect == 0
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      productPro.setsubcateSelect(0);
                    },
                    icon: const Icon(
                      Icons.close,
                    ))
          ],

          // Change the color of the unselected tab labels
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                productPro.getsubcateById(productPro.cateType).isNotEmpty
                    ? SizedBox(
                        width: getWidth(context, 95),
                        height: getWidth(context, 9),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productPro
                              .getsubcateById(productPro.cateType)
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            final catesubitems = productPro
                                .getsubcateById(productPro.cateType)[index];

                            return productPro
                                    .getProductsBySubCategory(catesubitems.id!)
                                    .isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 2)),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (productPro.subcateSelect ==
                                            catesubitems.id!) {
                                          productPro.setsubcateSelect(0);
                                          namecategore =
                                              productPro.getCategoryNameById(
                                                  productPro.cateType);
                                        } else {
                                          productPro.setsubcateSelect(
                                              catesubitems.id!);
                                          namecategore = lang == "en"
                                              ? catesubitems.nameEn.toString()
                                              : lang == "ar"
                                                  ? catesubitems.nameAr
                                                      .toString()
                                                  : catesubitems.nameKu
                                                      .toString();
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: getWidth(context, 1),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: productPro.subcateSelect ==
                                                      catesubitems.id!
                                                  ? mainColorGrey
                                                  : mainColorWhite,
                                              width:
                                                  2.0, // You can set the thickness of the border
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            lang == "en"
                                                ? catesubitems.nameEn.toString()
                                                : lang == "ar"
                                                    ? catesubitems.nameAr
                                                        .toString()
                                                    : catesubitems.nameKu
                                                        .toString(),
                                            maxLines: 2,
                                            style: TextStyle(
                                                color:
                                                    productPro.subcateSelect ==
                                                            catesubitems.id!
                                                        ? mainColorRed
                                                        : mainColorBlack,
                                                fontFamily: mainFontnormal,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                      )
                    : const SizedBox(),
                productPro.getsubcateById(productPro.cateType).isNotEmpty
                    ? SizedBox(
                        height: getHeight(context, 2),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: getHeight(
                      context,
                      productPro.getsubcateById(productPro.cateType).isNotEmpty
                          ? 82
                          : 89),
                  width: getWidth(context, 95),
                  child: productPro.subcateSelect == 0
                      ? (productPro
                              .getProductsByCategory(productPro.cateType)
                              .isEmpty
                          ? Center(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //textcheck
                                Image.asset("assets/Victors/empty.png"),
                                SizedBox(
                                  height: getHeight(context, 1),
                                ),
                                Text(
                                  "You not have any item".tr,
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: mainFontnormal),
                                ),
                              ],
                            ))
                          : listItemsShow(
                              context,
                              productPro
                                  .getProductsByCategory(productPro.cateType)))
                      : (productPro
                              .getProductsBySubCategory(
                                  productPro.subcateSelect)
                              .isEmpty
                          ? Center(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //textcheck
                                Image.asset("assets/Victors/empty.png"),
                                SizedBox(
                                  height: getHeight(context, 1),
                                ),
                                Text(
                                  "You not have any item".tr,
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: mainFontnormal),
                                ),
                              ],
                            ))
                          : listItemsShow(
                              context,
                              productPro.getProductsBySubCategory(
                                  productPro.subcateSelect),
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
