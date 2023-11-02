import 'dart:convert';
import 'dart:io';

import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Network/Network.dart';

import 'package:athome/landing/splash_screen.dart';
import 'package:athome/main.dart';
import 'package:athome/model/brandmodel/brandmodel.dart';
import 'package:athome/model/category_model/category_model.dart';
import 'package:athome/model/location/location.dart';
import 'package:athome/model/order_items/order_items.dart';
import 'package:athome/model/order_model/order_model.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:athome/model/products_image/products_image.dart';
import 'package:athome/model/slidemodel/slidemodel.dart';
import 'package:athome/model/sub_category/sub_category.dart';
import 'package:athome/model/topmodel/topmodel.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class productProvider extends ChangeNotifier {
  productProvider() {
    // loadPostData();
    //  updatePost();
  }

  loadPostData() async {
    final directory = await getTemporaryDirectory();
    String path = "${directory.path}/dict.json";
    File f = File(path);

    if (f.existsSync()) {
      final jsonData = f.readAsStringSync();
      var data = json.decode(decryptAES(jsonData));
      setProducts((data['products'] as List)
          .map((x) => ProductModel.fromMap(x))
          .toList());
      setCategorys((data['category'] as List)
          .map((x) => CategoryModel.fromMap(x))
          .toList());
      setsubCategorys((data['subCategory'] as List)
          .map((x) => SubCategory.fromMap(x))
          .toList());
      setproductimages((data['productsImage'] as List)
          .map((x) => ProductsImage.fromMap(x))
          .toList());
      setOrders(
          (data['orders'] as List).map((x) => OrderModel.fromMap(x)).toList());
      setOrderItems((data['orders_item'] as List)
          .map((x) => OrderItems.fromMap(x))
          .toList());
      setlocation((data['locations'] as List)
          .map((x) => Locationuser.fromMap(x))
          .toList());
      return data;
    } else {
      var d = [];
      return d;
    }
  }

  getDataAll(bool user) {
    print("Start");
    Network(false).getData("showData").then((value) async {
      if (value != "") {
        if (value["code"] != 200) {
          setProducts((value['products'] as List)
              .map((x) => ProductModel.fromMap(x))
              .toList());
          setCategorys((value['category'] as List)
              .map((x) => CategoryModel.fromMap(x))
              .toList());
          setsubCategorys((value['subCategory'] as List)
              .map((x) => SubCategory.fromMap(x))
              .toList());
          setproductimages((value['productsImage'] as List)
              .map((x) => ProductsImage.fromMap(x))
              .toList());
          setslides((value['slide'] as List)
              .map((x) => Slidemodel.fromMap(x))
              .toList());
          settops((value['top_image'] as List)
              .map((x) => Topmodel.fromMap(x))
              .toList());
          setbrands((value['brands'] as List)
              .map((x) => Brandmodel.fromMap(x))
              .toList());
          if (user) {
            getDataUser(userdata["id"].toString());
          }
          setshow(true);
          print("end");
        } else {}
      } else {}
    });
  }

  getDataUser(String id) {
    print("Start");
    Network(false).getData("showDataUser/" + id).then((value) async {
      if (value != "") {
        if (value["code"] != 200) {
          setlocation((value['locations'] as List)
              .map((x) => Locationuser.fromMap(x))
              .toList());
          setOrders((value['orders'] as List)
              .map((x) => OrderModel.fromMap(x))
              .toList());
          setOrderItems((value['orders_item'] as List)
              .map((x) => OrderItems.fromMap(x))
              .toList());
          setshow(true);
          print("end");
        } else {}
      } else {}
    });
  }

  updatePost(bool user) async {
    if (isLogin) {
      Network(false).getDatauser("userInfo", token).then((valueuser) {
        if (valueuser != "") {
          if (valueuser["code"] == "201") {
            userdata = valueuser["data"][0];

            getDataAll(user);
          }
        }
      });
    } else {
      getDataAll(user);
    }
  }

  // getPost() async {
  //   print("object");
  //   String ordeid = userData["id"].toString();
  //   Network(false).getData("showData/" + ordeid).then((value) async {
  //     if (value != "") {
  //       if (value["code"] != 200) {
  //         var jsonString = json.encode(value);
  //         final directory = await getTemporaryDirectory();
  //         String path = "${directory.path}/dict.json";
  //         var jsonList = json.decode(jsonString);
  //         setProducts((jsonList['products'] as List)
  //             .map((x) => ProductModel.fromMap(x))
  //             .toList());
  //         setCategorys((jsonList['category'] as List)
  //             .map((x) => CategoryModel.fromMap(x))
  //             .toList());
  //         setsubCategorys((jsonList['subCategory'] as List)
  //             .map((x) => SubCategory.fromMap(x))
  //             .toList());
  //         setproductimages((jsonList['productsImage'] as List)
  //             .map((x) => ProductsImage.fromMap(x))
  //             .toList());
  //         setOrders((jsonList['orders'] as List)
  //             .map((x) => OrderModel.fromMap(x))
  //             .toList());
  //         setOrderItems((jsonList['orders_item'] as List)
  //             .map((x) => OrderItems.fromMap(x))
  //             .toList());
  //         setlocation((jsonList['locations'] as List)
  //             .map((x) => Locationuser.fromMap(x))
  //             .toList());
  //         print("retrive data");
  //         File f = File(path);
  //         f.writeAsStringSync(encryptAES(jsonString),
  //             flush: true, mode: FileMode.write);
  //       } else {}
  //     } else {}
  //   });
  // }

  // List to store your products
  // var userdata = {};
  List<Topmodel> _tops = [];
  List<Slidemodel> _slides = [];
  List<Brandmodel> _brands = [];
  List<ProductModel> _products = [];
  List<CategoryModel> _categores = [];
  List<SubCategory> _subCategores = [];
  List<ProductsImage> _productimages = [];
  List<OrderModel> _Orders = [];
  List<OrderItems> _Orderitems = [];
  List<Locationuser> _location = [];
  late Locationuser _defultlocation;
  String _searchproduct = "";
  String _allitemType = "";
  int _cateType = 0;
  int _idItem = 0;
  int _subcateSelect = 0;
  bool show = false;
  // Getter to access the list of products
  List<Topmodel> get tops => _tops;

  List<Slidemodel> get slides => _slides;
  List<Brandmodel> get brands => _brands;
  List<OrderItems> get Orderitems => _Orderitems;
  List<Locationuser> get location => _location;
  List<OrderModel> get Orders => _Orders;
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

  List<ProductModel> getProductsByBrand(int brand) {
    return _products.where((product) => product.brandIid! == brand).toList();
  }

  List<ProductsImage> getproductimages(int id) {
    return _productimages.where((product) => product.productId! == id).toList();
  }

  List<ProductModel> getProductsByBestsell() {
    return _products
        .where((product) => product.bestSell == 1 && product.offerPrice == -1)
        .toList();
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
    return _products
        .where((product) => product.highlight == 1 && product.offerPrice == -1)
        .toList();
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

  Brandmodel getonebrandById(int itemId) {
    final Brandmodel? item = _brands.firstWhere(
      (element) => element.id == itemId,
    );

    if (item == null) {
      throw Exception('Item with ID $itemId not found');
    }

    return item;
  }

  List<OrderItems> getordersbyOrderCode(String order_code) {
    return _Orderitems.where(
        (product) => order_code.contains(product.orderCode!)).toList();
  }

  void updateOrder(int oid, int status) {
    final index = Orders.indexWhere((product) => product.id == oid);
    if (index != -1) {
      Orders[index].status = status;
      notifyListeners();
    } else {
      // Handle the case where the product with the specified ID is not found.
      print('Product with ID ${oid} not found.');
    }
  }

  OrderItems getorderitemsOnebyId(int id) {
    final OrderItems? item = _Orderitems.firstWhere(
      (element) => element.productId == id,
    );

    if (item == null) {
      throw Exception('Item with ID $_Orders not found');
    }

    return item;
  }

  OrderModel getorderOnebyOrderCode(String order_code) {
    final OrderModel? item = _Orders.firstWhere(
      (element) => element.orderCode == order_code,
    );

    if (item == null) {
      throw Exception('Item with ID $_Orders not found');
    }

    return item;
  }

  int calculateTotalPriceOrder(String code) {
    int totalPrice = 0;
    int i = 0;
    for (var order in _Orderitems) {
      if (order.orderCode == code) {
        totalPrice += order.sellPrice! * order.qt!;
      }
      i++;
    }

    return totalPrice;
  }

  List<String> listOrderCode() {
    List<String> orderPakageCode = [];

    _Orders.forEach((element) {
      orderPakageCode.add(element.orderCode!);
    });

    return orderPakageCode.toSet().toList();
  }

  List<int> listOrderProductIds() {
    List<int> OrderProductId = [];
    _Orderitems.forEach((element) {
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

  void setOrders(List<OrderModel> orders) {
    _Orders = orders;

    notifyListeners();
  }

  void setslides(List<Slidemodel> slide) {
    _slides = slide;

    notifyListeners();
  }

  void settops(List<Topmodel> top) {
    _tops = top;

    notifyListeners();
  }

  void setbrands(List<Brandmodel> brand) {
    _brands = brand;

    notifyListeners();
  }

  void setOrderItems(List<OrderItems> orderitems) {
    _Orderitems = orderitems;

    notifyListeners();
  }

  void setproductimages(List<ProductsImage> productimages) {
    _productimages = productimages;
    notifyListeners();
  }

  void setlocation(List<Locationuser> location) {
    _location = location;
    notifyListeners();
  }

  void addlocation(Locationuser location) {
    _location.add(location);
    notifyListeners();
  }

  Locationuser getonelocationById(int itemId) {
    Locationuser item = _location.firstWhere(
      (element) => element.id == itemId,
    );

    if (item == null) {
      throw Exception('Item with ID $itemId not found');
    }

    return item;
  }

  void deletelocation(int location) {
    final existingItemIndex = _location.indexWhere(
      (item) => item.id == location,
    );
    _location.removeAt(existingItemIndex);

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

  void setdefultlocation(int id) {
    if (id == -1) {
      _defultlocation = _location[_location.length - 1];
    } else {
      _defultlocation = _location.firstWhere(
        (element) => element.id == id,
      );
    }

    notifyListeners();
  }

  void setsubcateSelect(int subcateSelect) {
    _subcateSelect = subcateSelect;
    notifyListeners();
  }

  void setshow(bool value) {
    show = value;

    notifyListeners();
  }
}
