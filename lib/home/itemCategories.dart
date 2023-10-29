import 'package:athome/Config/my_widget.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:athome/Config/property.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'nav_switch.dart';

class itemCategories extends StatefulWidget {
  itemCategories();

  @override
  State<itemCategories> createState() => _itemCategoriesState();
}

class _itemCategoriesState extends State<itemCategories> {
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
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            namecategore,
            style: TextStyle(
                color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: mainColorWhite,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                productPro.setsubcateSelect(0);
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorRed,
              )),
          actions: [
            productPro.subcateSelect == 0
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      productPro.setsubcateSelect(0);
                    },
                    icon: Icon(
                      Icons.close,
                      color: mainColorRed,
                    ))
          ],

          // Change the color of the unselected tab labels
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: getWidth(context, 95),
                    height: getWidth(context, 9),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          productPro.getsubcateById(productPro.cateType).length,
                      itemBuilder: (BuildContext context, int index) {
                        final catesubitems = productPro
                            .getsubcateById(productPro.cateType)[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: GestureDetector(
                            onTap: () {
                              if (productPro.subcateSelect ==
                                  catesubitems.id!) {
                                productPro.setsubcateSelect(0);
                                namecategore = productPro
                                    .getCategoryNameById(productPro.cateType);
                              } else {
                                productPro.setsubcateSelect(catesubitems.id!);
                                namecategore = lang == "en"
                                    ? catesubitems.nameEn.toString()
                                    : lang == "ar"
                                        ? catesubitems.nameAr.toString()
                                        : catesubitems.nameKu.toString();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: getWidth(context, 1.5),
                                left: getWidth(context, 2),
                                right: getWidth(context, 2),
                                bottom: getWidth(context, 1),
                              ),
                              decoration: BoxDecoration(
                                  color: productPro.subcateSelect ==
                                          catesubitems.id!
                                      ? mainColorGrey
                                      : mainColorRed,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  lang == "en"
                                      ? catesubitems.nameEn.toString()
                                      : lang == "ar"
                                          ? catesubitems.nameAr.toString()
                                          : catesubitems.nameKu.toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: mainColorWhite,
                                      fontFamily: mainFontbold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 2),
                  ),
                  Container(
                    height: getHeight(context, 85),
                    width: getWidth(context, 95),
                    child: productPro.subcateSelect == 0
                        ? (productPro
                                .getProductsByCategory(productPro.cateType)
                                .isEmpty
                            ? Container(
                                width: getWidth(context, 100),
                                height: getWidth(context, 50),
                                child: Center(
                                  child: Text(
                                    "This list is empty",
                                    style: TextStyle(
                                        fontFamily: mainFontbold, fontSize: 16),
                                  ),
                                ),
                              )
                            : listItemsShow(
                                context,
                                productPro.getProductsByCategory(
                                    productPro.cateType)))
                        : (productPro
                                .getProductsBySubCategory(
                                    productPro.subcateSelect)
                                .isEmpty
                            ? Container(
                                width: getWidth(context, 100),
                                height: getWidth(context, 50),
                                child: Center(
                                  child: Text(
                                    "This list is empty",
                                    style: TextStyle(
                                        fontFamily: mainFontbold, fontSize: 16),
                                  ),
                                ),
                              )
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
        floatingActionButton: buildFAB(context),
      ),
    );
  }
}
