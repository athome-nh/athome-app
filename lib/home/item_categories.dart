import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import '../main.dart';

class itemCategories extends StatefulWidget {
  const itemCategories({Key? key}) : super(key: key);

  @override
  State<itemCategories> createState() => _itemCategoriesState();
}

class _itemCategoriesState extends State<itemCategories> {
  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    String categoryName = productPro.getCategoryNameById(productPro.cateType);

    // Filter out subcategories with no products
    final subcategoriesWithProducts = productPro
        .getsubcateById(productPro.cateType)
        .where((subCategory) =>
            productPro.getProductsBySubCategory(subCategory.id!).isNotEmpty)
        .toList();
// Get all products in the category
    final allProducts = productPro.getProductsByCategory(productPro.cateType);
    return DefaultTabController(
      length: subcategoriesWithProducts.length + 1, // Corrected the length
      child: Directionality(
        textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(categoryName),
            leading: IconButton(
              onPressed: () {
                productPro.setsubcateSelect(0);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            actions: [],
          ),
          body: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: [
                  // Additional tab for all items
                  Tab(
                    child: Text('All Items'.tr),
                  ),
                  ...subcategoriesWithProducts.map((subCategory) {
                    return Tab(
                      child: Text(
                        lang == "en"
                            ? subCategory.nameEn.toString()
                            : lang == "ar"
                                ? subCategory.nameAr.toString()
                                : subCategory.nameKu.toString(),
                      ),
                    );
                  }).toList(),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Content for all items
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: listItemsShow(context, allProducts),
                    ),
                    // Content for subcategories
                    ...subcategoriesWithProducts.map((subCategory) {
                      final products =
                          productPro.getProductsBySubCategory(subCategory.id!);
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: listItemsShow(context, products),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
