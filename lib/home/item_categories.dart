// Import necessary packages and libraries
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../main.dart';

/// `itemCategories` is a StatefulWidget that displays items categorized by categories and subcategories.
class itemCategories extends StatefulWidget {
  // The ID of the selected subcategory
  int subcateID = 0;

  /// The [subcateID] parameter sets the ID of the selected subcategory.
  itemCategories({this.subcateID = 0, Key? key}) : super(key: key);

  @override
  State<itemCategories> createState() => _itemCategoriesState();
}

class _itemCategoriesState extends State<itemCategories>
    with TickerProviderStateMixin {
  // Controllers for managing tab selection
  late TabController _categoryTabController;
  late TabController _subcategoryTabController;

  // Indices for selected category and subcategory
  int selectedCategoryIndex = 0;
  int selectedSubcategoryIndex = 0;

  @override
  void initState() {
    super.initState();

    // Access product provider to initialize tab controllers
    final productPro = Provider.of<productProvider>(context, listen: false);

    // Initialize the category tab controller
    _categoryTabController = TabController(
        length: productPro.categores.length,
        initialIndex: productPro.categores
            .indexWhere((category) => category.id == productPro.cateType),
        vsync: this,
        animationDuration: Duration(milliseconds: 300));

    // Initialize the subcategory tab controller
    _subcategoryTabController = TabController(
        length: productPro.getsubcateById(productPro.cateType).length + 1,
        initialIndex: widget.subcateID != 0
            ? productPro.getsubcateById(productPro.cateType).indexWhere(
                    (subCategory) => subCategory.id == widget.subcateID) +
                1 : 0,
        vsync: this,
        animationDuration: Duration(milliseconds: 300));

    // Listener for category tab changes
    _categoryTabController.addListener(() {
      setState(() {
        _subcategoryTabController.index = 0;
        selectedSubcategoryIndex = 0;
        selectedCategoryIndex = _categoryTabController.index;
        productPro.setcatetype(productPro.categores[selectedCategoryIndex].id!);
        _updateSubcategoryTabControllerLength(productPro);
      });
    });

    // Listener for subcategory tab changes
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

  /// Updates the length of the subcategory tab controller when the number of subcategories changes.
  void _updateSubcategoryTabControllerLength(productProvider productPro) {
    _subcategoryTabController.dispose();
    _subcategoryTabController = TabController(
      length: productPro.getsubcateById(productPro.cateType).length + 1,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access product provider and cart provider
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    // Get the category name and products
    String categoryName = productPro.getCategoryNameById(productPro.cateType);
    final subcategoriesWithProducts =
        productPro.getsubcateById(productPro.cateType).toList();
    final allProducts = productPro.getProductsByCategory(productPro.cateType);

    return DefaultTabController(
      // Set the number of tabs for the DefaultTabController
      length: subcategoriesWithProducts.length + 1,
      child: Directionality(
        textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(categoryName.tr),
            leading: IconButton(
              onPressed: () {
                productPro.setsubcateSelect(0);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCart(true)),
                    );
                  },
                  icon: cartProvider.cartItems.isNotEmpty
                      ? Badge(
                          label: Text(
                            cartProvider.cartItems.length.toString(),
                          ),
                          backgroundColor: mainColorRed,
                          child: Icon(
                            size: 30,
                            LineIcons.shoppingCart,
                            color: mainColorGrey,
                          ),
                        )
                      : Icon(
                          size: 30,
                          LineIcons.shoppingCart,
                          color: mainColorGrey,
                        ),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              // TabBar for categories
              TabBar(
                splashFactory: NoSplash.splashFactory,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 10),
                unselectedLabelColor: mainColorGrey,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: mainColorGrey,
                      width: 3.0,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                controller: _categoryTabController,
                labelStyle: TextStyle(fontFamily: mainFontnormal),
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
              // TabBar for subcategories
              Material(
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: TabBar(
                    physics: const ClampingScrollPhysics(),
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
              // Display products based on selected tab
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

  /// The [tabtitle] parameter is the text displayed on the tab, and [imagepath] is the path to the icon image.
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
