// Import necessary packages and libraries
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Config/property.dart';
import 'package:provider/provider.dart';

/// The `Categories` widget displays a grid of categories, allowing the user to 
/// navigate to items within the selected category.
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
    /// Access the product provider to get categories and other product data.
    final productPro = Provider.of<productProvider>(context, listen: true);

    return Directionality(
      /// Set the text direction based on the language setting (LTR for English, RTL for others).
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            "All Categories".tr,  // Localized title for the AppBar
          ),
          leading: IconButton(
            onPressed: () {
              /// Navigate back to the previous screen.
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SizedBox(
          /// Set the size of the grid container dynamically based on screen size.
          height: getHeight(context, 90),
          width: getWidth(context, 100),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
            child: GridView.builder(
              /// Define a grid layout with two columns and a fixed aspect ratio for each item.
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: getWidth(context, 0.25),
                crossAxisCount: 2,
              ),
              itemCount: productPro.categores.length,  // Number of categories to display
              itemBuilder: (BuildContext context, int index) {
                /// Get the category item at the current index.
                final cateItem = productPro.categores[index];

                /// Pick a random color for the category tile background.
                final randomColor = categoryColors[index % categoryColors.length];

                return GestureDetector(
                  onTap: () {
                    /// Set the selected category type and navigate to the `itemCategories` screen.
                    productPro.setcatetype(cateItem.id!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => itemCategories()),
                    ).then((value) {
                      /// Reset the selected subcategory when returning from the category screen.
                      productPro.setsubcateSelect(0);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: getHeight(context, 20),
                      height: getHeight(context, 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColorBlack.withOpacity(0.2)),
                        color: randomColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Display the category image using a cached network image.
                          CachedNetworkImage(
                            imageUrl: dotenv.env['imageUrlServer']! + cateItem.img!,
                            placeholder: (context, url) =>
                                Image.asset("assets/images/Logo-Type-2.png"),  // Placeholder image
                            errorWidget: (context, url, error) =>
                                Image.asset("assets/images/Logo-Type-2.png"),  // Error image
                            filterQuality: FilterQuality.low,
                            width: getHeight(context, 15),
                            height: getHeight(context, 15),
                          ),
                          const SizedBox(height: 10),
                          /// Display the category name in the appropriate language.
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
                              fontFamily: mainFontbold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
