import 'package:athome/model/category_model/category_model.dart';
import 'package:athome/model/order_model/order_model.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:athome/model/products_image/products_image.dart';
import 'package:athome/model/sub_category/sub_category.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class productProvider extends ChangeNotifier {
  // List to store your products
  List<ProductModel> _products = [];
  List<CategoryModel> _categores = [];
  List<SubCategory> _subCategores = [];
  List<ProductsImage> _productimages = [];
  List<OrderModel> _Ordersitems = [];
  String _searchproduct = "";
  String _allitemType = "";
  int _cateType = 0;
  int _idItem = 0;
  int _subcateSelect = 0;
  // Getter to access the list of products
  List<OrderModel> get Ordersitems => _Ordersitems;
  List<ProductModel> get products => _products;
  List<CategoryModel> get categores => _categores;
  List<SubCategory> get subCategores => _subCategores;
  List<ProductsImage> get productimages => _productimages;
  String get searchproduct => _searchproduct;
  String get allitemType => _allitemType;
  int get cateType => _cateType;
  int get idItem => _idItem;
  int get subcateSelect => _subcateSelect;
  List<ProductModel> getProductsBySubCategory(int subcategory) {
    return _products
        .where((product) => product.subCategoryId == subcategory)
        .toList();
  }

  List<ProductModel> getProductsByCategory(int category) {
    return _products
        .where((product) => product.categoryId == category)
        .toList();
  }

  List<ProductModel> getProductsByDiscount() {
    return _products.where((product) => product.offerPrice! > -1).toList();
  }

  List<ProductsImage> getproductimages(int id) {
    return _productimages.where((product) => product.productId! == id).toList();
  }

  List<ProductModel> getProductsByBestsell() {
    return _products.where((product) => product.bestSell == 1).toList();
  }

  List<ProductModel> getProductsBySearch(String value) {
    return _products
        .where((product) =>
            // lang == "en"
            //         ? product.nameEn!.toLowerCase().contains(value.toLowerCase()) ==
            //             true
            //         : lang == "ar"
            //             ? product.nameAr!
            //                     .toLowerCase()
            //                     .contains(value.toLowerCase()) ==
            //                 true
            //             : product.nameKu!
            //                     .toLowerCase()
            //                     .contains(value.toLowerCase()) ==
            //                 true
            (product.nameEn! + product.nameAr! + product.nameKu!)
                .toLowerCase()
                .contains(value.toLowerCase()) ==
            true)
        .toList();
  }

  List<ProductModel> getProductsByHighlight() {
    return _products.where((product) => product.highlight == 1).toList();
  }

  List<ProductModel> getProductsByIds(List<int> idsToRetrieve) {
    return _products
        .where((product) => idsToRetrieve.contains(product.id))
        .toList();
  }

  List<SubCategory> getsubcateById(int idToRetrieve) {
    return _subCategores
        .where((subcate) => subcate.categoryId == idToRetrieve)
        .toList();
  }

  String getCategoryNameById(int categoryId) {
    final CategoryModel? category = _categores.firstWhere(
      (cat) => cat.id == categoryId,
    );

    return lang == "en"
        ? category!.nameEn.toString()
        : lang == "ar"
            ? category!.nameAr.toString()
            : category!.nameKu.toString() ?? 'Category Not Found';
  }

  ProductModel getoneProductById(int itemId) {
    final ProductModel? item = _products.firstWhere(
      (element) => element.id == itemId,
    );

    if (item == null) {
      throw Exception('Item with ID $itemId not found');
    }

    return item;
  }

  List<OrderModel> getordersbyOrderCode(String order_code) {
    return _Ordersitems.where(
        (product) => order_code.contains(product.orderCode!)).toList();
  }

  OrderModel getorderOnebyOrderCode(String order_code) {
    final OrderModel? item = _Ordersitems.firstWhere(
      (element) => element.orderCode == order_code,
    );

    if (item == null) {
      throw Exception('Item with ID $_Ordersitems not found');
    }

    return item;
  }

  int calculateTotalPriceOrder(String code) {
    int totalPrice = 0;
    int i = 0;
    for (var order in _Ordersitems) {
      if (order.orderCode == code) {
        totalPrice += order.sellPrice! * order.qt!;
      }
      i++;
    }

    return totalPrice;
  }

  List<String> listOrderCode() {
    List<String> orderPakageCode = [];

    _Ordersitems.forEach((element) {
      orderPakageCode.add(element.orderCode!);
    });

    return orderPakageCode.toSet().toList();
  }

  List<int> listOrderProductIds() {
    List<int> OrderProductId = [];
    _Ordersitems.forEach((element) {
      OrderProductId.add(element.productId!);
    });

    return OrderProductId.toSet().toList();
  }

  // Add a product to the list
  void setProducts(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  void setCategorys(List<CategoryModel> categores) {
    _categores = categores;
    notifyListeners();
  }

  void setsubCategorys(List<SubCategory> subCategores) {
    _subCategores = subCategores;
    notifyListeners();
  }

  void setOrdersitems(List<OrderModel> ordersitems) {
    _Ordersitems = ordersitems;

    notifyListeners();
  }

  void setproductimages(List<ProductsImage> productimages) {
    _productimages = productimages;
    notifyListeners();
  }

  void setsearch(String searchproduct) {
    _searchproduct = searchproduct;
    notifyListeners();
  }

  void settype(String allitemType) {
    _allitemType = allitemType;
    notifyListeners();
  }

  void setcatetype(int cateType) {
    _cateType = cateType;
    notifyListeners();
  }

  void setidItem(int idItem) {
    _idItem = idItem;
    notifyListeners();
  }

  void setsubcateSelect(int subcateSelect) {
    _subcateSelect = subcateSelect;
    notifyListeners();
  }
}
