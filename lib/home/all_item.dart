import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../main.dart';

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
    final productPro = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    String type = productPro.allitemType;
    String name = type == "brand"
        ? lang == "en"
            ? productPro.getonebrandById(productPro.idItem).nameEn!
            : lang == "ar"
                ? productPro.getonebrandById(productPro.idItem).nameAr!
                : productPro.getonebrandById(productPro.idItem).nameKu!
        : "";

    late List<ProductModel> products = type == "discount"
        ? productPro.getProductsByDiscount()
        : type == "Highlight"
            ? productPro.getProductsByHighlight2()
            : type == "orders"
                ? productPro.getProductsByIds(productPro.listOrderProductIds())
                : type == "brand"
                    ? productPro.getProductsByBrand(productPro.idItem)
                    : productPro.getProductsByBestsell2();

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
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
            style: TextStyle(
                color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: mainColorWhite,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorRed,
              )),

          // Change the color of the unselected tab labels
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8 ),
          child: listItemsShow(context, products),
        ),
        //floatingActionButton: buildFAB(context),
      ),
    );
  }
}
