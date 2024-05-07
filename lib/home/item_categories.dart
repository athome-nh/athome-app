import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class itemCategories extends StatefulWidget {
  const itemCategories({Key? key}) : super(key: key);

  @override
  State<itemCategories> createState() => _itemCategoriesState();
}

class _itemCategoriesState extends State<itemCategories>
    with TickerProviderStateMixin {
  late TabController _categoryTabController;
  late TabController _subcategoryTabController;

  int selectedCategoryIndex = 0;
  int selectedSubcategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    final productPro = Provider.of<productProvider>(context, listen: false);

    _categoryTabController = TabController(
        length: productPro.categores.length,
        initialIndex: productPro.categores
            .indexWhere((category) => category.id == productPro.cateType),
        vsync: this,
        animationDuration: Duration(milliseconds: 300));

    _subcategoryTabController = TabController(
        length: productPro.getsubcateById(productPro.cateType).length + 1,
        vsync: this,
        animationDuration: Duration(milliseconds: 300));

    _categoryTabController.addListener(() {
      setState(() {
        _subcategoryTabController.index = 0;
        selectedSubcategoryIndex = 0;
        selectedCategoryIndex = _categoryTabController.index;
        productPro.setcatetype(productPro.categores[selectedCategoryIndex].id!);
        _updateSubcategoryTabControllerLength(productPro);
      });
    });

    _subcategoryTabController.addListener(() {
      setState(() {
        selectedSubcategoryIndex = _subcategoryTabController.index;
        if (selectedSubcategoryIndex > 0) {
          final subCategoryIndex = selectedSubcategoryIndex - 1;
          productPro.setsubcateSelect(productPro
              .getsubcateById(productPro.cateType)[subCategoryIndex]
              .id!);
        }
      });
    });
  }

  void _updateSubcategoryTabControllerLength(productProvider productPro) {
    // Dispose the previous subcategory TabController
    _subcategoryTabController.dispose();

    // Create a new subcategory TabController with updated length
    _subcategoryTabController = TabController(
      length: productPro.getsubcateById(productPro.cateType).length + 1,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    String categoryName = productPro.getCategoryNameById(productPro.cateType);
    final subcategoriesWithProducts =
        productPro.getsubcateById(productPro.cateType).toList();
    final allProducts = productPro.getProductsByCategory(productPro.cateType);

    return DefaultTabController(
      length: subcategoriesWithProducts.length + 1,
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
                splashFactory: NoSplash.splashFactory,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 10),
                unselectedLabelColor: mainColorGrey,

                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: mainColorGrey, // Set your desired color here
                      width: 3.0, // Set the width of the border
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(10), // Adjust the radius as needed
                    bottomRight:
                        Radius.circular(10), // Adjust the radius as needed
                  ),
                ),
                // dividerColor: mainColorGrey.withOpacity(0.05),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                controller: _categoryTabController,

                labelStyle: TextStyle(fontFamily: mainFontnormal),
                // indicator: BoxDecoration(),
                tabs: productPro.categores.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: getTab(
                        lang == "en"
                            ? category.nameEn!
                            : lang == "ar"
                                ? category.nameAr!
                                : category.nameKu!,
                        category.img!),
                  );
                }).toList(),
              ),
              Material(
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: TabBar(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    unselectedLabelColor: mainColorGrey,
                    labelColor: mainColorWhite,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColorGrey),
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    labelStyle: lang == "en"
                        ? TextStyle()
                        : TextStyle(fontFamily: mainFontnormal),
                    controller: _subcategoryTabController,
                    tabs: [
                      Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: mainColorGrey.withOpacity(0.3),
                                  width: 1)),
                          child: Align(
                              alignment: Alignment.center,
                              child: Tab(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text('All Items'.tr),
                              )))),
                      ...subcategoriesWithProducts.map((subCategory) {
                        return Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: mainColorGrey.withOpacity(0.3),
                                  width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Tab(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  lang == "en"
                                      ? subCategory.nameEn.toString()
                                      : lang == "ar"
                                          ? subCategory.nameAr.toString()
                                          : subCategory.nameKu.toString(),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _subcategoryTabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: listItemsShow(context, allProducts),
                    ),
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

  Tab getTab(String tabtitle, String imagepath) {
    return Tab(
      icon: CachedNetworkImage(
        imageUrl: dotenv.env['imageUrlServer']! + imagepath,
        placeholder: (context, url) =>
            Image.asset("assets/images/Logo-Type-2.png"),
        errorWidget: (context, url, error) =>
            Image.asset("assets/images/Logo-Type-2.png"),
        filterQuality: FilterQuality.low,
        width: getHeight(context, 5),
        height: getHeight(context, 5),
      ),
      iconMargin: EdgeInsets.all(0),
      text: tabtitle,
    );
  }
}
