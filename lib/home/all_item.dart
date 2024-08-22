// Import necessary packages and libraries
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/my_cart.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../main.dart';

/// The `AllItem` widget displays a list of items based on different conditions such as discounts, 
/// brand selection, recent orders, or highlighted products.
class AllItem extends StatefulWidget {
  const AllItem({super.key});

  @override
  State<AllItem> createState() => _AllItemState();
}

class _AllItemState extends State<AllItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Access the product and cart providers to get data for products and cart items.
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    /// Determine the type of items to display based on the type stored in productPro.
    String type = productPro.allitemType;

    /// Get the name of the brand if the selected type is "brand", and localize it based on the language setting.
    String name = type == "brand"
        ? lang == "en"
            ? productPro.getonebrandById(productPro.idBrand).nameEn!
            : lang == "ar"
                ? productPro.getonebrandById(productPro.idBrand).nameAr!
                : productPro.getonebrandById(productPro.idBrand).nameKu!
        : "";

    /// Fetch products based on the selected type (discount, highlight, orders, brand, or bestseller).
    late List<ProductModel> products = type == "discount"
        ? productPro.getProductsByDiscount()
        : type == "Highlight"
            ? productPro.getProductsByHighlight2()
            : type == "orders"
                ? productPro.getProductsByIds(productPro.listOrderProductIds())
                : type == "brand"
                    ? productPro.getProductsByBrand(productPro.idBrand)
                    : productPro.getProductsByBestsell2();

    return Directionality(
      /// Set the text direction based on the selected language (LTR for English, RTL for other languages).
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        /// AppBar contains a dynamic title based on the selected product type, and back and cart icons.
        appBar: AppBar(
          title: Text(
            type == "discount"
                ? "Discount".tr
                : type == "Highlight"
                    ? "Highlight".tr
                    : type == "orders"
                        ? "Recent Order".tr
                        : type == "brand"
                            ? name
                            : "Best Sell".tr,
          ),
          leading: IconButton(
            onPressed: () {
              /// Navigate back to the previous page.
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            /// Display the shopping cart icon, with a badge showing the number of items in the cart if there are any.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () {
                  /// Navigate to the `MyCart` page.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCart(true)),
                  );
                },
                icon: cartProvider.cartItems.isNotEmpty
                    ? Badge(
                        /// Display the number of items in the cart.
                        label: Text(cartProvider.cartItems.length.toString()),
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
            ),
          ],
        ),

        /// The body of the screen displays a list of products using the `listItemsShow` widget.
        body: listItemsShow(context, products),
      ),
    );
  }
}
